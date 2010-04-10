#!/usr/bin/env python

import xml.sax
import xml.sax.handler
import sys
import csv

class Handler(xml.sax.handler.ContentHandler):
    def __init__(self, csv_writer, cols):
        self.csv_writer = csv_writer
        self.cols = cols

    def startElement(self, name, attrs):
        if name == u'marker':
            self.csv_writer.writerow(map(lambda c: attrs[c].encode("UTF-8"), self.cols))

cols = [u"id", u"stopid", u"lat", u"lng", u"name"]
header = [u"stopNum", u"stopCode", u"latitude", u"longitude", u"name"]
input_filename = sys.argv[1]
input_file = open(input_filename, "rb")
output_file = sys.stdout
csv_writer = csv.writer(output_file)
csv_writer.writerow(map(lambda c: c.encode("UTF-8"), header))

xml.sax.parse(input_file, Handler(csv_writer, cols))

output_file.close()
input_file.close()
