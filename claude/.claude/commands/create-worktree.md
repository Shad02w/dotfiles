---
description: This command aim to create a git worktree from the current directory and branch
---

## arguments
relative_path=$ARGUMENTS
branch_name=$ARGUMENTS


## prepare for create worktree
1. check if the current directory is a git repository, if not, tell the user to run `git init` first
2. find out the current branch name, and current directory
3. check if the directory exists, if it does, tell the user to remove it first
4. show user the variables: $relative_path, $branch_name

## create the worktree
1. create the command `git worktree add $relative_path $branch_name` for creating the worktree
2. before creating the worktree, show me the command first, and ask user for feedbacks, tune the command until user is satisfied

## post works
- search for the env files, copy the env files that are ignored to the new worktree, for example, most of time, `*.local` will be ignored
- search for the claude code related files, like .mcp.json, claude.*.md, claude.md, memory.local/**/*.md, custom slash commands and settings under.claude directory etc., copy them to the new worktree
- do the files searching and copying in parallel
- summary all the steps
