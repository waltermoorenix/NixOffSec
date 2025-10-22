{ config, pkgs, ... }:

{
  # Basic system configuration
  imports = [ ];

  # Use the latest stable kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable networking and SSH server for remote access
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  services.openssh.enable = true;
  users.users.student = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    password = "changeme";  # Replace with a secure password or better, use hashedPassword
  };

  # Enable sudo for admin tasks
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # Desktop environment - XFCE
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Enable VirtualBox guest tools if running inside VirtualBox VM
  virtualisation.virtualbox.guest.enable = true;

  # Install cybersecurity tools and developer utilities
  environment.systemPackages = with pkgs; [
    wireshark
    nmap
    tcpdump
    aircrack-ng
    john  # John the Ripper
    hashcat
    metasploit
    sqlmap
    hydra
    netcat
    openvpn
    gnupg
    curl
    wget
    git
    vscode  # For code editing
    firefox
    gnome-keyring
    virtmanager  # Virtual machine management
    qemu  # Hypervisor for nested virtualization
    docker
    python3
    python3Packages.pip
    gcc
    make
    vim
    nano
    xfce.xfce4-appfinder
  ];

  # Enable Docker service if needed for containerized environments
  services.docker.enable = true;

  # NetworkManager for managing wifi and other networks
  networking.networkmanager.enable = true;

  # Time and localization settings
  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable firewall with basic protection
  networking.firewall.enable = true;

  # Allow the student user to reboot, shutdown
  systemd.services.reboot.allowStart = true;
  systemd.services.poweroff.allowStart = true;

  # Miscellaneous useful tools for cybersecurity students
  environment.systemPackages = environment.systemPackages ++ with pkgs; [
    zsh
    tmux
    socat
    strace
    lsof
    jq
  ];

  # Enable system updates notifications (nix nixos-upgrade)
  system.autoUpgrade.enable = true;

  # Parameters for development environment can be added here
}
