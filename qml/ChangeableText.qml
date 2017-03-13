import QtQuick 2.0

Item {
    id: root
    width: 50
    height: 60
    property alias text: txt.text
    property alias font: txt.font
    signal clicked
    Text {
        id: txt
        text: qsTr("")
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: {
            //console.log("Entered!")
            //txt.font.bold = true
            txt.font.underline = true
        }
        onExited: {
            //console.log("Exited!")
            //txt.font.bold = false
            txt.font.underline = false
        }
        onClicked: {
            root.clicked()
        }
    }
}
