# Cosmic Launcher Nix
Nix environment for the [cosmic-launcher](https://github.com/pop-os/cosmic-launcher).

## Setup Environment
Drop into dependencies:
```
nix develop
```
or [direnv](https://github.com/direnv/direnv) support:
```
direnv allow
```

## Build & Install
Build:
```
nix build github:a-kenji/cosmic-launcher-nix
```
Run:
```
nix run github:a-kenji/cosmic-launcher-nix
```
Install:
```
nix profile install github:a-kenji/cosmic-launcher-nix
```

## Format
```
just fmt
```
