{ pkgs, ... }:

{
  home.file.".config/waybar/theme" = {
    recursive = true;
    source = "${pkgs.fetchgit {
      url = "https://github.com/catppuccin/waybar.git";
      sha256 = "sha256-WLJMA2X20E5PCPg0ZPtSop0bfmu+pLImP9t8A8V4QK8=";
      sparseCheckout = [ "themes" ];
    }}/themes";
  };

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [ "wlr/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "battery" "pulseaudio" "backlight" "cpu" "memory" "clock" "network" ];

       "wlr/workspaces" = {
         format = "{icon}";
         format-icons = {        
           default = "<span color=\"#45475a\"></span>";
           active = "<span color=\"#04a5e5\">⬤</span>";
         };
       };

       "battery" = {
         format = "{icon} {capacity}%";
         format-icons = [ "" "" "" "" "" ];
       };

       "pulseaudio" = {
         format = "{icon} {volume}%";
         format-icons = [ "" ];
       };

       "backlight" = {
         format = "{icon} {percent}%";
         format-icons = [ ""];
       };

       "cpu" = {
         format = " {usage}%";
       };

       "memory" = {
         format = " {percentage}%";
       };

       "network" = {
         format = "{icon}";
         format-icons = [ "" "" ];
       };

       "clock" = {
         format = " {:%H:%M}";
       };
      };
    };

    style = ''
      @import "theme/mocha.css";

      * {
        color: @text;
        font-family: FontAwesome, Roboto, sans-serif;
      }

      window#waybar {
        /* background-color: shade(@base, 0.9);*/
        background-color: transparent;
      }

      window#waybar > box {
        padding: 8px;
      }

      .modules-left {
        background-color: alpha(@surface2, 0.5);
        border-radius: 8px;
      }

      .modules-left {
        background-color: @text;
      }

      .modules-center,
      .modules-right {
        background-image: linear-gradient(177deg, alpha(@surface2, 0.05) 20%, alpha(@surface2, 0.05) 22%, alpha(@surface2, 0.5) 100%);
        border-radius: 8px; 
      }

      /*.modules-right > widget {
        background-color: transparent;
      }

      .modules-right > widget > label {
        background-color: alpha(@surface2, 0.5);
      }

      .modules-right > widget:first-child > label {
        border-top-left-radius: 8px;
        border-bottom-left-radius: 8px;
      }
      
      .modules-right > widget:nth-last-child(2) > label {
        border-top-right-radius: 8px;
        border-bottom-right-radius: 8px;
      }

      .modules-right > widget:nth-last-child(1) > label {
        border-radius: 8px;
      }*/

      widget > label {
        padding: 0 10px;
      }

      #workspaces {
      }

      /*#window {
        background-color: alpha(@surface2, 0.5);
        border-radius: 8px;
      }*/

      #window.empty {
        background-color: transparent;
      }

      #battery {
        color: @green;
      }

      #pulseaudio {
        color: @red;
      }

      #backlight {
        color: @yellow;
      }

      #cpu {
        color: @blue;
      }

      #memory {
        color: @mauve;
      }

      #network {
        /*margin-left: 10px;*/
      }
    '';
  };
}
