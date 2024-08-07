{ lib
, stdenv
, fetchFromGitHub
, fetchpatch
}:

stdenv.mkDerivation {
  pname = "move-mount-beneath";
  version = "unstable-2023-11-26";

  src = fetchFromGitHub {
    owner = "hpsaucii";
    repo = "move-mount-beneath";
    rev = "ebbcef2401f77da4e27ac644ffe905103d13d416";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";  # Replace with actual hash
  };

  installPhase = ''
    runHook preInstall
    install -D move-mount $out/bin/move-mount
    runHook postInstall
  '';

  patches = [
    # Fix uninitialized variable in flags_attr, https://github.com/brauner/move-mount-beneath/pull/2
    (fetchpatch {
      name = "aarch64";
      url = "https://github.com/brauner/move-mount-beneath/commit/0bd0b863f7b98608514d90d4f2a80a21ce2e6cd3.patch";
      hash = "sha256-D3TttAT0aFqpYC8LuVnrkLwDcfVFOSeYzUDx6VqPu1Q=";
    })
  ];

  meta = {
    description = "Toy binary to illustrate adding a mount beneath an existing mount";
    mainProgram = "move-mount";
    homepage = "https://github.com/brauner/move-mount-beneath";
    license = lib.licenses.mit0;
    maintainers = with lib.maintainers; [ nikstur ];
  };
}
