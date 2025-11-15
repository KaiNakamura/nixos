#!/usr/bin/env bash
# Move focused window up using GNOME Shell
gdbus call --session \
  --dest org.gnome.Shell \
  --object-path /org/gnome/Shell \
  --method org.gnome.Shell.Eval "
    const window = global.get_window_actors().find(a => a.meta_window.has_focus());
    if (window) {
      const rect = window.meta_window.get_frame_rect();
      window.meta_window.move_frame(true, rect.x, Math.max(0, rect.y - 100));
    }
  " 2>/dev/null || true

