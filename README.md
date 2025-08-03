# Nix

This is my multi-host nix configuration. Currently being refactored.

## Structure

```
home
├── ...
│   ├── assets
│   │   └── ...
│   ├── home.nix
│   ├── programs
│   │   └── ...
│   │       └── default.nix
│   └── scripts
│       └── ...
│           ├── default.nix
│           └── script.sh
└── users.nix
hosts
└── ...
    ├── configuration.nix
    ├── flake.nix
    └── hardware-configuration.nix
```
