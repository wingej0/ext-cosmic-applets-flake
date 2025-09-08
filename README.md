# Cosmic Applets for NixOS   
A collection of Cosmic Applets packaged for NixOS with a big thank you to [Gurjaka](https://github.com/Gurjaka), without whom the project wouldn't have been possible.   
   
## Applets   
The following applets for the Cosmic Desktop are packaged here:   
- [cosmic-ext-applet-caffeine](https://github.com/tropicbliss/cosmic-ext-applet-caffeine)   
- [cosmic-ext-applet-clipboard-manager](https://github.com/cosmic-utils/clipboard-manager)   
- [cosmic-ext-applet-emoji-selector](https://github.com/bGVia3VjaGVu/cosmic-ext-applet-emoji-selector)   
- [cosmic-ext-applet-weather](https://github.com/cosmic-utils/cosmic-ext-applet-weather)   
- [cosmic\_ext\_bg\_theme](https://github.com/wash2/cosmic_ext_bg_theme)   
- [minimon-applet](https://github.com/cosmic-utils/minimon-applet)   
   
For usage instructions, please visit the projects' github pages.  Applet usage is beyond the scope of this project.   
   
## Installation Instructions   
Add the following line to the inputs of your flake.nix:   
```nix
cosmic-applets-collection.url = "github:wingej0/ext-cosmic-applets-flake";
```
Then, to install all of the packages, add this line to your packages list (This assumes that you use @inputs in your flake.  If you don't, adjust this line accordingly):   
```nix
inputs.cosmic-applets-collection.packages."${system}".default
```
Or, you can install packages separately by defining which package you want to install instead of using default like this:   
```nix
inputs.cosmic-applets-collection.packages."${system}".minimon-applet
```
Use the names from the applets section above to install individual packages.  

## BG Theme Service
If you want to use the bg_theme extension as a service that will automatically when the wallpaper changes, create the following module:
```nix
{ config, lib, pkgs, inputs, ... }:
let
    cosmic-bg-theme = inputs.cosmic-applets-collection.packages.${pkgs.system}.cosmic-ext-bg-theme;
in
{
    systemd.user.services.cosmic-ext-bg-theme = {
        description = "COSMIC Background Theme Extension";
        documentation = [ "man:cosmic-ext-bg-theme(1)" ];
        partOf = [ "graphical-session.target" ];
        wantedBy = [ "graphical-session.target" ];
        
        serviceConfig = {
            Type = "simple";
            ExecStart = "${cosmic-bg-theme}/bin/cosmic-ext-bg-theme";
            Restart = "on-failure";
        };
    };
}
```
   
## Contributing   
We love contributions!  Feel free to fork the repository, create a branch, and submit a pull request.   
   
## License   
This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for more details.   
   