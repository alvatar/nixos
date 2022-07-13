with import <nixpkgs> {};
mkShell {
  name = "tensorflow-cuda-shell";
  buildInputs = with python3.pkgs; [
    python3
    pip
    setuptools
  ];
  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.cudatoolkit_11_0}/lib:${pkgs.cudnn_cudatoolkit_11_0}/lib:${pkgs.cudatoolkit_11_0.lib}/lib:$LD_LIBRARY_PATH
    export LD_LIBRARY_PATH=/run/opengl-driver/lib:/run/opengl-driver-32/lib:$LD_LIBRARY_PATH

    export PIP_PREFIX=$(pwd)/_build/pip_packages
    export PYTHONPATH="$PIP_PREFIX/${pkgs.python3.sitePackages}:$PYTHONPATH"
    export PATH="$PIP_PREFIX/bin:$PATH"
    unset SOURCE_DATE_EPOCH
  '';
}
