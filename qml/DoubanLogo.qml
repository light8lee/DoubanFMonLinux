import QtQuick 2.0
import 'js/tiger.js' as Tiger

Item {
    id: root
    width: 200
    height: 100
    Canvas {
        id: cvs
        width: 200
        height: 100
        antialiasing: true

        onPaint: {
            var ctx = cvs.getContext('2d');
            //var originX = cvs.width/2 + 30
            //var originY = cvs.height/2 + 60
            ctx.save();
            ctx.clearRect(0, 0, cvs.width, cvs.height);
            ctx.globalAlpha = cvs.alpha;
            ctx.globalCompositeOperation = "source-over";

            ctx.translate(0, 0)
            ctx.scale(0.3, 0.3);
            //ctx.rotate(cvs.rotate);
            //ctx.translate(-originX, -originY)

            ctx.lineWidth = 1;

            for (var i = 0; i < Tiger.Logo.length; i++) {
                if (Tiger.Logo[i].width != undefined)
                    ctx.lineWidth = Tiger.Logo[i].width;

                if (Tiger.Logo[i].path != undefined)
                    ctx.path = Tiger.Logo[i].path;

                if (Tiger.Logo[i].rect != undefined) {
                    var des = Tiger.Logo[i].rect.split(",")
                    ctx.rect(des[0], des[1], des[2], des[3])
                }

                if (Tiger.Logo[i].fill != undefined) {
                    ctx.fillStyle = Tiger.Logo[i].fill;
                    ctx.fill();
                }

                if (Tiger.Logo[i].stroke != undefined) {
                    ctx.strokeStyle = Tiger.Logo[i].stroke;
                    ctx.stroke();
                }

            }
            ctx.restore();
        }
    }
}
