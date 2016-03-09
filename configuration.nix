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
      wget
      gcc
      gitAndTools.qgit
      file
      filezilla
      telegram-cli
      bash
      libreoffice
      gnumake
      tree
      w3m
      zsh
      xchat
      tree
      which
      gitFull
      ascii
      attic
      chromium
      ctags
      emacs
      vim
      stdmanpages
      qemu
      remake
      samba
      screen
      python2nix
      rpPPPoE
      manpages
      cabal2nix
      wget
      wgetpaste
      curl
      unzip
      youtube-dl
      smartmontools
      kde4.kdemultimedia
      kde4.kdeaccessibility
      kde4.kdeadmin
      kde4.kdeartwork
      kde4.kdebindings
      kde4.kdegraphics
      kde4.kdelibs
      kde4.kdemultimedia
      kde4.kdenetwork
      kde4.kdesdk
      kde4.kdeutils
      kde4.kdetoys
      xmonad-with-packages
      gimp
      #texLiveFull
      #texlive.combined.scheme-full
      #texlive.collection-latexrecommended.pkgs
      #texlive.collection-publishers.pkgs
      #texlive.collection-basic.pkgs
      #texlive.algorithms.pkgs
      #texlive.cm-super.pkgs
      texlive.combined.scheme-medium
      (texlive.combine {
        inherit (texlive) collection-langarabic
      collection-langenglish
      collection-publishers
      collection-latex;
      })
      
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
    };
  };
  
  security.sudo.enable = true;

  
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


  # Testing e1000e package override
  nixpkgs.config.packageOverrides = pkgs: rec {
    linuxPackages.e1000e = pkgs.linuxPackages.e1000e.overrideDerivation (attrs: {
      name = "e1000e-3.3.3-${config.boot.kernelPackages.kernel.version}";
      src = fetchurl {
        url = "https://www.dropbox.com/s/pxx883hx9763ygn/e1000e-3.3.3.tar.gz?dl=0";
        sha256 = "1s2w54927fsxg0f037h31g3qkajgn5jd0x3yi1chxsyckrcr0x80";
      };
    });
  };
  
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "e1000e" ];

  #reflex-platform
  nix.trustedBinaryCaches = [ "https://nixcache.reflex-frp.org" ];
  nix.binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];
}
