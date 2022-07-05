{ buildPythonPackage, fetchurl, pytest-runner, which, ninja }:

buildPythonPackage {
  pname = "torch-spline-conv";
  version = "1.2.1";
  format = "wheel";
  #format = "setuptools";
  src = fetchurl {
    url =
      "https://data.pyg.org/whl/torch-1.11.0%2Bcu113/torch_spline_conv-1.2.1-cp39-cp39-linux_x86_64.whl";
    sha256 = "sha256-azbAx96DYSKgAclRrssIlJHdrtpisKXT0YDPcIN+lnw=";
    # url =
    #  "https://data.pyg.org/whl/torch-1.11.0%2Bcu115/torch_spline_conv-1.2.1-cp39-cp39-linux_x86_64.whl";
    #sha256 = "sha256-vsOreU1ryWVTZ++NNG4/UjHOyWxwhwkqwFZbwR7XkLA=";
    # url =
    #   "https://files.pythonhosted.org/packages/80/f8/4d010376565c59b3c397b1cf103edc4e9b2ed087c2bbd3677f0a92930d75/torch_spline_conv-1.2.1.tar.gz";
    # sha256 = "sha256-Nk9ljg7LTFJjpyjClhVT4CL8RMEaYz1aG/mGzxaatDg=";
  };
  doCheck = false;
  checkInputs = [ ];
  nativeBuildInputs = [ pytest-runner which ];
}
