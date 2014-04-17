# MTGO Trade Helper

Copyright (c) 2013 - Brett O'Donnell <cornernote@gmail.com>

Home Page: https://sites.google.com/site/cornernote/mtgo/trade-helper
Download: https://github.com/cornernote/mtgo-trade_helper/archive/master.zip
Source Code: https://github.com/cornernote/mtgo-trade_helper


## LICENSE

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.


## DESCRIPTION

MTGO Trade Helper is an in-game tool to assist players when trading in Magic The Gathering Online.

It scans the screen for the yellow card popup, reads the card name and edition, then gives a popup with the price.

This is not a bot.  It is intended to help humans trade by providing card prices.


## Usage

Double click trade_helper.exe to run the helper!

Now simply hover a card in MTGO and it will show an additional popup with the price!

Hot Keys
- CTRL+ALT+X = exit
- CTRL+ALT+R = reload data files
- CTRL+ALT+C = copy card and price data for spreadsheet
- CTRL+ALT+SHIFT+C = copy card name
- CTRL+ALT+SHIFT+O = open card text file


## FAQ

Do I need to enter my username and password into the settings?
- No, you simply login to your account as you normally would, then start MTGO Trade Helper.

How does it work?
- Once MTGO Trade Helper finds the yellow popup on the screen it saves it as an image, then uses ImageMagick to make it larger, and Tesseract to convert it to text.

Where do the prices come from?
- Price data is stored in CardsMTGO3.txt.  The prices are from MTGOLibrary.com.  You can get their latest price list by subscribing to their bot.

The card name was read incorrectly, how can I fix it?
- Press CRTL+ALT+SHIFT+C to copy the incorrectly read card name into your clipboard.  Open data/cards.txt and enter the correct name, followed by a | (pipe symbol), then paste the incorrect name.

The edition was not read, how can I fix it?
- Press CRTL+ALT+SHIFT+O to open the card text.  Find the edition text and copy it to your clipboard.  Open data/editions.txt and enter the correct name, followed by a | (pipe symbol), then paste the incorrect name.

The price was not read, how can I fix it?
- The only reason this should happen is if the card name and edition are not found in the data/prices.txt file.  Check the card name and edition carefully.

I updated my data files, can I share those with others?
- Yes, this is one of the reasons I made the project open source.  Please send any data changes through as a pull request, or create an issue: https://github.com/cornernote/mtgo-trade_helper/issues/new
