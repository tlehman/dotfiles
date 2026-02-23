# Agent Guidelines for Nix Dotfiles Repository

## Overview

Nix-based dotfiles for macOS (nix-darwin + home-manager). Primary configs: Zsh, Git, CLI tools.
Platform: aarch64-darwin (Apple Silicon only). Flake-based with custom modular structure using `lib.autoImport`.

## Build & Commands

**Primary Commands:**

- `darwin-rebuild switch --flake .` - Apply system configuration
- `nix develop` - Enter dev shell (deadnix, statix, nixfmt-tree, just)

**Testing & Validation:**

- `nix flake check` - Validate flake structure
- `nix build .#darwinConfigurations.AMER-Tobi-Lehman.system` - Test build without applying
- `nix eval .#darwinConfigurations.AMER-Tobi-Lehman.config.<path>` - Evaluate specific config values
- `nix flake show` - Show all flake outputs

**Code Quality:**

- `nix fmt` - Format all Nix files (nixfmt-tree)
- `statix check .` - Lint Nix code
- `deadnix .` - Find unused Nix code

## Code Style - Nix

**General:**

- Indentation: 2 spaces (enforced by nixfmt-tree)
- Line endings: LF, no trailing whitespace, final newline required
- Formatter: `nix fmt` (uses nixfmt-tree)

**Module Structure:**
Standard pattern for all modules:

```nix
{ lib, config, pkgs, ... }:
{
  options.tlehman.<feature>.enable = lib.mkEnableOption "description";

  config = lib.mkIf config.tlehman.<feature>.enable {
    # Configuration here
  };
}
```

**Imports:**
Use `inherit` extensively for cleaner code:

```nix
inherit (pkgs) package1 package2;
inherit (lib) mkIf mkEnableOption mkDefault;
```

**Package Lists:**
Use `builtins.attrValues` pattern:

```nix
packages = builtins.attrValues {
  inherit (pkgs) package1 package2 package3;
};
```

**Let Bindings:**
Extract common values and package paths:

```nix
let
  cfg = config.programs.nh;
  rg = "${pkgs.ripgrep}/bin/rg";
in
```

**Conditionals:**
Always wrap config with `lib.mkIf`:

```nix
config = lib.mkIf cfg.enable { ... };
```

**Options:**

- Boolean: `lib.mkEnableOption "description"`
- Program: `lib.mkProgramOption { pkgs, programName, ... }` (custom lib function)
- Defaults: `lib.mkDefault value` for overridable values

## Code Style - Shell Scripts

- Always start with: `set -euo pipefail`
- Use `trap 'cleanup_command' EXIT` for temp resources
- Indentation: 2 spaces
- Colors: Define at top (`RED`, `GREEN`, `YELLOW`, `BLUE`, `NC`)
- Variables: `UPPER_CASE` for constants, `lower_case` for locals
- Create backups before modifying files

## Naming Conventions

- **Module options:** `tlehman.<feature>.enable` (e.g., `tlehman.zsh.enable`)
- **Nix functions:** camelCase (e.g., `mkDarwin`, `autoImport`, `mkProgramOption`)
- **Files:** kebab-case for multi-word (e.g., `macos-defaults.nix`)
- **Hosts:** Descriptive names (e.g., `AMER-Tobi-Lehman`, `bender`)
- **Shell variables:** `UPPER_CASE` for constants, `lower_case` for locals

## File Organization

```
├── modules/
│   ├── darwin/          # nix-darwin system modules (uses lib.autoImport)
│   │   ├── core/        # Essential system configuration
│   │   └── mixins/      # Optional features (homebrew, macos-defaults)
│   └── home-manager/    # User-level tool configs (zsh, git, ssh, starship)
├── hosts/               # Host-specific configurations
├── lib/                 # Custom library functions (autoImport, mkDarwin, etc.)
├── bin/                 # Utility scripts
└── scripts/             # Helper scripts
```

## Custom Library Functions

Located in `lib/default.nix`:

**`autoImport dir`**

- Auto-imports all .nix files in directory except default.nix
- Key feature: Enables directory-based module organization without explicit imports
- Used in: `modules/darwin/default.nix`, `modules/darwin/core/default.nix`

**`mkDarwin hostmodule username`**

- Creates darwin configuration with home-manager integration
- Combines nix-darwin + home-manager

**`mkHomeManager username`**

- Creates home-manager user configuration
- Sets up imports and state version

**`mkProgramOption { pkgs, programName, packageName?, description?, extraPackageArgs? }`**

- Creates standardized enable option + package option
- Example: `modules/darwin/core/programs/nh/default.nix`

## Common Patterns

**Adding a New Module:**

1. Create file in `modules/darwin/` or `modules/home-manager/`
2. Follow standard structure: `options` with `tlehman.<feature>.enable` + `config` with `lib.mkIf`
3. File is auto-discovered via `lib.autoImport` in parent `default.nix`
4. **Must `git add` new files before `nix build`** -- flakes only see git-tracked files

**Adding a New Host:**

1. Create `hosts/<hostname>/default.nix`
2. Add to `darwinConfigurations` in `flake.nix` with `lib.mkDarwin ./hosts/<hostname> "<username>"`
3. Host file can override defaults or enable optional features
