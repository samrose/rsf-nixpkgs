{ ... } @ args: import (import ./vendor/nixpkgs.nix) (args // {
  overlays = [ (import ./overlays/example-nixpkgs) ] ++ (args.overlays or []);
})
