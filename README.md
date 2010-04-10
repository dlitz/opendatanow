OpenDataNow
===========

The OpenDataNow project is to create a central repository of scraped data
in convenient formats that everyone can use *right now*, without needing to
write their own screen scrapers.  This repository is managed by a collection
of screen scrapers maintained by the Ottawa open data community through
GitHub.

Why?
----

At one of the Open Data Ottawa events in April, it became apparent that people
working on different projects had all written their own screen scrapers, and
many people had neat ideas but were lacking the data necessary to make them
reality.

Our hope is that OpenDataNow will help the community **spend less time writing
screen scrapers and more time doing awesome stuff**.

Where can I find...
-------------------

- The data: <http://repo.opendatanow.ca/>
- The GitHub repository: <http://github.com/dlitz/opendatanow>
- Open Data Ottawa: <http://www.opendataottawa.ca/>

How does it work?
-----------------

OpenDataNow is really just a bunch of scripts that run on a server running
Debian GNU/Linux (sid).  Scripts can be written in Ruby, Python, Java, or
whatever, as long as it can be made to run in this environment.

Whenever changes are pushed to the GitHub repository, the server automatically
runs "script/stop", kills any running processes, pulls the changes, updates
the crontab, and restarts the server by running "script/start".  (See
script/root/cycle-daemon for details.)

Some tasks (such as installing new Debian packages) must be done manually by
a system administrator, but the idea is to let others maintain the repository
with as little administrator intervention as possible.

How can I help?
---------------

The best way to help is to fork the GitHub repository at
<http://github.com/dlitz/opendatanow>, push your changes, then send us a pull
request.

- **Contribute screen scrapers.** More screen scrapers means more data
  available for everyone in the community.
- **Contribute data transformations.** Data in XML when you prefer JSON?
  Write a translator.
- **Write automated tests.** Right now, we have no way of knowing when a
  scraper stops working.  Automated testing would helps us a lot.
- **Write documentation.** The documentation for OpenDataNow is pretty sketchy
  right now.
- **Make web pages.** The OpenDataNow website is basically non-existant at
  this point.  It could use improvement.
- **Get others involved.** We need all the help we can get.


Who's behind this?
------------------

- [Dwayne C. Litzenberger](http://www.dlitz.net/)
- *Your name here*

Is this legal?
--------------

OpenDataNow arose out of discussions at an event organized by [Open Data
Ottawa](http://www.opendataottawa.ca/), a grassroots organization that will be
launching Ottawa's first open data hackfest on April 24, 2010.  Coinciding
with the hackfest, the City of Ottawa will begin releasing their data to the
public in formats suitable for re-use.  The idea is that, eventually, most
city data will be made public in a manner similar to <http://data.gov/> in the
U.S.  In the meantime, the community has received permission to scrape City of
Ottawa data ourselves.  (At least, that's what was announced at the last Open
Data Ottawa event.)


Copyright (for the scrapers)
----------------------------

Copyright (c) 2010  Dwayne C. Litzenberger

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
