{ config, pkgs, ... }:

{
	services.mopidy = {
		enable = true;
		extensionPackages = with pkgs; [ mopidy-ytmusic mopidy-iris mopidy-muse mopidy-local mopidy-podcast ];
		configuration = "
			[ytmusic]
			stream_preference = 251, 140, 250, 249
		";
	};

	
	virtualisation.podman = {
		enable = true;
		dockerCompat = true;	
	};
	
	environment.systemPackages = with pkgs; [ 
		epson-escpr2
		micro
		nextdns
		rnnoise-plugin
		mopidy
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
