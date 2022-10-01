{ config, pkgs, ... }:

{ 

    boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
	#not sure if thats really needed, and the package dont support my dongle yet anyways
    boot.extraModulePackages = ( with config.boot.kernelPackages; [ rtl88x2bu rtlwifi_new ]) ++ ( with pkgs; [ rtw88-firmware ]); 
    hardware.firmware = with pkgs; [ rtw88-firmware ];
    environment.systemPackages = ( with config.boot.kernelPackages; [
		kernel
		rtl88x2bu
		rtlwifi_new
]) ++ ( with pkgs ; [ ddcutil rtw88-firmware ]);

	boot.kernelParams = [ "amd_iommu=off" "iommu=soft" "quiet" "udev.log_level=3" "loglevel=3"];
	boot.consoleLogLevel = 0;
	boot.initrd.verbose = false;
	hardware.i2c.enable = true;
	zramSwap.enable = true;
	nix.gc.automatic = true;
	nix.gc.dates = "weekly";
	nix.gc.options = "--delete-older-than 7d";
	system.autoUpgrade.enable = true;
	system.autoUpgrade.allowReboot = false;

}

