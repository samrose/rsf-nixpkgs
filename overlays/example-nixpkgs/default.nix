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
    qemu = buildImage [ ../../profiles/hardware/qemu ];
  };
}
