import QtQuick 2.5
import QtMultimedia 5.6

Item {
    id: root
    width: 880
    height: 6
    signal clicked
    property double completion_degree: 0

    Rectangle {
        id: progressBar

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 2

        height: 2

        color: "lightGray"

        Rectangle {
            id: progress
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: root.completion_degree * root.width
            color: Qt.rgba(0.1, 0.9, 0.1, 0.96)
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.clicked()
            }
        }
    }
}

