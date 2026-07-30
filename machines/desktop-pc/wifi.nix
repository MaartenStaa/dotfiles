{
  config,
  inputs,
  pkgs,
  ...
}:
{

  boot.extraModulePackages = [
    (config.boot.kernelPackages.callPackage ./rtw89-8922au.nix { src = inputs.rtw89; })
  ];
  boot.kernelModules = [ "rtw89_8922au" ];

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0bda", ATTR{idProduct}=="1a2b", \
    RUN+="${pkgs.usb-modeswitch}/bin/usb_modeswitch -v 0bda -p 1a2b -K -b $env{BUSNUM} -g $env{DEVNUM}"
  '';
}
