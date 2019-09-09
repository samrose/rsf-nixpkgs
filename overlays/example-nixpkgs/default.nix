final: previous:

with final;
with lib;

{
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

  example = callPackage ./example {};

  example-nixpkgs = recurseIntoAttrs {
    profile = tryDefault <nixos-config> ../../profiles;

    qemu = buildImage [
      ../../profiles/hardware/qemu
      example-nixpkgs.profile
    ];
  };

  tryDefault = x: default:
    let
      eval = builtins.tryEval x;
    in
    if eval.success then eval.value else default;
}
