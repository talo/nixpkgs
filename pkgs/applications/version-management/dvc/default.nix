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
        version = "0.0.19";
        src = fetchFromGitHub {
          owner = "iterative";
          repo = "scmrepo";
          rev = "refs/tags/${version}";
          hash = "sha256-f/KV3NfIumkZcg9r421QhdyPU/274aAU4b78myi+fFY=";
        };
      });

    };
  };
in with py.pkgs;

buildPythonApplication rec {
  pname = "dvc";
  version = "2.12.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = pname;
    rev = version;
    hash = "sha256-d1Tjqomr8Lcf+X+LZgi0wHlxXBUqHq/nAzDBbrxHAl4=";
  };

  nativeBuildInputs = with py.pkgs; [
    setuptools-scm
    setuptools-scm-git-archive
  ];

  propagatedBuildInputs = with python3.pkgs; [
    aiohttp-retry
    appdirs
    colorama
    configobj
    configobj
    dictdiffer
    diskcache
    distro
    dpath
    dvclive
    dvc-data
    dvc-render
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
    toml
    tqdm
    typing-extensions
    voluptuous
    zc_lockfile
  ] ++ lib.optional enableGoogle [
    gcsfs
    google-cloud-storage
  ] ++ lib.optional enableAWS [
    aiobotocore
    boto3
    s3fs
  ] ++ lib.optional enableAzure [
    azure-identity
    knack
  ] ++ lib.optional enableSSH [
    bcrypt
  ] ++ lib.optionals (pythonOlder "3.8") [
    importlib-metadata
  ] ++ lib.optionals (pythonOlder "3.9") [
    importlib-resources
  ];

  postPatch = ''
    substituteInPlace setup.cfg \
      --replace "grandalf==0.6" "grandalf" \
      --replace "scmrepo==0.0.25" "scmrepo" \
      --replace "dvc-data==0.0.16" "dvc-data" \
      --replace "dvc-render==0.0.6" "dvc-render"
    substituteInPlace dvc/daemon.py \
      --subst-var-by dvc "$out/bin/dcv"
  '';

  # Tests require access to real cloud services
  doCheck = false;

  meta = with lib; {
    description = "Version Control System for Machine Learning Projects";
    homepage = "https://dvc.org";
    license = licenses.asl20;
    maintainers = with maintainers; [ cmcdragonkai fab ];
  };
}
