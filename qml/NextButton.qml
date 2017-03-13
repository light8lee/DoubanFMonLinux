import QtQuick 2.0
import 'js/tiger.js' as Tiger

Item {
    id: root
    width: 50
    height: 50
    signal next

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

            ctx.strokeStyle = Qt.rgba(.3, .3, .3,1);
            ctx.lineWidth = 1;

            for (var i = 0; i < Tiger.Next.length; i++) {
                if (Tiger.Next[i].width != undefined)
                    ctx.lineWidth = Tiger.Next[i].width;

                if (Tiger.Next[i].path != undefined)
                    ctx.path = Tiger.Next[i].path;

                if (Tiger.Next[i].fill != undefined) {
                    ctx.fillStyle = Tiger.Next[i].fill;
                    ctx.fill();
                }

                if (Tiger.Next[i].stroke != undefined) {
                    ctx.strokeStyle = Tiger.Next[i].stroke;
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
            root.next()
        }
    }

}
