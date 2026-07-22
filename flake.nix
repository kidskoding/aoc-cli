{
  description = "anirudh's rust dev environment";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          # rust
          cargo
          clippy
          rust-analyzer
          rustc
          rustfmt

          # "accessories" for rust
          bacon
          cargo-chef
          # cargo-lambda
          evcxr
          rustlings
          trunk
          wasm-pack

          # aoc-cli needs this for its vendored openssl dependency
          pkg-config
        ];

        # openssl must be a buildInput (not packages/nativeBuildInputs) for
        # pkg-config's setup hook to populate PKG_CONFIG_PATH correctly
        buildInputs = [ pkgs.openssl ];

        RUST_BACKTRACE = "1";
      };
    };
}
