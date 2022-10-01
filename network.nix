{ config, pkgs, ...}:

{
	networking.hostName = "inferno";
	services.printing.enable = true;
	 networking = {
		nameservers = [ "127.0.0.1" "::1" ];
		networkmanager.enable = true;
		networkmanager.dns = "none";
		};
	services.nextdns = {
		enable = true;
		arguments = [ "-config" "cc6b68" "-cache-size" "20MB" ];
	};
	programs.ssh.startAgent = true;




}
