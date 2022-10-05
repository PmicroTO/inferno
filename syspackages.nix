{ config, pkgs, ... }:

{
	virtualisation.podman = {
		enable = true;
		dockerCompat = true;	
	};	
	environment.systemPackages = with pkgs; [ 
		micro
		rnnoise-plugin
		nerdfonts
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
