#!/usr/bin/env python2.6

import xml.sax
import xml.sax.handler
import sys
import json

class Handler(xml.sax.handler.ContentHandler):
    def __init__(self, result, cols):
        self.cols = cols
        self.result = result

    def startElement(self, name, attrs):
        if name == u'marker':
            self.result.append(dict(attrs))

cols = [u"id", u"stopid", u"lat", u"lng", u"name"]
header = [u"stopNum", u"stopCode", u"latitude", u"longitude", u"name"]
input_filename = sys.argv[1]
input_file = open(input_filename, "rb")
output_file = sys.stdout
result = {u"stops": []}
xml.sax.parse(input_file, Handler(result[u'stops'], cols))
input_file.close()

output_file.write(json.dumps(result, encoding="UTF-8"))
