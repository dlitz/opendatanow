#!/bin/sh
set -e

scrape_url='http://www.octranspo1.com/google/retrieve_stops?zoom=15&ne=47.0000,-74.0000&sw=44.0000,-77.0000'

# Fetch OC Transpo stops if they haven't already been fetched
# Original data from http://www.octranspo1.com/maps/
if ! [ -f repo/octranspo/raw/stops.bin ] ; then
    mkdir -p repo/octranspo/raw
    wget -q -Otmp/octranspo-stops.bin "$scrape_url"
    mv -f tmp/octranspo-stops.bin repo/octranspo/raw/stops.bin
fi

# Process OC Transpo stops into UTF-8 XML
if ! [ -f repo/octranspo/stops.xml.gz ] || [ repo/octranspo/stops.xml.gz -ot repo/octranspo/raw/stops.bin ] ; then
    mkdir -p repo/octranspo

    # Add XML preamble and convert to UTF-8
    cat > tmp/octranspo-stops.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!-- Scraped `date -R`
     from $scrape_url
     Original data at: http://www.octranspo1.com/maps/ -->
EOF

    iconv -f latin1 -t utf-8 repo/octranspo/raw/stops.bin >> tmp/octranspo-stops.xml

    # compress using gzip
    gzip -9c tmp/octranspo-stops.xml > tmp/octranspo-stops.xml.gz

    # Give the translated files the same timestamp as repo/octranspo/raw/stops.bin
    touch --date="`stat -c '%y'  repo/octranspo/raw/stops.bin`" tmp/octranspo-stops.xml tmp/octranspo-stops.xml.gz

    # Move into place
    mv -f tmp/octranspo-stops.xml repo/octranspo/stops.xml
    mv -f tmp/octranspo-stops.xml.gz repo/octranspo/stops.xml.gz
fi

# Convert XML to CSV
if ! [ -f repo/octranspo/stops.csv.gz ] || [ repo/octranspo/stops.csv.gz -ot repo/octranspo/stops.xml ] ; then
    # Convert to CSV
    support/octranspo-stops-to-csv.py repo/octranspo/stops.xml > tmp/octranspo-stops.csv

    # compress using gzip
    gzip -9c tmp/octranspo-stops.csv > tmp/octranspo-stops.csv.gz

    # Give the translated files the same timestamp as repo/octranspo/stops.xml
    touch --date="`stat -c '%y'  repo/octranspo/stops.xml`" tmp/octranspo-stops.csv tmp/octranspo-stops.csv.gz

    # Move into place
    mv -f tmp/octranspo-stops.csv repo/octranspo/stops.csv
    mv -f tmp/octranspo-stops.csv.gz repo/octranspo/stops.csv.gz
fi

# vim:set ts=4 sw=4 sts=4 expandtab tw=0:
