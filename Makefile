.PHONY: *

VERSION = $(shell grep '"Version":' ./package/metadata.json | grep -o '[0-9\.]*')

install:
	kpackagetool6 --type=KWin/Script -i ./package || kpackagetool6 --type=KWin/Script -u ./package

uninstall:
	kpackagetool6 --type=KWin/Script -r kwin_info_dump

package:
	tar -czf ./kwin_info_dump_${subst .,_,${VERSION}}.tar.gz ./package

logs:
	journalctl -t kwin_x11 -g '^qml:|^file://.*kwin_info_dump' -f
