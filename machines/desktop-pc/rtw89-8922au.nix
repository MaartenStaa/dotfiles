{
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
}:

stdenv.mkDerivation rec {
  pname = "rtw89-8922au";
  version = "unstable-2026-07-28";

  src = fetchFromGitHub {
    owner = "morrownr";
    repo = "rtw89";
    rev = "08b8d326937a200a706ec9c501374eec15835b5a";
    hash = "sha256-tBW2TJjqwJRyxqfLAlqHtV9h6oLIBbU+10o57sJK4Sc=";
  };

  nativeBuildInputs = kernel.moduleBuildDependencies;

  buildPhase = ''
    make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
      M=$PWD ARCH=${stdenv.hostPlatform.linuxArch} V=1 modules
  '';

  installPhase = ''
    mkdir -p $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/rtw89
    cp *.ko $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/rtw89/
  '';
}
