import QtQuick 2.0


Rectangle {
    id: root
    width: 240
    height: 300
    color: "white"
    property var content: []
    property alias currentIndex: lv.currentIndex
    ListView {
        id: lv
        anchors.fill: parent
        anchors.margins: 20
        clip: true
        model: root.content.length

        delegate: numberDelegate
        spacing: 5

        //highlight: highlightComponent
        focus: true
        highlightFollowsCurrentItem: true
        highlightRangeMode: ListView.ApplyRange
        preferredHighlightBegin: 40
        preferredHighlightEnd: 80
    }

    Component {
        id: numberDelegate
        Item {
            width: 210
            height: 48
            Text {
                width: 210
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 14
                text: "<p>" + root.content[index] + "</p>"
                //color: "black"
                color: {
                    if (lv.currentIndex == index) {
                        return Qt.rgba(0, 0.9, 0, 0.7)
                    } else {
                        return "black"
                    }
                }

                anchors.leftMargin: 8
                anchors.rightMargin: 8
                wrapMode: Text.WordWrap
                height: paintedHeight
            }
        }
    }
}
