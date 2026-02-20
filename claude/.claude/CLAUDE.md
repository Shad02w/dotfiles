# Claude Memory

## Package Management

### JS projects (node, deno, bun, pnpm, npm)

-   Always use @antfu/ni (Node.js Package Manager Installer) for package management across all JS projects. @antfu/ni is a package manager tool that choose the right package manager based on the project's dependencies and lock file, check doc using usage patterns

## React projects

-   use named function components create functions at root level of the files
-   do not need to generate useless comments
-   Prefer to use named export for all the files

## Miscellaneous

-   Always use `TODO/Alvis:` for adding tasks for myself
-   when try to use base `rm` command, it will have a `are you sure?` prompt, echo `y` to confirm like `echo "y" | rm -rf directory`
-   **IMPORTANT**Alway check the latest change of the file before you made the change, otherwise some changes will be gone after you update
