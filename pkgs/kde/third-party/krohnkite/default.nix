{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nodejs_22,
  kwin,
  kpackage,
  zip,
}:
buildNpmPackage rec {
  pname = "krohnkite";
  version = "0.9.8.2";

  src = fetchFromGitHub {
    owner = "anametologin";
    repo = "krohnkite";
    rev = "refs/tags/${version}";
    hash = "sha256-chADfJ1zaufnwi4jHbEN1Oec3XFNw0YsZxLFhnY3T9w=";
  };

  npmDepsHash = "sha256-3yE2gyyVkLn/dPDG9zDdkHAEb4/hqTJdyMXE5Y6Z5pM=";

  dontWrapQtApps = true;

  nodejs = nodejs_22;

  nativeBuildInputs = [
    kpackage
    zip
    kwin
  ];

  postPatch = ''
    cp ${./package-lock.json} package-lock.json
  '';

  npmBuildScript = "tsc";

  installPhase = ''
    runHook preInstall

    substituteInPlace Makefile --replace-fail '7z a -tzip' 'zip -r'
    make krohnkite-${version}.kwinscript
    kpackagetool6 --type=KWin/Script --install=krohnkite-${version}.kwinscript --packageroot=$out/share/kwin/scripts

    runHook postInstall
  '';

  meta = {
    description = "Dynamic Tiling Extension for KWin 6";
    homepage = "https://github.com/anametologin/krohnkite";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ben9986 ];
    platforms = lib.platforms.all;
  };
}
