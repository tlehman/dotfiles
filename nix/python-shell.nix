# Use this by putting it in a dir as shell.nix, then run `nix-shell`
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    (pkgs.python3.withPackages (ps: [ ps.pip ]))
  ];

  shellHook = ''
    export VENV_DIR=$(mktemp -d)
    python -m venv $VENV_DIR
    source $VENV_DIR/bin/activate
    pip install grip
    echo "Virtual environment is ready and grip is installed."
  '';
}
