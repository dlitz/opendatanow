#!/bin/sh
set -e

# Fetch OC Transpo stops if they haven't already been fetched
if ! [ -f repo/octranspo/raw/allstops.bin ] ; then
    mkdir -p repo/octranspo/raw
    wget -q -Otmp/octranspo-allstops.bin 'http://www.octranspo1.com/google/retrieve_stops?zoom=15&ne=47.0000,-74.0000&sw=44.0000,-77.0000'
    mv -f tmp/octranspo-allstops.bin repo/octranspo/raw/allstops.bin
fi

# Process OC Transpo stops into UTF-8 XML
if ! [ -f repo/octranspo/allstops.xml.gz ] || [ repo/octranspo/allstops.xml.gz -ot repo/octranspo/raw/allstops.bin ] ; then
    mkdir -p repo/octranspo

    # Add XML preamble and convert to UTF-8
    echo '<?xml version="1.0" encoding="UTF-8"?>' > tmp/octranspo-allstops.xml
    iconv -f latin1 -t utf-8 repo/octranspo/raw/allstops.bin >> tmp/octranspo-allstops.xml

    # compress using gzip
    gzip -9c tmp/octranspo-allstops.xml > tmp/octranspo-allstops.xml.gz

    # Give the translated files the same timestamp as repo/octranspo/raw/allstops.bin
    touch --date="`stat -c '%y'  repo/octranspo/raw/allstops.bin`" tmp/octranspo-allstops.xml tmp/octranspo-allstops.xml.gz

    # Move into place
    mv -f tmp/octranspo-allstops.xml repo/octranspo/allstops.xml
    mv -f tmp/octranspo-allstops.xml.gz repo/octranspo/allstops.xml.gz
fi

# vim:set ts=4 sw=4 sts=4 expandtab tw=0:
