{
  description =
    "Ready-made templates for easily creating flake-driven environments";

  outputs = { self, flake-utils, nixpkgs }:
    {
      templates = {
        data = {
          path = ./data;
          description = "Data Science development environment";
        };

        conda = {
          path = ./conda;
          description = "Isolated Conda File System";
        };

      };
    };
}
