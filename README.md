# Kwin Info Dump
A Kwin script for dumping active window's information.

The default shortcuts are Meta+I (properties) and Meta+Shift+I (JSON).

You can access the last dump with `journalctl -g '^qml: kwin_info_dump' -n 1`.

On X11, the dump is also copied to the clipboard.
