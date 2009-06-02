#! /bin/bash

COMMAND=$1
if [ -z "$COMMAND" ]; then
	echo "Usage: $(basename $0) <apt-get params, but currently only install <packagelist> works :("
	exit 1
fi

PACKAGES=$2

for PACKAGE in $PACKAGES; do
	echo "== Installing package: $PACKAGE"
	URL=$(wget -q "http://packages.ubuntu.com//intrepid/i386/$PACKAGE/download" -O - | egrep "http://(ch|de)\.archive\.ubuntu\.com" | sed -nre 's/.*href="//; s/".*//p; q')
	wget $URL

	DEB=$(basename $URL)
	ar x $DEB
	tar xvf data.tar.gz
	rm -f *.gz debian-binary
done