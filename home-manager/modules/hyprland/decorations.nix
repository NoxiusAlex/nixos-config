{
  wayland.windowManager.hyprland.settings = {
    decoration = {
      rounding = 18;
      
      blur = {
        enabled = true;
        xray = false;
        special = false;
        new_optimizations = true;
        size = 4;
        passes = 2;
        brightness = 1;
        noise = 0.01;
        contrast = 1;
        popups = true;
        popups_ignorealpha = 0.6;
        input_methods = true;
        input_methods_ignorealpha = 0.8;
      };
      
      shadow = {
        enabled = true;
        ignore_window = true;
        range = 30;
        offset = "0 2";
        render_power = 4;
        color = "rgba(00000010)";
      };
      
      # Затемнение
      dim_inactive = true;
      dim_strength = 0.025;
      dim_special = 0.07;
    };
  };
}
