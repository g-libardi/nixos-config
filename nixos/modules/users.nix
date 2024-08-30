{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.guilherme = {
    isNormalUser = true;
    description = "Guilherme";
    extraGroups = [ "networkmanager" "wheel" ];
  };

}
