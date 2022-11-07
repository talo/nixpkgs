_: super: let
  packageOverrides = import ./python-overrides.nix;
  python310 = super.python310.override (_: {
    inherit packageOverrides;
  });
  python3 = super.python3.override (_: {
    inherit packageOverrides;
  });
in {
  autodock-vina = super.callPackage ./pkgs/applications/science/autodock-vina {};
  p2rank = super.callPackage ./pkgs/applications/science/p2rank {};
  reduce = super.callPackage ./pkgs/applications/science/reduce {};

  dvc = super.callPackage ./pkgs/applications/version-management/dvc {};

  # non python
  # openmm = super.callPackage ./pkgs/development/libraries/openmm {};

  inherit python3;

  pythonPackages = python310.pkgs;
  python3Packages = python3.pkgs;
  python310Packages = python310.pkgs;
}
