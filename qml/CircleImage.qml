import QtQuick 2.0

Item {
    id: root
    width: 100
    height: width
    property alias addr: cvs.addr
    Canvas {
        id: cvs
        width: parent.width
        height: parent.height
        property string addr: ""
        onPaint: {
            var ctx = getContext("2d")
            ctx.beginPath()
            var x0 = width / 2
            var y0 = height / 2
            console.log(addr)
            var r = width / 2
            ctx.moveTo(width, y0)
            ctx.arc(x0, y0, r, 0, Math.PI*2, true)
            ctx.closePath()
            //ctx.fill()
            ctx.clip()
            ctx.drawImage(addr, 0, 0, width, height)
            ctx.stroke()
        }
        Component.onCompleted: {
            loadImage(cvs.addr)
        }
    }
}
