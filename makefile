prefix=/usr/local

all:

clean:

install:
	mkdir -p "$(DESTDIR)$(prefix)/share/ui-grid/"
	cp -r qml "$(DESTDIR)$(prefix)/share/ui-grid/"
	mkdir -p "$(DESTDIR)$(prefix)/bin/"
	sed "s|^\(installdir =\).*|\1 '$(prefix)/share/ui-grid/'|" ui-grid > "$(DESTDIR)$(prefix)/bin/ui-grid"
	chmod +x "$(DESTDIR)$(prefix)/bin/ui-grid"

uninstall:
	rm "$(DESTDIR)$(prefix)/bin/ui-grid"
	rm -r "$(DESTDIR)$(prefix)/share/ui-grid/"
