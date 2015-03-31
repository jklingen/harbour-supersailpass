/*
    SuperSailPass - a SuperGenPass implementation for SailfishOS
    Copyright (C) 2015 Jens Klingen

    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
    of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

import "../components"

Page {
    id: page

    SilicaFlickable {
        id:sf
        anchors.fill: parent
        contentHeight: childRect.height

        Rectangle {
            id:childRect
            width:parent.width
            height:childrenRect.height
            color:'transparent'

            PageHeader {
                id: title
                title: 'SuperSailPass'
            }

            Image {
                id: logo
                y: Theme.paddingLarge
                anchors.top: title.bottom
                anchors.left: title.left
                anchors.leftMargin: Theme.paddingLarge
                source: 'qrc:/img/harbour-supersailpass.png'
                width: 86
                height: 86
            }
            Label {
                anchors.bottom: logo.bottom
                anchors.right: title.right
                anchors.rightMargin: Theme.paddingLarge
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                horizontalAlignment: Text.AlignRight
                text: '<strong>' + qsTr('Version %1').arg('0.3') + '</strong><br>' +  qsTr("Copyright © %2<br>Jens Klingen").arg('2015')
                color:Theme.highlightColor
                font.pixelSize: Theme.fontSizeSmall
            }

            Column {
                anchors.top:logo.bottom
                width:parent.width
                spacing:Theme.paddingSmall

                Spacer {}
                Label {
                    width:parent.width
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    font.bold: true
                    color: Theme.highlightColor
                    text: "A SuperGenPass implementation for SailfishOS."
                }
                Label {
                    width:parent.width
                    anchors.margins: Theme.paddingLarge
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    color: Theme.highlightColor
                    text: "SuperGenPass transforms a master password into domain-specific and unique passwords."
                }

                Spacer {}
                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: Theme.paddingLarge
                    font.bold: true
                    color: Theme.highlightColor
                    text: "Questions, problems, suggestions?"
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Button {
                        text: 'Github'
                        onClicked: Qt.openUrlExternally("https://github.com/jklingen/harbour-supersailpass/issues");
                    }
                    Button {
                        text: 'Twitter'
                        onClicked: Qt.openUrlExternally("https://twitter.com/jklingen");
                    }
                }


                Spacer {}
                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: Theme.paddingLarge
                    font.bold: true
                    color: Theme.highlightColor
                    text: "Do you like this app?"
                }
                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: 'Buy me a beer :)'
                    onClicked: {
                        Qt.openUrlExternally("https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=paypal%40jklingen%2ecom&lc=US&item_name=Jens%20Klingen&no_note=0&cn=Message%20to%20Jens%3a&no_shipping=2&rm=1&currency_code=EUR&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted&amount=3&item_name=A%20beer%20for%20SuperSailPass%20-%20cheers!");
                        text = 'Cheers!'
                    }
                }


                Spacer {}
                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: Theme.paddingLarge
                    font.bold: true
                    color: Theme.highlightColor
                    text: "Free & open source!"
                }

                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr('GPL version 2')
                    onClicked: Qt.openUrlExternally("http://www.gnu.org/licenses/gpl-2.0.html");
                }
                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: Theme.paddingLarge
                    width:parent.width
                    font.pixelSize: Theme.fontSizeSmall
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: Theme.secondaryHighlightColor
                    text: '<style>a:link { color: ' + Theme.primaryColor + '; }</style>' +
                        qsTr('%1 has been invented and is maintained by %2. Thanks!')
                            .arg('<a href="http://www.supergenpass.com/">SuperGenPass</a>')
                            .arg('<a href="https://github.com/chriszarate">Chris Zarate</a>')
                }
            }
        }
    }
}
