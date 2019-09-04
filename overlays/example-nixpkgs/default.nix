final: previous:

with final;
with lib;

{
  mkImage = profile:
    let
      system = nixos {
        imports = [ profile ];
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
    qemu = mkImage ../../profiles/hardware/qemu;
  };
}
