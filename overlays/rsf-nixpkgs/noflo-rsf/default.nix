{ stdenv, fetchFromGitHub, gitignoreSource, nodejs-12_x, nodePackages, npmToNix }:

stdenv.mkDerivation rec {
  name = "noflo-rsf";

  src = fetchFromGitHub {
    owner = "rapid-sensemaking-framework";
    repo = "noflo-rsf";
    rev = "72b73aadf0dc95953e0868ccca0817161c741938";
    sha256 = "06xaa051kg66fwx7zg0hxcm07wxh8bc6i8232h4xvwrs2cbfwg5a";
  };

  nativeBuildInputs = [ nodejs-12_x nodePackages.typescript ];

  preConfigure = ''
    cp -Lr ${npmToNix { inherit src; }} node_modules
    chmod -R +w node_modules
    patchShebangs node_modules
  '';

  buildPhase = ''
    ${nodePackages.typescript}/bin/tsc --build ts-components
  '';

  installPhase = ''
    mkdir $out
    mv * $out
  '';

  fixupPhase = ''
    patchShebangs $out
  '';
}
