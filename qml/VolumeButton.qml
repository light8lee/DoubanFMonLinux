import QtQuick 2.0
import 'js/tiger.js' as Tiger

Item {
    id: root
    width: 18
    height: 18
    signal show
    Canvas {
        id: cvs
        width: root.width
        height: root.height
        antialiasing: true

        onPaint: {
            var ctx = cvs.getContext('2d');
            var originX = cvs.width/2 + 30
            var originY = cvs.height/2 + 60

            ctx.save();
            ctx.clearRect(0, 0, cvs.width, cvs.height);
            ctx.globalAlpha = cvs.alpha;
            ctx.globalCompositeOperation = "source-over";

            ctx.translate(originX, originY)
            ctx.scale(cvs.scale, cvs.scale);
            ctx.rotate(cvs.rotate);
            ctx.translate(-originX, -originY)

            ctx.lineWidth = 1;

            for (var i = 0; i < Tiger.Volume.length; i++) {
                if (Tiger.Volume[i].width != undefined)
                    ctx.lineWidth = Tiger.Volume[i].width;

                if (Tiger.Volume[i].path != undefined)
                    ctx.path = Tiger.Volume[i].path;

                if (Tiger.Volume[i].fill != undefined) {
                    ctx.fillStyle = Tiger.Volume[i].fill;
                    ctx.fill();
                }

                if (Tiger.Volume[i].stroke != undefined) {
                    ctx.strokeStyle = Tiger.Volume[i].stroke;
                    ctx.stroke();
                }

            }
            ctx.restore();
        }
    }
    MouseArea {
        anchors.fill: cvs
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            root.show()
        }
    }
}
