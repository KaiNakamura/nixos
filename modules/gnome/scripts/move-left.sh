#!/usr/bin/env bash
# Move focused window to the left using GNOME Shell
gdbus call --session \
  --dest org.gnome.Shell \
  --object-path /org/gnome/Shell \
  --method org.gnome.Shell.Eval "
    const window = global.get_window_actors().find(a => a.meta_window.has_focus());
    if (window) {
      const rect = window.meta_window.get_frame_rect();
      window.meta_window.move_frame(true, Math.max(0, rect.x - 100), rect.y);
    }
  " 2>/dev/null || true

