{
  stdenv,
  kernel,
  src,
}:

stdenv.mkDerivation {
  pname = "rtw89-8922au";
  version = src.shortRev or "unstable";

  inherit src;

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
