#!/usr/bin/env bash
# Focus window below using GNOME Shell
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
    const downWindows = windows.filter(w => {
      const rect = w.get_frame_rect();
      return rect.y > focusedRect.y && Math.abs(rect.x - focusedRect.x) < focusedRect.width;
    });
    if (downWindows.length > 0) {
      const closest = downWindows.reduce((a, b) => {
        const aDist = Math.abs(a.get_frame_rect().y - focusedRect.y);
        const bDist = Math.abs(b.get_frame_rect().y - focusedRect.y);
        return aDist < bDist ? a : b;
      });
      closest.activate(global.get_current_time());
    }
  " 2>/dev/null || true

