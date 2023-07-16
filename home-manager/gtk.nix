{ pkgs, ... }:

let
  catppuccin = pkgs.catppuccin-gtk.override {
    accents = [ "pink" ];
    size = "compact";
    tweaks = [ "rimless" "black" ];
    variant = "mocha";
  };

  themeName = "Catppuccin-Mocha-Compact-Pink-Dark";
in
{
  gtk = {
    enable = true;
    font.name = "TeX Gyre Adventor 10";
    theme = {
      name = themeName;
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

  home.file =
    let
      themeDir = "${catppuccin}/share/themes/${themeName}/gtk-4.0/";
    in
    {
      ".config/gtk-4.0/gtk.css".source = "${themeDir}/gtk.css";
      ".config/gtk-4.0/gtk-dark.css".source = "${themeDir}/gtk-dark.css";

      ".config/gtk-4.0/assets" = {
        recursive = true;
        source = "${themeDir}/assets";
      };
    };
}
