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
nix build
```
Run:
```
nix run
```
Install:
```
nix profile install
```

## Format
```
just fmt
```
