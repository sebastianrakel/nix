{ lib, inputs, config, pkgs, modulesPath, ... }:
{
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;

  services.printing.drivers = with pkgs; [
    foomatic-db
    foomatic-db-ppds
    gutenprint
    gutenprintBin
    cups-dymo
  ];
}
