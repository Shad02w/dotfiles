import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

/**
 * Inserts a dynamic spacer above Pi's editor so the editor + footer stay at
 * the bottom of the terminal when the conversation is shorter than the screen.
 */
class PinInputBottomSpacer {
  constructor(private readonly tui: any) {}

  render(width: number): string[] {
    const rows = this.tui?.terminal?.rows ?? process.stdout.rows ?? 0;
    if (!rows || rows <= 0) return [];

    const otherLineCount = countRenderedLinesExcept(this.tui, width, this);
    const spacerLines = Math.max(0, rows - otherLineCount);

    return Array.from({ length: spacerLines }, () => "");
  }

  invalidate(): void {
    // Nothing cached.
  }
}

function countRenderedLinesExcept(component: any, width: number, skip: unknown): number {
  if (!component || component === skip) return 0;

  // Pi's top-level TUI and containers expose children. Walk them directly so
  // rendering this spacer does not recursively render itself.
  if (Array.isArray(component.children)) {
    return component.children.reduce(
      (sum: number, child: any) => sum + countRenderedLinesExcept(child, width, skip),
      0,
    );
  }

  if (typeof component.render !== "function") return 0;

  try {
    const lines = component.render(width);
    return Array.isArray(lines) ? lines.length : 0;
  } catch {
    // If a transient component cannot be measured, fail open: don't add space
    // based on that component rather than breaking the whole UI render.
    return 0;
  }
}

export default function (pi: ExtensionAPI) {
  pi.on("session_start", (_event, ctx) => {
    if (ctx.mode !== "tui") return;

    ctx.ui.setWidget(
      "pin-input-bottom-spacer",
      (tui: any) => new PinInputBottomSpacer(tui),
      { placement: "aboveEditor" },
    );
  });

  pi.on("session_shutdown", (_event, ctx) => {
    if (ctx.mode !== "tui") return;
    ctx.ui.setWidget("pin-input-bottom-spacer", undefined);
  });
}
