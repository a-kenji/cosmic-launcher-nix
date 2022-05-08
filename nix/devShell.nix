{
  mkShell,
  buildInputs,
  nativeBuildInputs,
}:
mkShell {
  name = "cosmic-launcher-dev-env";
  inherit buildInputs nativeBuildInputs;
  ### Environment Variables
  RUST_BACKTRACE = 1;
}
