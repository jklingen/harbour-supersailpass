#    SuperSailPass - a SuperGenPass implementation for SailfishOS
#    Copyright (C) 2015 Jens Klingen
#
#    This program is free software; you can redistribute it and/or
#    modify it under the terms of the GNU General Public License
#    as published by the Free Software Foundation; either version 2
#    of the License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

TARGET = harbour-supersailpass

CONFIG += sailfishapp

SOURCES += src/harbour-supersailpass.cpp

OTHER_FILES += qml/harbour-supersailpass.qml \
    rpm/harbour-supersailpass.spec \
    rpm/harbour-supersailpass.yaml \
    translations/*.ts \
    harbour-supersailpass.desktop \
    qml/pages/CoverPage.qml \
    qml/js/supergenpass-lib.js \
    qml/pages/InfoPage.qml \
    qml/pages/MainPage.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-supersailpass-de.ts

RESOURCES += \
    resources/resources.qrc

