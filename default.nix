{ ... } @ args: import (import ./vendor/nixpkgs.nix) (args // {
  overlays = [ (import ./overlays/rsf-nixpkgs) ] ++ (args.overlays or []);
})
