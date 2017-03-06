import QtQuick 2.0
import QtQuick.Layouts 1.1

Rectangle {
    id: root
    width: 1020
    height: 620
    property alias sid: singer.text

    RowLayout {
        id: row
        anchors.fill: parent
        anchors.margins: 8, 8, 8, 8
        spacing: 6
        Rectangle {
            id: left
            width: 280
            height: 240
            anchors.left: parent.left
            anchors.topMargin: (root.height - height) / 2
            anchors.bottomMargin: anchors.topMargin
            color: "#3F3F3F"
        }
        Rectangle {
            id: middle
            width: 460
            height: 400

            ProgressBar {
                id: bar
                width: 450
                height: 120
                y: (middle.height-height) / 2
            }

            ChangeableText {
                id: singer
                height: 30
                text: 'Unkown'
                font.pixelSize: 15
                y: bar.y - height - 10
            }

            ChangeableText {
                id: music
                height: 40
                text: "None"
                font.pixelSize: 25
                y: singer.y - height - 10
            }

            LoveButton {
                id: loveit
                y: bar.y + 60
                x: 0
                onLove: {
                    console.log("love clicked")
                }
                onUnlove: {
                    console.log("unlove clicked")
                }
            }

            TrashButton {
                id: thrash
                y: loveit.y
                x: 60
                onThrowed: {
                    console.log("thrash clicked")
                }
            }

            NextButton {
                id: next
                y: loveit.y
                x: bar.width - 40
                onNext: {
                    console.log("next clicked")
                }
            }

            //color: "#007F39"
        }
        Rectangle {
            id: right
            width: 240
            height: 240
            CircleImage {
                id: intrfce
                radius: 120
                anchors.fill: parent
                source: "assets/lf.jpg"
                onClicked: {
                    console.log("circle clicked")
                }
                onStart: {
                    console.log("start")
                }
                onStop: {
                    console.log("stop")
                }
            }
            //color: "#7F0900"
        }
    }
    focus: true
    Component.onCompleted: {
        Keys.onSpacePressed.connect(intrfce.clicked)
    }

    /*
    Keys.onSpacePressed: {
        intrfce.drawit()
        //console.log("space pressed")
    }
    */
}
