import QtQuick 2.0

Item {
    id: root
    width: 300
    height: 200
    property alias loved: cvs.loved
    signal love
    signal unlove
    Canvas {
        id: cvs
        anchors.fill: parent
        width: parent.width
        height: parent.height
        property bool loved: false
        onPaint: {
            var ctx = getContext("2d")
            if (loved) {
                ctx.fillStyle = Qt.rgba(0.9, 0.1, 0.1, 0.9)
                ctx.strokeStyle = Qt.rgba(0.9, 0.1, 0.1, 0.9)
            } else {
                ctx.fillStyle = Qt.rgba(0.0, 0.0, 0.0, 1)
                ctx.strokeStyle = Qt.rgba(0.0, 0.0, 0.0, 1)
            }
            ctx.beginPath();
            ctx.moveTo(75,40);
            ctx.bezierCurveTo(75,37,70,25,50,25);
            ctx.bezierCurveTo(20,25,20,62.5,20,62.5);
            ctx.bezierCurveTo(20,80,40,102,75,120);
            ctx.bezierCurveTo(110,102,130,80,130,62.5);
            ctx.bezierCurveTo(130,62.5,130,25,100,25);
            ctx.bezierCurveTo(85,25,75,37,75,40);
            ctx.closePath();
            ctx.fill();
            ctx.stroke()
        }
    }
    MouseArea {
        anchors.fill: cvs
        onClicked: {
            cvs.loved = !cvs.loved
            cvs.requestPaint()
            if (cvs.loved)
                root.love()
            else
                root.unlove()
        }
    }

}
