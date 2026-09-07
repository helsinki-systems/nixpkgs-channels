{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
}:

buildPythonPackage rec {
  pname = "cssmin";
  version = "0.2.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "1dk723nfm2yf8cp4pj785giqlwv42l0kj8rk40kczvq1hk6g04p0";
  };

  build-system = [ setuptools ];

  # no tests
  doCheck = false;

  meta = {
    description = "Python port of the YUI CSS compression algorithm";
    mainProgram = "cssmin";
    homepage = "https://github.com/zacharyvoase/cssmin";
    license = lib.licenses.bsd3;
  };
}
