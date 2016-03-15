# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in 
# the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, fetchurl, ... }: let
  myHostName = "Rizilab";

in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the gummiboot efi boot loader.
  boot = {
    initrd.luks.devices = [
      {
        name = "root";
        device = "/dev/sda3";
        preLVM = true;
      }
      {
        name = "home";
        device = "/dev/sdb1";
        preLVM = true;
      }
    ];

    loader.grub.device = "/dev/sda";
    loader.grub.version = 2;
    #loader.efi.efiSysMountPoint = "/boot"; loader.gummiboot.enable = true; loader.efi.canTouchEfiVariables = true;
  };

  #all additional nixpkgs config
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = super: let self = super.pkgs; in {
        #mumble + pulse audio
	mumble = super.mumble.override { pulseSupport = true; };

	#kernel for intel ethernet and Testing e1000e package override
        linuxPackages = super.linuxPackages // {
	  e1000e = pkgs.linuxPackages.e1000e.overrideDerivation (old: {
          name = "e1000e-3.3.3-${config.boot.kernelPackages.kernel.version}";
          src = fetchurl {
            url = "https://www.dropbox.com/s/pxx883hx9763ygn/e1000e-3.3.3.tar.gz?dl=0";
            sha256 = "1s2w54927fsxg0f037h31g3qkajgn5jd0x3yi1chxsyckrcr0x80";
          };
        });
      };
    };
  };
    
  

  networking = {
    hostName = "${myHostName}"; # Define your hostname.
    extraHosts = "127.0.0.1 ${myHostName}";
    networkmanager.enable = true; #recommended option
    firewall.allowedTCPPorts = [80 443];
    firewall.enable = false;
    interfaceMonitor.enable = true;
    # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
    #useDHCP = true;
    nameservers = ["8.8.8.8" "8.8.4.4" ];
    nat = {
      enable = true;
      internalInterfaces = ["ve-+"];
      externalInterface = "eth0";
    };
    #defaultGateway = "192.168.1.1";
    #interfaces = {
    #   eth0.ip4 = [
    #  ];
    #};
  };

  # Select internationalisation properties. i18n = {
  #   consoleFont = "Lat2-Terminus16"; consoleKeyMap = "us"; defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # List packages installed in system profile. To search by name, run: $ nix-env -qaP | grep wget
  environment = {
    systemPackages = with pkgs; [
      ascii
      attic
      bash
      cabal2nix
      chromium
      cmake
      ctags
      curl
      emacs
      file
      filezilla
      gcc
      gimp
      gitAndTools.qgit
      gitFull
      gnumake
      inkscape
      kde4.kdemultimedia
      kde4.kdeaccessibility
      kde4.kdeadmin
      kde4.kdeartwork
      kde4.kdebindings
      kde4.kdegraphics
      kde4.kdelibs
      kde4.kdenetwork
      kde4.kdesdk
      kde4.kdeutils
      kde4.kdetoys
      libreoffice
      lsof
      manpages
      mumble
      pavucontrol
      pciutils
      python2nix
      qemu
      remake
      rpPPPoE
      samba
      screen
      smartmontools
      stdmanpages
      telegram-cli
      texlive.combined.scheme-medium
      (texlive.combine {
        inherit (texlive) collection-langarabic
                          collection-langenglish
                          collection-publishers
                          collection-latex;
      })
      tree
      unrar
      unzip
      vim
      w3m
      wget
      wgetpaste
      which
      xchat
      xmonad-with-packages
      youtube-dl
      zsh
    ];

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "..2" = "cd ../..";
      "..3" = "cd ../../..";
      "..4" = "cd ../../../..";
      "lh" = "ls -lahg";
    };
  };

  # List services that you want to enable:
  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;
    
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      layout = "us";
      xkbOptions = "eurosign:e";

      # Enable the KDE Desktop Environment.
      displayManager.kdm.enable = true;
      desktopManager.kde4.enable = true;

      # Enable Xmonad
      windowManager.xmonad.enable = true;
      windowManager.default = "xmonad";

      #video driver
      videoDrivers = [ "nvidia" ];
    };
  };
  
  security.sudo.enable = true;

  hardware = {
    pulseaudio.enable = true;
    pulseaudio.support32Bit = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    pulseaudio.systemWide = true;
    opengl.driSupport32Bit = true;
  };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = "/run/current-system/sw/bin/bash";
    extraUsers.R = {
      isNormalUser = true;
      createHome = true;
      uid = 1001;
      extraGroups = [ "wheel" "networkmanager" ];
      home = "/home/R";
    };
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";
  
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "e1000e" ];

  #reflex-platform
  nix.trustedBinaryCaches = [ "https://nixcache.reflex-frp.org" ];
  nix.binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];

  #Container file system
  fileSystems."/var/lib/containers/behaskell/etc/nixos/" = {
    device = "/home/R/dotfiles/";
    options = "bind";
  };
}
