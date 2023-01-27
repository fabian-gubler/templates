# Nix flake templates for easy dev environments

## How to Use
```bash
# Create a new project (specify template and directory name)
nix flake new --template github:fabian-gubler/templates#<template> <directory-name>

## How to use the templates
Once your preferred template has been initialized, you can use the provided shell in two ways:

1. If you have nix-direnv installed, you can initialize the environment by running direnv allow.
2. If you don't have nix-direnv installed, you can run nix develop to open up the Nix-defined shell.

## How to use 

# Run direnv
direnv allow
```

## Further Resources
- [dev-templates](https://github.com/the-nix-way/dev-templates)
