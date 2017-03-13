import QtQuick 2.0
import 'js/tiger.js' as Tiger

Item {
    id: root
    width: 20
    height: 20
    signal download
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

            for (var i = 0; i < Tiger.Download.length; i++) {
                if (Tiger.Download[i].width != undefined)
                    ctx.lineWidth = Tiger.Download[i].width;

                if (Tiger.Download[i].path != undefined)
                    ctx.path = Tiger.Download[i].path;

                if (Tiger.Download[i].fill != undefined) {
                    ctx.fillStyle = Tiger.Download[i].fill;
                    ctx.fill();
                }

                if (Tiger.Download[i].Lyric != undefined) {
                    ctx.strokeStyle = Tiger.Download[i].stroke;
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
            root.download()
        }
    }
}
