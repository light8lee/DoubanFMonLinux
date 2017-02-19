import QtQuick 2.0

Item {
    id: root
    width: 50
    height: 60
    property alias text: txt.text
    signal clicked
    Text {
        id: txt
        text: qsTr("")
    }
    MouseArea {
       anchors.fill: parent
       hoverEnabled: true
       onEntered: {
           console.log("Entered!")
           txt.font.bold = true
       }
       onExited: {
           console.log("Exited!")
           txt.font.bold = false
       }
       onClicked: {
           root.clicked()
       }
    }
}
