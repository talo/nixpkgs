_: super:
{
  autodock-vina = super.callPackage ./pkgs/applications/science/autodock-vina {};
  p2rank = super.callPackage ./pkgs/applications/science/p2rank {};
  reduce = super.callPackage ./pkgs/applications/science/reduce {};

  dvc = super.callPackage ./pkgs/applications/version-management/dvc {};

  # non python
  # openmm = super.callPackage ./pkgs/development/libraries/openmm {};

  pythonPackages = (super.pythonPackages.override (self: super: {
    feast = super.callPackage ./pkgs/development/python-modules/feast/default.nix {};
    googledrivedownloader = super.callPackage ./pkgs/development/python-modules/googledrivedownloader/default.nix {};
    grpcio-reflection = super.callPackage ./pkgs/development/python-modules/grpcio-reflection/default.nix {};
    oddt = super.callPackage ./pkgs/development/python-modules/oddt/default.nix {};
    openmm = super.callPackage ./pkgs/development/python-modules/openmm/default.nix { enableCuda = true; };
    pdbfixer = super.callPackage ./pkgs/development/python-modules/pdfixer/default.nix { };
    py-spy = super.callPackage ./pkgs/development/python-modules/py-spy/default.nix {};
    pykeops = super.callPackage ./pkgs/development/python-modules/pykeops/default.nix {};
    torch-cluster = super.callPackage ./pkgs/development/python-modules/torch-cluster/default.nix {};
    torch-geometric = super.callPackage ./pkgs/development/python-modules/torch-geometric/default.nix {};
    torch-scatter = super.callPackage ./pkgs/development/python-modules/torch-scatter/default.nix {};
    torch-sparse = super.callPackage ./pkgs/development/python-modules/torch-sparse/default.nix {};
    torch-spline-conv = super.callPackage ./pkgs/development/python-modules/torch-spline-conv/default.nix {};
  }));
}
