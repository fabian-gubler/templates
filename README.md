# Nix flake templates for reproducible dev environments

## How to Use
```bash
# Initialize project with corresponding template
nix flake new --template github:fabian-gubler/templates#<template> 
```

## How to use the templates
Once your preferred template has been initialized, you can use the provided shell in two ways:

1. If you have nix-direnv installed, you can initialize the environment by running `direnv allow`.
2. If you don't have nix-direnv installed, you can run `nix develop` to open up the Nix-defined shell.

## Further Resources
- [dev-templates](https://github.com/the-nix-way/dev-templates)
- [philosophy](https://determinate.systems/posts/nix-direnv)
- [opinionated shells](https://github.com/Leixb/flake-templates)
