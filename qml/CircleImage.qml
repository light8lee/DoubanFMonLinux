import QtQuick 2.0
Item {
    id: root
    property int radius: 100
    property alias source: cvs.source
    signal clicked
    signal start
    signal stop
    width: radius * 2
    height: radius * 2
    Canvas {
        id: cvs
        anchors.fill: parent
        width: parent.width
        height: parent.height
        property string source: ""
        property bool stop: false
        onPaint: {
            var ctx = getContext("2d")
            var x0 = radius
            var y0 = radius
            if (stop) {
                ctx.fillStyle = Qt.rgba(0.9, 0.9, 0.9, 0.95)
                ctx.beginPath()
                ctx.moveTo(width, y0)
                ctx.arc(x0, y0, radius, 0, Math.PI*2, true)
                ctx.closePath()
                ctx.fill()

                ctx.fillStyle = "#7C7C7C"
                ctx.beginPath()
                var diff = radius / 4
                var point_x1 = radius - diff / 2
                var point_x2 = radius + diff
                var point_y1 = radius - diff * Math.sqrt(3) / 2
                var point_y2 = radius + diff * Math.sqrt(3) / 2
                ctx.moveTo(point_x1, point_y1)
                ctx.lineTo(point_x2, radius)
                ctx.lineTo(point_x1, point_y2)
                ctx.lineTo(point_x1, point_y1)
                ctx.closePath()
                ctx.fill()
            } else {
                ctx.lineWidth = 4
                ctx.strokeStyle = "#FFFFFF"
                ctx.beginPath()
                //console.log(source)
                ctx.moveTo(width, y0)
                ctx.arc(x0, y0, radius, 0, Math.PI*2, true)
                ctx.closePath()
                //ctx.fill()
                ctx.clip()
                ctx.drawImage(source, 0, 0, width, height)
                ctx.stroke()
            }

        }
        onImageLoaded: {
            cvs.requestPaint()
        }

        Component.onCompleted: {
            loadImage(cvs.source)
            root.clicked.connect(drawit)
        }
    }
    MouseArea {
        anchors.fill: cvs
        hoverEnabled: true
        onClicked: {
            cvs.stop = !cvs.stop
            root.clicked()
        }
    }
    function drawit() {
            if (cvs.stop) {
                root.stop()
            } else {
                root.start()
            }

            cvs.requestPaint()
            //root.clicked()
    }
    function refresh() {
        cvs.loadImage(root.source)
    }
}
