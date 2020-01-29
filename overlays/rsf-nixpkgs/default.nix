final: previous:

with final;
with lib;

let

  npm-to-nix = fetchFromGitHub {
    owner = "samrose";
    repo = "npm-to-nix";
    rev = "a223e2443e20f26e5af9766feecbce6eba644335";
    sha256 = "11hbdb32fh6yhfv6li0cyn6wwyxmql932jjl7nmlx03mzl6h89xd";
  };
  buildImage = imports:
    let
      system = nixos {
        inherit imports;
      };

      imageNames = filter (name: hasAttr name system) [
        "isoImage"
        "sdImage"
        "virtualBoxOVA"
        "vm"
      ];
    in
      head (attrVals imageNames system);
  gitignore = fetchFromGitHub {
    owner = "hercules-ci";
    repo = "gitignore";
    rev = "f9e996052b5af4032fe6150bba4a6fe4f7b9d698";
    sha256 = "0jrh5ghisaqdd0vldbywags20m2cxpkbbk5jjjmwaw0gr8nhsafv";
  };
in


{

  inherit (callPackage gitignore {}) gitignoreSource;

  inherit (callPackage npm-to-nix {}) npmToNix;

  noflo-rsf = callPackage ./noflo-rsf {};
  rsf-nixpkgs = recurseIntoAttrs {
    profile = tryDefault <nixos-config> ../../profiles;

    qemu = buildImage [
      ../../profiles/hardware/qemu
      rsf-nixpkgs.profile
    ];
  };
  tryDefault = x: default:
    let
      eval = builtins.tryEval x;
    in
      if eval.success then eval.value else default;
}
