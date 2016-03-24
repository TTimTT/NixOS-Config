# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.extraEntries = 
  ''
  menuentry 'Windows 8' --class windows --class os menuentry_id_option 'osprober-chain-E6CC7345CC730ED5' {
        insmod part_msdos
        insmod ntfs
        set root='hd0,msdos1'
        if [ x$feature_platform_search_hint = xy ]; then
          search --no-floppy --fs-uuid --set=root --hint-bios=hd0,msdos1 --hint-efi=hd0,msdos1 --hint-baremetal=ahci0,msdos1  0D35BC4E0510DD23
        else
          search --no-floppy --fs-uuid --set=root 0D35BC4E0510DD23
        fi
        chainloader +1
  }
  '';


  networking.hostName = "NixPad"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "fr_CH";
    defaultLocale = "en_US.UTF-8";
#    supportedLocales = ["en_US.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8"];
    inputMethod.enabled = "ibus";
    inputMethod.ibus.engines = with pkgs.ibus-engines; [ anthy ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

 

  nixpkgs.config = {

    allowUnfree = true;

    firefox = {
     enableGoogleTalkPlugin = true;
     enableGnomeExtensions = true;
     enableAdobeFlash = true;
    };

  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    anthy
    busybox
    evince
    gimp
    git
    gnome3.gedit
    firefox-esr-wrapper
    kochi-substitute
    inkscape
    jdk7
    ibus
    libreoffice
    gnumake
    mplayer
#    minecraft
    nano
    ncmpcpp
    nox
    python3
    qemu
    sshfsFuse
    texLiveFull
    thunderbird
    unzip
    vim
    wget
    hexchat
    zip
  ];
#  nixpkgs.config.allowUnfree = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "ch";
  services.xserver.xkbVariant = "fr";
  services.xserver.xkbOptions = "eurosign:e";
  #services.xserver.videoDrivers = [ "nouveau" ];

  # Enable the GNOME3 Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  #services.xserver.displayManager.auto.user = "guest";
  services.xserver.desktopManager.gnome3.enable = true;

#  hardware.opengl.driSupport32Bit = true;
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.tim = {
    isNormalUser = true;
    home = "/home/tim";
    description = "tim";
    extraGroups = [ ];
    uid = 1000;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

}
