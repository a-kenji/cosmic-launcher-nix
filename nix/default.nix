{
  self,
  nixpkgs,
  cosmic-launcher,
  rust-overlay,
  flake-utils,
  flake-compat,
  crate2nix,
}:
flake-utils.lib.eachSystem [
  "aarch64-linux"
  "aarch64-darwin"
  "i686-linux"
  "x86_64-darwin"
  "x86_64-linux"
]
(
  system: let
    overlays = [(import rust-overlay)];

    pkgs = import nixpkgs {inherit system overlays;};

    crate2nixPkgs = import nixpkgs {
      inherit system;
      overlays = [
        (self: _: {
          rustc = rustToolchainToml;
          cargo = rustToolchainToml;
        })
      ];
    };

    name = "cosmic-launcher";
    pname = name;
    root = cosmic-launcher;

    ignoreSource = [".git" "target" "example"];

    src = pkgs.nix-gitignore.gitignoreSource ignoreSource root;

    rustToolchainToml = pkgs.rust-bin.fromRustupToolchainFile (root + /rust-toolchain);
    cargoLockFile = root + /Cargo.lock;

    cargo = rustToolchainToml;
    rustc = rustToolchainToml;

    buildInputs = [
      pkgs.xorg.libX11
      pkgs.glib
      pkgs.cairo
      pkgs.pango
      pkgs.gdk-pixbuf
      pkgs.gtk4

      #pkgs.wrapGAppsHook
    ];

    nativeBuildInputs = [
      pkgs.pkg-config
      pkgs.wrapGAppsHook4
    ];

    devInputs = [
      rustToolchainToml
    ];

    fmtInputs = [
      pkgs.alejandra
      pkgs.treefmt
    ];
    # TODO add meta
  in rec {
    # native nixpkgs support - keep supported
    packages.default = (pkgs.makeRustPlatform {inherit cargo rustc;}).buildRustPackage {
      inherit
        src
        name
        buildInputs
        nativeBuildInputs
        ;
      LIBCLANG_PATH = pkgs.lib.makeLibraryPath [pkgs.llvmPackages_latest.libclang.lib];
      cargoLock = {
        lockFile = src + "/Cargo.lock";
        outputHashes = {
          "cosmic-theme-0.1.0" = "sha256-KKnfNYr6SZuA02ov38zmtk4dRI9O4S0maun4Fs3OOb0=";
          "kmeans_colors-0.5.0" = "sha256-uzn5LMGOSNO+q0BvNKfcYPHSTpe7ipGaRdefdyOXRJs=";
          "libcosmic-0.1.0" = "sha256-gtay732XDl3WNUZ5l+H36j9TSi2jJQabA5SVgxhfvqk=";
          "pop-launcher-1.2.1" = "sha256-7fls1m6ylHIQ9Q38XbNrCm437t4fvRLAAb5keDppey4=";
          "relm4-macros-0.4.4" = "sha256-P0nOmuTsyqpQM9wplzElYEPovsQ4yZhXS8yhRYttHUU=";
        };
      };
    };

    # nix run
    apps.launcher = flake-utils.lib.mkApp {drv = packages.launcher;};
    defaultApp = apps.launcher;

    devShells = {
      default = pkgs.callPackage ./devShell.nix {
        inherit buildInputs;
        nativeBuildInputs = nativeBuildInputs ++ devInputs ++ fmtInputs;
      };
      fmtShell = pkgs.mkShell {
        name = "fmt-shell";
        nativeBuildInputs = fmtInputs;
      };
    };
  }
)
// rec {
  overlays = {
    default = final: prev: rec {
      launcher = self.packages.${prev.system}.launcher;
    };
    nightly = final: prev: rec {
      launcher-nightly = self.packages.${prev.system}.launcher;
    };
  };
}
