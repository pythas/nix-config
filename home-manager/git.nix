{ pkgs, ... }:

let
  catppuccin = pkgs.catppuccin-gtk.override {
    accents = [ "pink" ];
    size = "compact";
    tweaks = [ "rimless" "black" ];
    variant = "mocha";
  };
in
{
  gtk = {
    enable = true;
    font.name = "TeX Gyre Adventor 10";
    theme = {
      name = "Catppuccin-Mocha-Compact-Pink-Dark";
      package = catppuccin;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    #gtk3.extraConfig = {
    #  Settings = ''
    #    gtk-application-prefer-dark-theme=1
    #  '';
    #};
    #gtk4.extraConfig = {
    #  Settings = ''
    #    gtk-application-prefer-dark-theme=1
    #  '';
    #};
  };
};
