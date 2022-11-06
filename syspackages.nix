{ config, pkgs, ... }:

{

	services.flatpak.enable = true;
	virtualisation.podman = {
		enable = true;
		dockerCompat = true;	
	};	
	environment.systemPackages = with pkgs; [
		rnnoise-plugin
		nerdfonts
		nmon
		(pkgs.systemd.overrideAttrs (oldAttrs: {
			makeFlags = [ "-O3" ];
			}))

		(pkgs.brave.overrideAttrs (oldAttrs: {
			version = "1.45.121";
			src = fetchurl {
				url =  "https://github.com/brave/brave-browser/releases/download/v1.45.121/brave-browser_1.45.121_amd64.deb";
				sha256 = "sha256-ztshnxJ8XkhNvcu0rxcljIHcHOhmyPiMyBGn916HqK8=";
				};

			}))

	];
	environment.gnome.excludePackages = (with pkgs; [
		gnome-photos
		gnome-tour
		rhythmbox
		gnome-console
		]) ++ (with pkgs.gnome; [
  		cheese 
  		gnome-music
  		gnome-terminal
		epiphany 
		gnome-characters
		gnome-font-viewer
		gnome-logs
		totem
		gnome-maps
		yelp
		]);	
}
