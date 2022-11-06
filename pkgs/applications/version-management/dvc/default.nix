{ lib, python3, fetchFromGitHub, fetchpatch, enableGoogle ? false
, enableAWS ? false, enableAzure ? false, enableSSH ? false }:

let
  py = python3.override {
    packageOverrides = self: super: {

      grandalf = super.grandalf.overridePythonAttrs (oldAttrs: rec {
        version = "0.6";
        src = fetchFromGitHub {
          owner = "bdcht";
          repo = "grandalf";
          rev = "v${version}";
          hash = "sha256-T4pVzjz1WbfBA2ybN4IRK73PD/eb83YUW0BZrBESNLg=";
        };
        postPatch = ''
          substituteInPlace setup.py \
            --replace "setup_requires=['pytest-runner',]," ""
        '';
      });

      scmrepo = super.scmrepo.overridePythonAttrs (oldAttrs: rec {
        version = "0.0.25";
        src = fetchFromGitHub {
          owner = "iterative";
          repo = "scmrepo";
          rev = "refs/tags/${version}";
          hash = "";
        };
      });

    };
  };
in with py.pkgs;

buildPythonApplication rec {
  pname = "dvc";
  version = "2.17.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = pname;
    rev = version;
    hash = "sha256-2h+fy4KMxFrVtKJBtA1RmJDZv0OVm1BxO1akZzAw95Y=";
  };

  postPatch = ''
    substituteInPlace setup.cfg \
      --replace "pathspec>=0.9.0,<0.10.0" "pathspec"
    substituteInPlace dvc/daemon.py \
      --subst-var-by dvc "$out/bin/dcv"
  '';

  nativeBuildInputs = with python3.pkgs; [
    setuptools-scm
  ];

  propagatedBuildInputs = with python3.pkgs; [
    aiohttp-retry
    appdirs
    colorama
    configobj
    dictdiffer
    diskcache
    distro
    dpath
    dvclive
    dvc-data
    dvc-render
    dvc-task
    flatten-dict
    flufl_lock
    funcy
    grandalf
    nanotime
    networkx
    packaging
    pathspec
    ply
    psutil
    pydot
    pygtrie
    pyparsing
    python-benedict
    requests
    rich
    ruamel-yaml
    scmrepo
    shortuuid
    shtab
    tabulate
    tomlkit
    tqdm
    typing-extensions
    voluptuous
    zc_lockfile
  ] ++ lib.optionals enableGoogle [
    gcsfs
    google-cloud-storage
  ] ++ lib.optionals enableAWS [
    aiobotocore
    boto3
    s3fs
  ] ++ lib.optionals enableAzure [
    azure-identity
    knack
  ] ++ lib.optionals enableSSH [
    bcrypt
  ] ++ lib.optionals (pythonOlder "3.8") [
    importlib-metadata
  ] ++ lib.optionals (pythonOlder "3.9") [
    importlib-resources
  ];

  # Tests require access to real cloud services
  doCheck = false;

  meta = with lib; {
    description = "Version Control System for Machine Learning Projects";
    homepage = "https://dvc.org";
    license = licenses.asl20;
    maintainers = with maintainers; [ cmcdragonkai fab anthonyroussel ];
  };
}
