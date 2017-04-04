import QtQuick 2.5
import QtMultimedia 5.6

Item {
    id: root
    width: 880
    height: 8
    signal clicked
    property alias mouseX: bar_area.mouseX
    property real completion_degree: 0
    property alias color: progress_bar.color
    property alias foreground_color: progress.color

    Rectangle {
        id: progress_bar

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
            id: bar_area
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                root.clicked()
            }
        }
    }
}

