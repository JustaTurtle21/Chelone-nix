{...}:
{
  programs.distrobox = {
    enable = true;
    containers = {
      vfx_box = {
        image = "fedora:latest";
        init = true;
        additional_packages = "systemd libpam-systemd pipewire-audio-client-libraries";
        additional_flags = "--device=nvidia.com/gpu=all --security-opt=label=disable";
      };
    };
  };
}
