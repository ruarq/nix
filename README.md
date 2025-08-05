# Nix

This is my multi-host nix configuration. Currently being refactored and riced to a Minecraft-like theme.

## Multiple flakes

I decided to use multiple flakes as I am not sure how to separate inputs between multiple hosts,
such that an input needed only for one specific host doesn't end up on all the other hosts.

Because it's kind of annoying to build a flake from any directory which is not the directory the flake resides in,
I chose to use Makefiles and make (_ha- ha.._) my life easier.

## Makefile

```
$ make list-hosts       -- lists all available hosts
$ make rebuild-<host>   -- rebuild and switch to a specific host
$ make build-<host>     -- rebuild a specific host (doesn't switch to it)
$ make check-<host>     -- runs `nix-flake-check` on the host
```

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
