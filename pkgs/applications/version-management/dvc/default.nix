{ lib, python3, fetchurl, fetchFromGitHub, fetchpatch, enableGoogle ? false
, enableAWS ? false, enableAzure ? false, enableSSH ? false }:

let
  dvcrender = python3.pkgs.buildPythonApplication rec {
    pname = "dvc_render";
    version = "0.0.5";
    format = "wheel";

    src = fetchurl {
      url =
        "https://files.pythonhosted.org/packages/13/9d/9d5838b365f85bb865e1fd6afbb38fe083d1ad5fd6d46943e81781cff936/dvc_render-0.0.5-py3-none-any.whl";
      sha256 =
        "45aea06c4ff22a637f7a54025f72c5a1c54e7db99387d2d4b1215a6359f87968";
    };

    nativeBuildInputs = with python3.pkgs; [
      setuptools-scm
      setuptools-scm-git-archive
    ];

    propagatedBuildInputs = with python3.pkgs; [
      appdirs
      funcy
      flufl_lock
      tabulate
    ];
  };

  dvclive = python3.pkgs.buildPythonApplication rec {
    pname = "dvclive";
    version = "0.7.3";
    format = "wheel";

    src = fetchurl {
      url =
        "https://files.pythonhosted.org/packages/42/d6/02578854732094bd00822d0255c4835acb616a5ef79df8b6cb19f5ddffbe/dvclive-0.7.3-py2.py3-none-any.whl";
      sha256 =
        "f7894df7283bf8285c554f6c143859187d223879af546578fa08616cdb126864";
    };

    nativeBuildInputs = with python3.pkgs; [
      setuptools-scm
      setuptools-scm-git-archive
    ];

    propagatedBuildInputs = with python3.pkgs; [ dvcrender scmrepo ];
  };
in python3.pkgs.buildPythonApplication rec {
  pname = "dvc";
  version = "2.10.2";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = pname;
    rev = version;
    hash = "sha256-boaQSg0jajWQZKB5wvcP2musVR2/pifT4pU64Y5hiQ0=";
  };

  # make the patch apply
  prePatch = ''
    substituteInPlace setup.cfg \
      --replace "scmrepo==0.0.19" "scmrepo"
  '';

  # patches = [
  #   ./dvc-daemon.patch
  #   (fetchpatch {
  #     url =
  #       "https://github.com/iterative/dvc/commit/ab54b5bdfcef3576b455a17670b8df27beb504ce.patch";
  #     sha256 = "sha256-wzMK6Br7/+d3EEGpfPuQ6Trj8IPfehdUvOvX3HZlS+o=";
  #   })
  # ];

  postPatch = ''
    substituteInPlace setup.cfg \
      --replace "grandalf==0.6" "grandalf>=0.6" \
      --replace "scmrepo==0.0.13" "scmrepo"
    substituteInPlace dvc/daemon.py \
      --subst-var-by dvc "$out/bin/dcv"
  '';

  nativeBuildInputs = with python3.pkgs; [
    setuptools-scm
    setuptools-scm-git-archive
  ];

  propagatedBuildInputs = with python3.pkgs;
    [
      appdirs
      aiohttp-retry
      colorama
      configobj
      configobj
      dictdiffer
      diskcache
      distro
      dvclive
      dvcrender
      dpath
      flatten-dict
      flufl_lock
      funcy
      grandalf
      nanotime
      networkx
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
    ] ++ lib.optional enableGoogle [ google-cloud-storage gcsfs ]
    ++ lib.optional enableAWS [ boto3 ]
    ++ lib.optional enableAzure [ azure-storage-blob ]
    ++ lib.optional enableSSH [ paramiko ]
    ++ lib.optionals (pythonOlder "3.8") [ importlib-metadata ]
    ++ lib.optionals (pythonOlder "3.9") [ importlib-resources ];

  # Tests require access to real cloud services
  doCheck = false;

  meta = with lib; {
    description = "Version Control System for Machine Learning Projects";
    homepage = "https://dvc.org";
    license = licenses.asl20;
    maintainers = with maintainers; [ cmcdragonkai fab ];
  };
}
