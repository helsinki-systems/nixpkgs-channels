{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  pyaes,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "crownstone-core";
  version = "3.2.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "crownstone";
    repo = "crownstone-lib-python-core";
    rev = version;
    hash = "sha256-zrlCzx7N3aUcTUNa64jSzDdWgQneX+Hc5n8TTTcZ4ck=";
  };

  build-system = [ setuptools ];

  dependencies = [ pyaes ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "crownstone_core" ];

  meta = {
    description = "Python module with shared classes, util functions and definition of Crownstone";
    homepage = "https://github.com/crownstone/crownstone-lib-python-core";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ fab ];
  };
}
