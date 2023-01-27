{
  description =
    "Ready-made templates for easily creating flake-driven environments";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }:
    {
      templates = {
        data = {
          path = ./data;
          description = "Data Science development environment";
        };

        rust = {
          path = ./rust;
          description = "Rust development environment";
        };

      };
    };
}
