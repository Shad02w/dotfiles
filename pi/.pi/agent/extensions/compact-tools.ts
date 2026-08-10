import type { ExtensionAPI, ToolDefinition } from "@earendil-works/pi-coding-agent";
import {
  createBashToolDefinition,
  createEditToolDefinition,
  createFindToolDefinition,
  createGrepToolDefinition,
  createLsToolDefinition,
  createReadToolDefinition,
  createWriteToolDefinition,
  keyHint,
} from "@earendil-works/pi-coding-agent";
import { Box, Container, Text, type Component } from "@earendil-works/pi-tui";
import { urlContext, UrlContextSchema } from "../npm/node_modules/pi-web-search/src/url_context.ts";
import { webSearch, WebSearchSchema } from "../npm/node_modules/pi-web-search/src/web_search.ts";

type ToolTiming = {
  startedAt: number;
  finishedAt?: number;
  failed?: boolean;
};

type RendererState = {
  expandedCall?: Component;
  expandedResult?: Component;
};

const empty = (): Container => new Container();

function toolBackground(theme: any, context: any): (text: string) => string {
  if (context.isPartial) return (text: string) => theme.bg("toolPendingBg", text);
  if (context.isError) return (text: string) => theme.bg("toolErrorBg", text);
  return (text: string) => theme.bg("toolSuccessBg", text);
}

function toolBox(component: Component, theme: any, context: any, paddingY: number): Box {
  const box = new Box(1, paddingY, toolBackground(theme, context));
  box.addChild(component);
  return box;
}

function formatElapsed(milliseconds: number): string {
  if (milliseconds < 1_000) return `${milliseconds}ms`;
  if (milliseconds < 60_000) return `${(milliseconds / 1_000).toFixed(milliseconds < 10_000 ? 1 : 0)}s`;
  return `${Math.floor(milliseconds / 60_000)}m ${Math.round((milliseconds % 60_000) / 1_000)}s`;
}

function truncate(value: string, limit = 80): string {
  const singleLine = value.replace(/\s+/g, " ").trim();
  return singleLine.length > limit ? `${singleLine.slice(0, limit - 1)}…` : singleLine;
}

function describeCall(toolName: string, args: any): string {
  if (!args || typeof args !== "object") return "";

  switch (toolName) {
    case "read":
    case "write":
    case "edit":
      return truncate(String(args.path ?? ""));
    case "bash":
      return truncate(String(args.command ?? ""));
    case "grep": {
      const location = args.path ? ` in ${args.path}` : "";
      return truncate(`${args.pattern ?? ""}${location}`);
    }
    case "find": {
      const location = args.path ? ` in ${args.path}` : "";
      return truncate(`${args.pattern ?? ""}${location}`);
    }
    case "ls":
      return truncate(String(args.path ?? "."));
    case "web_search":
      return truncate(String(args.query ?? ""));
    case "url_context": {
      const count = Array.isArray(args.urls) ? args.urls.length : 0;
      return truncate(`${args.query ?? ""}${count ? ` · ${count} URL${count === 1 ? "" : "s"}` : ""}`);
    }
    default:
      return truncate(JSON.stringify(args));
  }
}

function formatCompactLine(
  toolName: string,
  args: unknown,
  timing: ToolTiming | undefined,
  theme: Parameters<NonNullable<ToolDefinition["renderCall"]>>[1],
): string {
  let status: string;
  if (!timing) {
    status = theme.fg("muted", "waiting");
  } else {
    const elapsed = formatElapsed((timing.finishedAt ?? Date.now()) - timing.startedAt);
    if (timing.finishedAt === undefined) status = theme.fg("warning", `running · ${elapsed}`);
    else if (timing.failed) status = theme.fg("error", `failed · ${elapsed}`);
    else status = theme.fg("success", `ok · ${elapsed}`);
  }

  const description = describeCall(toolName, args);
  const hint = theme.fg("dim", ` (${keyHint("app.tools.expand", "expand")})`);
  return [
    theme.fg("toolTitle", `▸ ${toolName}`),
    theme.fg("muted", " ("),
    status,
    theme.fg("muted", ")"),
    description ? theme.fg("muted", `: ${description}`) : "",
    hint,
  ].join("");
}

function rawResult(result: any, theme: Parameters<NonNullable<ToolDefinition["renderCall"]>>[1]): Component {
  const output = Array.isArray(result?.content)
    ? result.content
        .filter((part: any) => part?.type === "text" && typeof part.text === "string")
        .map((part: any) => part.text)
        .join("\n")
    : "";
  return output ? new Text(theme.fg("toolOutput", output), 0, 0) : empty();
}

function makeSeparateTool<T extends ToolDefinition<any, any>>(
  tool: T,
  timings: Map<string, ToolTiming>,
  invalidators: Map<string, () => void>,
): T {
  const originalRenderCall = tool.renderCall?.bind(tool);
  const originalRenderResult = tool.renderResult?.bind(tool);

  return {
    ...tool,
    renderShell: "self",
    renderCall(args: any, theme, context) {
      invalidators.set(context.toolCallId, context.invalidate);

      if (!context.expanded) {
        return new Text(formatCompactLine(tool.name, args, timings.get(context.toolCallId), theme), 1, 0);
      }

      if (!originalRenderCall) {
        const serialized = JSON.stringify(args, null, 2);
        const component = new Text(
          `${theme.fg("toolTitle", theme.bold(tool.name))}${serialized ? `\n\n${theme.fg("toolOutput", serialized)}` : ""}`,
          0,
          0,
        );
        return toolBox(component, theme, context, 1);
      }

      const state = context.state as RendererState;
      const component = originalRenderCall(args, theme, {
        ...context,
        lastComponent: state.expandedCall,
      });
      state.expandedCall = component;
      return toolBox(component, theme, context, 1);
    },
    renderResult(result: any, options, theme, context) {
      if (!context.expanded) return empty();

      if (!originalRenderResult) {
        return toolBox(rawResult(result, theme), theme, context, 0);
      }

      const state = context.state as RendererState;
      const component = originalRenderResult(result, options, theme, {
        ...context,
        lastComponent: state.expandedResult,
      });
      state.expandedResult = component;
      return toolBox(component, theme, context, 0);
    },
  } as T;
}

export default function separateTools(pi: ExtensionAPI): void {
  const timings = new Map<string, ToolTiming>();
  const invalidators = new Map<string, () => void>();

  pi.on("tool_execution_start", (event) => {
    timings.set(event.toolCallId, { startedAt: Date.now() });
    invalidators.get(event.toolCallId)?.();
  });

  pi.on("tool_execution_end", (event) => {
    const timing = timings.get(event.toolCallId);
    if (timing) {
      timing.finishedAt = Date.now();
      timing.failed = event.isError;
    }
    invalidators.get(event.toolCallId)?.();
  });

  pi.on("session_start", (_event, ctx) => {
    timings.clear();
    invalidators.clear();

    const tools: ToolDefinition<any, any>[] = [
      createReadToolDefinition(ctx.cwd),
      createBashToolDefinition(ctx.cwd),
      createEditToolDefinition(ctx.cwd),
      createWriteToolDefinition(ctx.cwd),
      createGrepToolDefinition(ctx.cwd),
      createFindToolDefinition(ctx.cwd),
      createLsToolDefinition(ctx.cwd),
      {
        name: "web_search",
        label: "Web Search",
        description:
          "Search the web using the current supported provider (Google Gemini, OpenAI, or Anthropic). Optionally include URLs to analyze alongside search results.",
        parameters: WebSearchSchema,
        execute: webSearch,
      },
      {
        name: "url_context",
        label: "URL Context",
        description:
          "Analyze the content of up to 20 public URLs using Gemini URL Context. Supports web pages, documents, images, and YouTube videos.",
        parameters: UrlContextSchema,
        execute: urlContext,
      },
    ];

    for (const tool of tools) {
      pi.registerTool(makeSeparateTool(tool, timings, invalidators));
    }

    ctx.ui.setToolsExpanded(false);
    ctx.ui.notify(`Separate compact tool calls enabled. ${keyHint("app.tools.expand", "expand output")}`, "info");
  });
}
