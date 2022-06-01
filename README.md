# Cosmic Launcher Nix
<!-- <p align="center"> -->
  <a href="https://builtwithnix.org"><img alt="Built with nix" src="https://img.shields.io/static/v1?label=built%20with&message=nix&color=5277C3&logo=nixos&style=flat-square&logoColor=ffffff"></a>
<!-- </p> -->

Nix environment for the [cosmic-launcher](https://github.com/pop-os/cosmic-launcher).

## Setup Environment
Drop into dependencies:
```
nix develop github:a-kenji/cosmic-launcher-nix
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
