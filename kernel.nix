{ config, pkgs, ... }:

{ 
    boot = {
    	kernelPackages = pkgs.linuxPackages_xanmod_latest;
    	extraModulePackages = ( with config.boot.kernelPackages; [ 
    			rtl88x2bu
#    			rtlwifi_new 
    	]) ++ ( with pkgs; [ 
#    			rtw88-firmware
				ecryptfs
    		 	]); 
    	};
#    hardware.firmware = with pkgs; [ rtw88-firmware ];
    environment.systemPackages = ( with config.boot.kernelPackages; [
		kernel
		rtl88x2bu
#		rtlwifi_new
]) ++ ( with pkgs ; [ ddcutil rtw88-firmware ]);
	boot = {
		kernelParams = [ "amd_iommu=off" "iommu=soft" "quiet" "udev.log_level=3" "loglevel=3"];
		consoleLogLevel = 0;
		initrd.verbose = false;
		kernelModules = [ "ecryptfs" ];
		supportedFilesystems = [ "ecryptfs" ];
		};
	hardware.i2c.enable = true;
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 7d";
		};
	system.autoUpgrade = {
		enable = true;
		dates = "daily";
		channel = "nixos https://nixos.org/channels/nixos-unstable";
		allowReboot = false;
	};
}

