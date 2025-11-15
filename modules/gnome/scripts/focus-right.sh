#!/usr/bin/env bash
# Focus window to the right using GNOME Shell
gdbus call --session \
  --dest org.gnome.Shell \
  --object-path /org/gnome/Shell \
  --method org.gnome.Shell.Eval "
    const windows = global.get_window_actors()
      .map(a => a.meta_window)
      .filter(w => w.get_workspace() === global.display.get_workspace_manager().get_active_workspace());
    const focused = global.display.get_focus_window();
    if (!focused) return;
    const focusedRect = focused.get_frame_rect();
    const rightWindows = windows.filter(w => {
      const rect = w.get_frame_rect();
      return rect.x > focusedRect.x && Math.abs(rect.y - focusedRect.y) < focusedRect.height;
    });
    if (rightWindows.length > 0) {
      const closest = rightWindows.reduce((a, b) => {
        const aDist = Math.abs(a.get_frame_rect().x - focusedRect.x);
        const bDist = Math.abs(b.get_frame_rect().x - focusedRect.x);
        return aDist < bDist ? a : b;
      });
      closest.activate(global.get_current_time());
    }
  " 2>/dev/null || true

