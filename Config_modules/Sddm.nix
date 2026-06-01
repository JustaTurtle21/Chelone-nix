{config, inputs, pkgs, lib, ...}:

let
    # Brings in wallpaper from desktophut
    pixel-bg = pkgs.fetchurl{
      url = "https://www.desktophut.com/files/DV9plumpFuju6wQ_Japanese%20Pixel%20City%20Live%20Wallpaper_2_prob4.mp4";
      hash = "sha256-PEFNIw2IEtz8d7grk9hqNWzYmYSf1xHHAa+9XUQF+OU=";
    };
    # Overrides Silent sddm themes (check flake.nix of silent sddm if confused)
    sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
        theme = "rei"; # select general theme
        # aditional backgrounds
        extraBackgrounds = [pixel-bg];
        # Overrides config set by silent sddm.conf
        theme-overrides = {
          # For viable options check https://github.com/uiriansan/SilentSDDM/wiki/Options
          "LoginScreen" = {
            #Use the file’s name, not its /nix/store path. Silent SDDM expects a filename in its backgrounds dir; extraBackgrounds copies pixelBg there, so set background = "${pixelBg.name}" instead of using the full store path.
             background = "${pixel-bg.name}";
          };
          "LockScreen" = {
            background = "${pixel-bg.name}";
          };
        };
      };
in
{
   environment.systemPackages = [sddm-theme sddm-theme.test];
   qt.enable = true;
   services.displayManager.sddm = {
      package = lib.mkForce pkgs.kdePackages.sddm; # use qt6 version of sddm
      enable = true;
      theme = sddm-theme.pname;
      extraPackages = sddm-theme.propagatedBuildInputs;
      settings = {
        # required for styling the virtual keyboard
        General = {
          GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
          InputMethod = "qtvirtualkeyboard";
        };
      };
   };
}
