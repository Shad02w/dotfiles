# Claude Memory

## Package Management

### JS projects (node, deno, bun, pnpm, npm)
Always use @antfu/ni (Node.js Package Manager Installer) for package management across all JS projects. 
@antfu/ni is a package manager tool that choose the right package manager based on the project's dependencies and lock file, check doc using usage patterns

also always prefer to install dependencies in exact versions, like adding it `-E` flag

