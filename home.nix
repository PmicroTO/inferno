{ config, pkgs, lib, ... }:

with lib.hm.gvariant;

let
	home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in

{
	imports = [ (import "${home-manager}/nixos") ];		
	environment.pathsToLink = [ "/share/zsh" ];
	users.users.lucio.shell = pkgs.zsh;
	environment.shells = with pkgs; [ zsh ];
	home-manager.users.lucio = { lib, ... }: with lib.hm.gvariant; {
	home.stateVersion = "22.11";
	home.packages =  (with pkgs ; [ 
#		brave
		(pkgs.brave.overrideAttrs (oldAttrs: {
			version = "1.45.121";
			src = fetchurl {
				url =  "https://github.com/brave/brave-browser/releases/download/v1.45.121/brave-browser_1.45.121_amd64.deb";
				sha256 = "sha256-ztshnxJ8XkhNvcu0rxcljIHcHOhmyPiMyBGn916HqK8=";
				};

			}))

		calibre
		transmission-gtk
		foliate
		pika-backup
		vlc
		authenticator	
		nordzy-icon-theme
		disfetch
		ventoy-bin-full
		taskwarrior
		steam-run
		dconf2nix
		arcanPackages.espeak
		detox
		hakuneko
		gnome-console
		adw-gtk3
		ecryptfs
		ecryptfs-helper
		droidcam
		webcamoid
		gnome.pomodoro
 		]) ++ (with pkgs.gnomeExtensions ;[
 		gnome-bedtime
		espresso
		dash-to-panel
 		]);
 	programs.vscode = {
		enable = true;
#		enableUpdateCheck = false;
#		enableExtensionUpdateCheck = false;
		package = pkgs.vscodium;
		extensions = (with pkgs ;[ vscode-extensions.ms-python.python ]);
 		};
 	programs.tmux = {
		enable = true;
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
			taskpurge = "task $(task uuids due.before:now) purge";
			opvault = "ecryptfs-mount-private ; sleep 300 ; ecryptfs-umount-private";
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
				url = "https://images3.alphacoders.com/784/784785.png"; 
				sha256 = "7991fea419fecd3f17f90037ea4e1e227aa9b9f97b2196f1c66429c41da7122d";
						};
			};
		"Sakuya-cursors" = {
				source = pkgs.fetchzip { 
				url = "https://0x0.st/o4wb.zip"; 
				sha512 = "1l4l9i0v1n4c4p9047wywhcwr4kdir1lrl34pi1fjbswgvsjyzwmjrxqy1zjihz3prpck040mdxaimqcmhzn9icz93221ids6rvvk33";
						};
				target = ".local/share/icons/Sakuya-cursors";
			};
		"Quartz-Chicle-main" = {
				source = pkgs.fetchzip { 
				url = "https://github.com/darkomarko42/Quartz/archive/refs/tags/0.6.zip";
				sha256 = "005jn8yjikzq0krkz1gxhs18ia7vws2z95d96609h52jniyydbln";
						} + "/Quartz";
				target = ".local/share/themes/quartz";
			};
 		"Gruvbox-Dark-BL" ={ 
 				source = pkgs.fetchFromGitHub {
    			owner = "Fausto-Korpsvart";
    			repo = "Gruvbox-GTK-Theme";
    			rev = "9f68262b38f015eb0c21d895a6d4e2208f1edae2";
    			sha256 = "05wda3i758jj58vh8rwbhd7njxdm0ighcsdfqbwxds2kr4rhym8a";
  						} + "/themes/Gruvbox-Dark-BL";
  				target = ".local/share/themes/Gruvbox-Dark-BL";

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
				icon-theme = "Nordzy-pink";
				document-font-name = "Liberation Serif 13";
				font-name = "Liberation Sans 11";
				monospace-font-name = "SauceCodePro Nerd Font Mono 11";
				gtk-theme = "adw-gtk3";
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
				command = "kgx";
				name = "Terminal";
				};
		"org/gnome/shell/extensions/dash-to-panel" = {
      animate-appicon-hover-animation-extent = "{'RIPPLE': 4, 'PLANK': 4, 'SIMPLE': 1}";
      appicon-margin = 6;
      appicon-padding = 4;
      available-monitors = [ 0 ];
      dot-position = "BOTTOM";
      dot-style-focused = "DOTS";
      dot-style-unfocused = "DOTS";
      group-apps = true;
      hide-overview-on-startup = true;
      hotkeys-overlay-combo = "TEMPORARILY";
      leftbox-padding = -1;
      overview-click-to-exit = false;
      panel-anchors = ''
        {"0":"MIDDLE"}
      '';
      panel-element-positions = ''
        {"0":[{"element":"showAppsButton","visible":true,"position":"centerMonitor"},{"element":"activitiesButton","visible":false,"position":"centered"},{"element":"leftBox","visible":false,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"centerMonitor"},{"element":"centerBox","visible":false,"position":"centerMonitor"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":false,"position":"stackedBR"}]}
      '';
      panel-lengths = ''
        {"0":100}
      '';
      panel-positions = ''
        {"0":"BOTTOM"}
      '';
      panel-sizes = ''
        {"0":48}
      '';
      primary-monitor = 0;
      progress-show-count = false;
      show-appmenu = false;
      show-favorites = true;
      show-running-apps = true;
      status-icon-padding = -1;
      stockgs-keep-top-panel = false;
      trans-bg-color = "#323232";
      trans-panel-opacity = 0.9500000000000001;
      trans-use-custom-bg = true;
      trans-use-custom-opacity = false;
      tray-padding = -1;


			 	};
			 	
		"user-theme" = { name = "quartz"; };

		}; #######DCONF END##########
	xdg.userDirs = {
		enable = true;
		createDirectories = true;
		documents = "/mnt/f1451973-4324-4d88-bb57-4a712f7beaf0/Documents";
		download = "/mnt/f1451973-4324-4d88-bb57-4a712f7beaf0/Downloads";
		music = "/mnt/f1451973-4324-4d88-bb57-4a712f7beaf0/Music";
		pictures = "/mnt/f1451973-4324-4d88-bb57-4a712f7beaf0/Pictures";
		videos = "/mnt/f1451973-4324-4d88-bb57-4a712f7beaf0/Videos";
		
		};
	
    /* Here goes your home-manager config, eg home.packages = [ pkgs.foo ]; */
  }; #######lucio END
	programs.droidcam.enable = true;
}
