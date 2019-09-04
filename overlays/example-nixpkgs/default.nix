final: previous:

with final;
with lib;

{
  mkImage = imports:
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
    qemu = mkImage [ ../../profiles/hardware/qemu ];
  };
}
