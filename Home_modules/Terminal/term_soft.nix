{pkgs, ...}:
{
  home.packages = with pkgs; [
    fastfetch
    nvtopPackages.nvidia
    weston
    imagemagick

    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # misc
    cowsay
    unrar
    peazip
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    ethtool
    pciutils # lspci
    usbutils # lsusb
    bindfs
  ];

}
