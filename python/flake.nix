{
  description = "Data Science Configuration Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        python = "python310"; # <--- change here
        pythonPackages = pkgs.python310Packages;# <--- change here
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell = pkgs.mkShell {
          name = "python";
          venvDir = "./.venv";
          buildInputs = [
            # A Python interpreter including the 'venv' module is required to bootstrap
            # the environment.
            pythonPackages.python

            # This executes some shell code to initialize a venv in $venvDir before
            # dropping into the shell
            pythonPackages.venvShellHook

            # Dependencies that we would like to use from nixpkgs, which will
            # add them to PYTHONPATH and thus make them accessible from within the venv.
            pythonPackages.numpy
            pythonPackages.pandas
            pythonPackages.matplotlib
            pythonPackages.pycairo
            pythonPackages.torch
            pythonPackages.torchvision
            pythonPackages.pandas
            pythonPackages.pandas-datareader
            pythonPackages.openpyxl
            pythonPackages.scikit-learn
            pythonPackages.scipy
            pythonPackages.scikitimage
            pythonPackages.seaborn
            pythonPackages.rasterio


            # Natural Language Processing
            pythonPackages.nltk
			pythonPackages.spacy

            ## Jupyter notebook essentials
            pythonPackages.jupytext
            pythonPackages.ipython
            pythonPackages.jupyter
            pythonPackages.jupyterlab

            ## Developer tools
            pkgs.black
            pythonPackages.flake8
			pythonPackages.isort
            pkgs.nodePackages.pyright


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
          '';

          # Now we can execute any commands within the virtual environment.
          # This is optional and can be left out to run pip manually.
          postShellHook = ''
                        			# allow pip to install wheels
                        			unset SOURCE_DATE_EPOCH

            						# set plotting backend 
            						# > matplotlib.use('WebAgg') (override with python inline)
            						export MPLBACKEND=TkAgg

                                    # Create jupyter extension directory in case (optional)
                        			mkdir -p $(jupyter --data-dir)/nbextensions


                        # TODO: create vim-binding nix package
                        			# cd $(jupyter --data-dir)/nbextensions
                        			# git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
                        			# jupyter nbextension enable vim_binding/vim_binding

                        # TODO: jupytext overlay to enable the serverextensiont
                        			# jupyter serverextension enable jupytext

          '';
        };
      }
    );
}
