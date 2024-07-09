{ lib, callPackage }:
let
  inherit (lib) mapAttrs' nameValuePair;

  variants = {
    "8" = {
      version = "8.15.8";
      hash = "sha256-aR/hdu6pqKgN8g5JdvPftEoEhBzriFY4/iomF0+B5l4=";
    };
    "9" = {
      version = "9.6.0";
      hash = "sha256-2uD36CLFayCXm7WWXjtzuL2rtri47xIdpthXUIWZyjU=";
    };
  };

  callPnpm = variant: callPackage ./generic.nix {inherit (variant) version hash;};

  mkPnpm = versionSuffix: variant: nameValuePair "pnpm_${versionSuffix}" (callPnpm variant);
in
mapAttrs' mkPnpm variants
