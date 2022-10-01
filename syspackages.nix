{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [ 
		epson-escpr2
		micro
		nextdns
		rnnoise-plugin
	];

	environment.gnome.excludePackages = (with pkgs; [
		gnome-photos
		gnome-tour
		rhythmbox
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
