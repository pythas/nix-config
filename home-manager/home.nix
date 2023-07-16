# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    inputs.hyprland.homeManagerModules.default
    ./gtk.nix
    ./waybar.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "johan";
    homeDirectory = "/home/johan";
  };

  # nvim
  # programs.neovim = {
  #   enable = true;
  #   plugins = with pkgs.nvimPlugins; [
  #     
  #   ];
  # };

  #home.file.".config/nvim" = {
  #  recursive = true;
  #  source = ../dotfiles/nvim;
  #};

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # catppuccin.catppuccin-vsc
      # ms-vscode-remote.remote-ssh
    ];
  };

  home.packages = with pkgs; [
    firefox
    font-awesome_5
    hyprpaper
    cliphist
  ];

  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ~/Pictures/bg1.jpg
    wallpaper = eDP-1,~/Pictures/bg1.jpg
  '';

  # Kitty
  home.file.".config/kitty/catppuccin" = {
    recursive = true;
    source = pkgs.fetchgit {
      url = "https://github.com/catppuccin/kitty.git";
      sha256 = "sha256-uZSx+fuzcW//5/FtW98q7G4xRRjJjD5aQMbvJ4cs94U=";
    };
  };

  programs.kitty = {
    enable = true;
    extraConfig = ''
      include ./catppuccin/themes/mocha.conf
    '';
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Johan Grönberg";
    userEmail = "pythas@gmail.com";
  };

  # Bash
  programs.bash.enable = true;

  programs.wofi.enable = true;

  # Hyprland
  home.file.".config/hypr/theme" = {
    recursive = true;
    source = "${pkgs.fetchgit {
      url = "https://github.com/catppuccin/hyprland.git";
      sha256 = "sha256-Z7fLzmjsUJwKeUORWppcpeBKcZzuZL0vcXF3k3QecjU=";
      sparseCheckout = [ "themes" ];
    }}/themes";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      source=~/.config/hypr/theme/mocha.conf

exec-once = waybar
exec-once = wl-paste --type text --watch cliphist store
exec-once = mako
exec = hyprpaper

monitor = ,1920x1080,0x0,1

general {
  border_size = 2;
  col.inactive_border = $base;
  col.active_border = $text;
}

decoration {
  rounding = 4;
  active_opacity = 0.98;
  inactive_opacity = 0.9;
}

input {
  kb_layout = se
}

misc {
  disable_hyprland_logo = true
  disable_splash_rendering = true
}

bind = SUPER, return, exec, kitty
bind = SUPER, b, exec, firefox
bind = SUPER, space, exec, wofi --show drun

bind = SUPER, e, exit,
bind = SUPER, w, killactive,

# bind = $mod, S, togglesplit,
bind = SUPER, f, fullscreen, 1
bind = SUPERSHIFT, f, fullscreen, 0
bind = SUPERSHIFT, space, togglefloating

# Move focus
bind = SUPER, up, movefocus, u
bind = SUPER, right, movefocus, r
bind = SUPER, down, movefocus, d
bind = SUPER, left, movefocus, l

bind = SUPERSHIFT, up, swapwindow, u
bind = SUPERSHIFT, right, swapwindow, r
bind = SUPERSHIFT, down, swapwindow, d
bind = SUPERSHIFT, left, swapwindow, l

# bind = SUPERCONTROL, left, focusmonitor, l
# ...

# bind = SUPERCONTROLSHIFT, left, movewindow, mon:l
# ...

# bind = SUPERALT, left, movecurrentworksapcemonitor, l

bind = SUPER, 1, workspace, 01 
bind = SUPER, 2, workspace, 02
bind = SUPER, 3, workspace, 03 
bind = SUPER, 4, workspace, 04 
bind = SUPER, 5, workspace, 05 
bind = SUPER, 6, workspace, 06 
bind = SUPER, 7, workspace, 07 
bind = SUPER, 8, workspace, 08 
bind = SUPER, 9, workspace, 09 
bind = SUPER, 0, workspace, 10

bind = SUPERSHIFT, 1, movetoworkspacesilent, 01 
bind = SUPERSHIFT, 2, movetoworkspacesilent, 02 
bind = SUPERSHIFT, 3, movetoworkspacesilent, 03 
bind = SUPERSHIFT, 4, movetoworkspacesilent, 04 
bind = SUPERSHIFT, 5, movetoworkspacesilent, 05 
bind = SUPERSHIFT, 6, movetoworkspacesilent, 06 
bind = SUPERSHIFT, 7, movetoworkspacesilent, 07 
bind = SUPERSHIFT, 8, movetoworkspacesilent, 08 
bind = SUPERSHIFT, 9, movetoworkspacesilent, 09 
bind = SUPERSHIFT, 0, movetoworkspacesilent, 10 
'';
  };

  # Mako
  services.mako = {
    enable = true;
    backgroundColor = "#313244aa";
    borderColor = "#313244aa";
    borderRadius = 8;
    textColor = "#cdd6f4ff";
    font = "Roboto 10";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
