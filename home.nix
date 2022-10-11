{ config, pkgs, lib, ... }:

with lib.hm.gvariant;

let
	home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
	bedtime8 = import (builtins.fetchTarball {
		url = "https://github.com/NixOS/nixpkgs/archive/d1c3fea7ecbed758168787fe4e4a3157e52bc808.tar.gz";
		}) {};
in

{
	imports = [ (import "${home-manager}/nixos") ];		
	environment.pathsToLink = [ "/share/zsh" ];
	users.users.lucio.shell = pkgs.zsh;
	environment.shells = with pkgs; [ zsh ];
	home-manager.users.lucio = { lib, ... }: with lib.hm.gvariant; {
	home.stateVersion = "22.11";
	home.packages =  (with pkgs ; [ 
		brave
		calibre
		transmission-gtk
		foliate
		deja-dup
		vlc
		authenticator	
		nordzy-icon-theme
		disfetch
		stremio
		kotatogram-desktop
		ventoy-bin-full
		taskwarrior
		steam-run
		dconf2nix
		arcanPackages.espeak
		detox
		hakuneko
 		]) ++ (with pkgs.gnomeExtensions ;[
 		bedtime8.pkgs.gnomeExtensions.gnome-bedtime
		caffeine
		dash-to-panel
		task-widget
 		]);
 	programs.tmux = {
		enable = true;
 		};
	programs.alacritty = {
			enable = true;
			settings = {
				font.family = "JetBrainsMono";
				window = { 
					padding = {
						x = 5;
						y = 5;
						};
					decorations = "none";
				};
			};
		};
	programs.neovim = {
		enable = true;
		};
	programs.zsh ={
			enable = true;
			enableAutosuggestions = true;
			enableCompletion =true;
			enableSyntaxHighlighting = true;
			dotDir = ".config/zsh";
			oh-my-zsh= {
				enable = true;
				theme = "alanpeabody";
			};
	initExtraFirst = ''
		# Base16 Shell
		BASE16_SHELL="$HOME/.config/base16-shell-master/"
		[ -n "$PS1" ] && \
		    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
		        source "$BASE16_SHELL/profile_helper.sh"
      		'';		
	shellAliases = {
			ls = "ls -A --color=auto -cltp --si --group-directories-first";
			otcry = "sudo cryptsetup tcryptOpen";
			ctcry = "sudo cryptsetup tcryptClose";
			oluks = "sudo cryptsetup luksOpen";
			cluks = "sudo cryptsetup luksClose";
			nluks = "cryptsetup --type luks -c serpent-xts-plain64 -s 512 --hash whirlpool luksFormat";
			};
		};
	programs.git = {
			enable = true;
			userEmail = "8f2w79@getgoogleoff.me";
			userName = "wnxkiv85";		
			};
	home.file = {
		".face" = {
				source = pkgs.fetchurl { 
				url = "https://nitter.net/pic/media%2FFN_lMoOVUAAnVUd.jpg"; 
				sha256 = "a476548d48768690f44fd8c67f0a566224112bc1003a3a9fa6b3edc18d8bc14e";
						};
			};
		".background-image" = {
				source = pkgs.fetchurl { 
				url = "https://r4.wallpaperflare.com/wallpaper/776/264/978/anime-overlord-shalltear-bloodfallen-hd-wallpaper-8960282de16add5b56a7784fc0d1a6cd.jpg"; 
				sha256 = "f3a35c5b0b37d05bbc1a9f343cc98e7a86495e78816bd2302cff552d925f8f03";
						};
			};
		"Sakuya-cursors" = {
				source = pkgs.fetchzip { 
				url = "https://0x0.st/o4wb.zip"; 
				sha512 = "1l4l9i0v1n4c4p9047wywhcwr4kdir1lrl34pi1fjbswgvsjyzwmjrxqy1zjihz3prpck040mdxaimqcmhzn9icz93221ids6rvvk33";
						};
				target = ".local/share/icons/Sakuya-cursors";
			};
		"base16-shell-master" = {
				source = pkgs.fetchzip {
				url = "https://github.com/chriskempson/base16-shell/archive/refs/heads/master.zip" ;
				sha512 = "0c0lm47wwcqd2lc0293awr8kvpib8pcq1kgnilnbg0d2g0b65if0aj0yrmv1sg3z78c15ssksv9j7ikbhhwifdg3360ypk2plrfyrny";	
				};
				target = ".config/base16-shell-master";
			};
		};
		dconf.settings = {
		"org/gnome/desktop/peripherals/trackball" = { scroll-wheel-emulation-button = 8; };
		"org/gnome/desktop/background" = {
				color-shading-type = "solid";
				picture-options = "zoom";
				picture-uri = "file:///home/lucio/.background-image";
				picture-uri-dark = "file:///home/lucio/.background-image";
				primary-color = "#000000000000";
				secondary-color = "#000000000000";
				};
		"org/gnome/desktop/interface" = { 
				cursor-theme = "Sakuya-cursors";
				icon-theme = "Nordzy-dark";
				document-font-name = "Liberation Serif 13";
				font-name = "Liberation Sans 11";
				monospace-font-name = "Liberation Sans 11";
				};
		"org/gnome/system/locale" = { 
				region = "pt_BR.UTF-8"; 
				};
		"org/gnome/shell/keybindings" = {
				switch-to-application-1 = [ "" ];
				switch-to-application-2 = [ "" ];
				switch-to-application-3 = [ "" ];
				switch-to-application-4 = [ "" ];

				};
		"org/gnome/desktop/wm/keybindings" = {
				move-to-workspace-1 = [ "<Shift><Super>exclam" ];
				move-to-workspace-2 = [ "<Shift><Super>at" ];
				move-to-workspace-3 = [ "<Shift><Super>numbersign" ];
				move-to-workspace-4 = [ "<Shift><Super>dollar" ];
				switch-to-workspace-1 = [ "<Super>1" ];
				switch-to-workspace-2 = [ "<Super>2" ];
				switch-to-workspace-3 = [ "<Super>3" ];
				switch-to-workspace-4 = [ "<Super>4" ];
				};
		"org/gnome/settings-daemon/plugins/media-keys" = {
				mic-mute = [ "<Shift><Super>BackSpace" ];
				volume-down = [ "<Super>minus" ];
				volume-mute = [ "<Super>BackSpace" ];
				volume-up = [ "<Super>equal" ];
				};
		"org/gnome/settings-daemon/plugins/color" = {
				night-light-enabled = true;
				night-light-schedule-automatic = true;			
				};
		"org/gnome/desktop/wm/preferences" = {
				num-workspaces = 4;
				};
		"org/gnome/desktop/input-sources" = {
				sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "us+alt-intl" ]) ];
				xkb-options = [ "terminate:ctrl_alt_bksp" "caps:swapescape" ];
				};
		"org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
				binding = "<Shift><Super>underscore";
				command = "ddcutil setvcp 10 - 20";
				name = "backlightdown";
				};
		"org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
				binding = "<Shift><Super>plus";
				command = "ddcutil setvcp 10 + 20";
				name = "backlightup";
				};
		"org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
				binding = "<Super>Return";
				command = "alacritty";
				name = "Terminal";
				};
		"org/gnome/shell/extensions/dash-to-panel" = {
				animate-appicon-hover-animation-extent = "{'RIPPLE': 4, 'PLANK': 4, 'SIMPLE': 1}";
				appicon-margin = 8;
				appicon-padding = 4;
				available-monitors = [ 0 ];
				hide-overview-on-startup = true;
				hotkeys-overlay-combo = "TEMPORARILY";
				leftbox-padding = -1;
				panel-anchors = ''
						{"0":"MIDDLE"}
						'';
				panel-lengths = ''
						{"0":100}
						'';
				panel-sizes = ''
						{"0":48}
						'';
				primary-monitor = 0;
				progress-show-count = false;
				status-icon-padding = -1;
				trans-bg-color = "#323232";
				trans-use-custom-bg = true;
				tray-padding = -1;
				window-preview-title-position = "TOP";
			 	};

		}; #######DCONF END##########
	
    /* Here goes your home-manager config, eg home.packages = [ pkgs.foo ]; */
  }; #######lucio END
}
