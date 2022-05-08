{
  description = "pop-launcher nix shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    cosmic-launcher.url = "github:pop-os/cosmic-launcher";
    cosmic-launcher.flake = false;
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
    rust-overlay.inputs.flake-utils.follows = "flake-utils";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
    crate2nix.url = "github:kolloch/crate2nix";
    crate2nix.flake = false;
  };

  outputs = {...} @ args: import ./nix args;
}
