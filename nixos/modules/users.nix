{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.libardi = {
    isNormalUser = true;
    description = "Libardi";
    extraGroups = [ "networkmanager" "wheel" ];
  };

}
