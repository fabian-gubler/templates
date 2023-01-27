{
  description = "Machine Learning Configuration Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, nixpkgs-unstable, ... }:
    # Automatically detect correct system (in my case x86_64-linux)
    flake-utils.lib.eachDefaultSystem (system:
      let
        python = "python310"; # <--- change here
        pkgs = import nixpkgs { inherit system; };
        pythonPackages = pkgs.python3Packages;
      in
      {
        devShell = pkgs.mkShell {
          name = "impurePythonEnv";
          venvDir = "./.venv";
          buildInputs = [
            # A Python interpreter including the 'venv' module is required to bootstrap
            # the environment.
            pythonPackages.python

            # This executes some shell code to initialize a venv in $venvDir before
            # dropping into the shell
            pythonPackages.venvShellHook

            # Those are dependencies that we would like to use from nixpkgs, which will
            # add them to PYTHONPATH and thus make them accessible from within the venv.
            pythonPackages.numpy
            pythonPackages.pandas
            pythonPackages.torch
            pythonPackages.torchvision
            pythonPackages.ipython
            pythonPackages.jupyter
            pythonPackages.matplotlib
            pythonPackages.numpy
            pythonPackages.pandas
            pythonPackages.pandas-datareader
            pythonPackages.openpyxl
            pythonPackages.scikit-learn
            pythonPackages.scipy
            pythonPackages.scikitimage
            pythonPackages.seaborn
            pythonPackages.torch
            pythonPackages.torchvision
            pythonPackages.rasterio

            # In this particular example, in order to compile any binary extensions they may
            # require, the Python modules listed in the hypothetical requirements.txt need
            # the following packages to be installed locally:
            pkgs.taglib
            pkgs.openssl
            pkgs.git
            pkgs.libxml2
            pkgs.libxslt
            pkgs.libzip
            pkgs.zlib
          ];

          # Run this command, only after creating the virtual environment
          postVenvCreation = ''
            unset SOURCE_DATE_EPOCH
            pip install -r requirements.txt
          '';

          # Now we can execute any commands within the virtual environment.
          # This is optional and can be left out to run pip manually.
          postShellHook = ''
            # allow pip to install wheels
            unset SOURCE_DATE_EPOCH
          '';
        };
      }
    );
}
