import QtQuick 2.0
import 'js/tiger.js' as Tiger

Item {
    id: root
    width: 50
    height: 50
    //property alias loved: cvs.loved
    signal love
    signal unlove
    Canvas {
        id: cvs
        width: root.width
        height: root.height
        property bool loved: false
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

            for (var i = 0; i < Tiger.Love.length; i++) {
                if (Tiger.Love[i].width != undefined)
                    ctx.lineWidth = Tiger.Love[i].width;

                if (Tiger.Love[i].path != undefined)
                    ctx.path = Tiger.Love[i].path;

                if (loved) {
                    ctx.fillStyle = "#FF2C56";
                    ctx.fill();
                } else {
                    ctx.fillStyle = "#080808"
                    ctx.fill();
                }

            }
            ctx.restore();
        }
    }
    MouseArea {
        anchors.fill: cvs
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            cvs.loved = !cvs.loved
            cvs.requestPaint()
            if (cvs.loved)
                root.love()
            else
                root.unlove()
        }
    }
    function reset() {
        cvs.loved = false
        cvs.requestPaint()
    }
}
