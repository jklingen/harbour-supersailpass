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

import "../js/supergenpass-lib.js" as SGP

Page {
    id: mainPage
    property string generatedPassword

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("Advanced mode")
                onClicked: {
                    if(advancedOptions.height > 0) {
                        advancedOptions.height = 0
                        text = qsTr("Advanced mode")
                    } else {
                        advancedOptions.height = advancedOptions.implicitHeight
                        text = qsTr("Simple mode")
                    }
                }
            }
        }

        PushUpMenu {
            MenuItem {
                text: qsTr("Info")
                onClicked: pageStack.push(Qt.resolvedUrl("InfoPage.qml"))
            }
        }

        contentHeight: column.height

        Column {
            id: column
            width: mainPage.width
            spacing: Theme.paddingSmall

            PageHeader {
                title: qsTr("SuperSailPass")
            }
            TextField {
                id: masterPasswordField
                width:parent.width
                placeholderText: qsTr("Master password")
                color: errorHighlight ? "red" : Theme.primaryColor
                inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
                echoMode: TextInput.Password
            }

            TextField {
                id: domainField
                width:parent.width
                placeholderText: qsTr("Domain / URL")
                color: errorHighlight ? "red" : Theme.primaryColor
                inputMethodHints: Qt.ImhUrlCharactersOnly | Qt.ImhNoAutoUppercase
            }

            Column {
                id: advancedOptions
                width:parent.width
                height:0
                clip: true

                TextSwitch {
                    id: subdomainRemovalSwitch
                    text: qsTr("Ignore subdomain")
                    checked: true
                }

                TextField {
                    id: secretPasswordField
                    text: ''
                    width:parent.width
                    placeholderText: qsTr("Secret password")
                    color: errorHighlight ? "red" : Theme.primaryColor
                    inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
                    echoMode: TextInput.Password
                }

                Slider {
                    id: lengthSlider
                    label: qsTr ("Password length")
                    width: parent.width
                    minimumValue: 4
                    maximumValue: 24
                    value: 10
                    stepSize: 1
                    valueText: parseInt(value)
                }

                ComboBox {
                    id: hashMethodCombo
                    label: qsTr ("Hash method")
                    currentIndex: 0
                    menu: ContextMenu {
                        MenuItem { text:'MD5' }
                        MenuItem { text:'SHA' }
                    }

                }

                Behavior on height {
                    PropertyAnimation {
                        duration:250
                        easing.type:Easing.OutCirc
                        onRunningChanged: {
                            // end of slide-open animation
                            if(!running && advancedOptions.height > 0) {
                                // remove fixed height, ComboBoxes require auto sizing
                                advancedOptions.height = undefined
                            }
                        }
                    }
                }
            }

            Button {
                id: generateButton
                text: qsTr("Generate")
                anchors.horizontalCenter: parent.horizontalCenter
                enabled: masterPasswordField.text.length > 0 && domainField.text.length > 0
                onClicked: {
                    var opts = {
                        secret: secretPasswordField.text,
                        length: parseInt(lengthSlider.value),
                        method: (hashMethodCombo.value === 'SHA') ? 'sha512' : 'md5',
                        removeSubdomains: subdomainRemovalSwitch.checked
                    };
                    SGP.window.supergenpass(masterPasswordField.text, domainField.text, opts, mainPage.onPasswordGenerated)
                }
            }


            Label {
                id:successLabel
                width:parent.width
                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Password copied to clipboard.") + "\n"
                      + qsTr("Clipboard will be cleared in %n second(s)","",resetTimer.remainingTicks)
                wrapMode: Text.WordWrap
                color: Theme.highlightColor
                clip:true
                height:0

                Behavior on height {
                    PropertyAnimation {
                        duration:250
                        easing.type:Easing.OutCirc
                    }
                }

            }

            Label {
                id:clearedLabel
                width:parent.width
                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Clipboard cleared.")
                wrapMode: Text.WordWrap
                color: Theme.highlightColor
                clip:true
                height:0

                Behavior on height {
                    PropertyAnimation {
                        duration:250
                        easing.type:Easing.OutCirc
                    }
                }
            }
        }
    }

    function onPasswordGenerated(pw) {
        generatedPassword = pw
        Clipboard.text = pw
        successLabel.height = successLabel.implicitHeight
        clearedLabel.height = 0
        resetTimer.start()
    }

    Timer {
        id: resetTimer
        property int remainingTicks: 15
        repeat: true
        running:false
        interval: 1000
        onTriggered: {
            // a decrementing timer is precise enough for our purpose,
            // and allows to display remaining time without additional timer
            remainingTicks--
            if(remainingTicks == 0) {
                if(Clipboard.text === generatedPassword) {
                    // only clear clipboard if it still contains the password
                    Clipboard.text = ''
                }
                generatedPassword = ''
                clearedLabel.height = clearedLabel.implicitHeight
                successLabel.height = 0
                stop()
                remainingTicks = 15
            }
        }
    }

}


