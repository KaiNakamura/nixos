#!/usr/bin/env bash
# Move focused window to the right using GNOME Shell
gdbus call --session \
  --dest org.gnome.Shell \
  --object-path /org/gnome/Shell \
  --method org.gnome.Shell.Eval "
    const window = global.get_window_actors().find(a => a.meta_window.has_focus());
    if (window) {
      const rect = window.meta_window.get_frame_rect();
      const monitor = window.meta_window.get_monitor();
      const workArea = global.display.get_monitor_geometry(monitor);
      window.meta_window.move_frame(true, Math.min(workArea.width - rect.width, rect.x + 100), rect.y);
    }
  " 2>/dev/null || true

