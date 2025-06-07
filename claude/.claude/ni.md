# ni Tools 


## Usage

- **`ni`** - Install dependencies (auto-detects package manager)
- **`nr`** - Run scripts (equivalent to npm run / yarn run / pnpm run)
- **`nlx`** - Execute packages (equivalent to npx / yarn dlx / pnpm dlx)
- **`nup`** - Update dependencies (equivalent to npm update / yarn upgrade / pnpm update)
- **`nun`** - Uninstall dependencies (equivalent to npm uninstall / yarn remove / pnpm remove)
- **`nci`** - Clean install (equivalent to npm ci / yarn install --frozen-lockfile / pnpm install --frozen-lockfile)
- **`na`** - Agent alias (equivalent to npm / yarn / pnpm / bun)

Always use these commands instead of package manager specific ones to maintain consistency across different projects.

## Command Examples:

```bash
# Install dependencies
ni

# Add a package
ni vite

# Add dev dependency  
ni @types/node -D

# Run script
nr dev --port=3000

# Execute package
nlx vitest

# Update dependencies
nup

# Interactive update
nup -i

# Uninstall package
nun webpack

# Clean install
nci

# Agent alias - outputs current package manager
na

# Agent alias - run commands through detected package manager
na run foo

# update packages using pnpm interactive mode
na up -iLr
```

## Key Features:

- **Auto-detection**: Detects package manager from lock files (yarn.lock, pnpm-lock.yaml, package-lock.json, bun.lock)
- **Interactive mode**: Many commands support interactive selection (ni -i, nr, nun, etc.)
- **Global installs**: Use -g flag for global packages
- **Production installs**: Use -P flag for production-only installs
- **Frozen installs**: Use --frozen flag for lockfile-based installs

## Notable Changes from Original Commands:

- `nx`/`nix` was renamed to `nlx` to avoid conflicts with Nx CLI and Nix package manager
- `nu` was renamed to `nup` to avoid conflicts with Nushell
