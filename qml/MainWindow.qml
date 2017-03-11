import QtQuick 2.0
import QtQuick.Layouts 1.1

Item {
    id: root
    width: 1020
    height: 620
    property alias title: music.text
    property alias artist: singer.text

    property alias bar_width: bar.width
    property alias mouseX: bar.mouseX
    property alias picture: intrfce.source
    property alias completion_degree: bar.completion_degree
    signal love
    signal unlove
    signal throwed
    signal next
    signal start
    signal pause
    signal seek

    RowLayout {
        id: row
        anchors.fill: parent
        anchors.margins: 8, 8, 8, 8
        spacing: 6
        Rectangle {
            //id: left
            width: 280
            height: 240
            anchors.left: parent.left
            anchors.topMargin: (root.height - height) / 2
            anchors.bottomMargin: (root.height - height) / 2
            LyricPanel {
                id: lyric_panel
                anchors.fill: parent
                width: parent.width
                height: parent.height
            }
        }
        Rectangle {
            id: middle
            width: 460
            height: 400
            ProgressBar {
                id: bar
                width: 450
                height: 10
                y: (middle.height-height) / 2
                onClicked: {
                    root.seek()
                }
            }

            ChangeableText {
                id: singer
                height: 30
                text: 'Unkown'
                font.pixelSize: 15
                y: bar.y - height - 20
            }

            ChangeableText {
                id: music
                height: 40
                text: "None"
                font.pixelSize: 25
                y: singer.y - height - 8
            }

            LoveButton {
                id: loveit
                y: bar.y + 60
                x: 0
                onLove: {
                    console.log("love clicked")
                    root.love()
                }
                onUnlove: {
                    console.log("unlove clicked")
                    root.unlove()
                }
            }

            TrashButton {
                id: thrash
                y: loveit.y
                x: 60
                onThrowed: {
                    console.log("thrash clicked")
                    root.throwed()
                }
            }

            NextButton {
                id: next
                y: loveit.y
                x: bar.width - 40
                onNext: {
                    console.log("next clicked")
                    root.next()
                }
            }

            LyricButton {
                id: lyric_btn
                y: bar.y - 28
                x: bar.width - 80
                property bool showing: false
                onShow: {
                    if (showing) return
                    console.log("show lyric")
                    var lyric_str = douban.get_lyric()
                    var lyrics = lyric_str.split('\r\n')
                    lyric_panel.content = lyrics
                    showing = true
                }
            }
        }

        Rectangle {
            //id: right
            width: 240
            height: 240
            CircleImage {
                id: intrfce
                radius: 120
                anchors.fill: parent
                source: "assets/lf.jpg"
                onClicked: {
                    console.log("circle clicked")
                }
                onStart: {
                    console.log("start")
                    root.start()
                }
                onStop: {
                    console.log("stop")
                    root.pause()
                }
            }
        }
    }
    focus: true
    Component.onCompleted: {
        Keys.onSpacePressed.connect(intrfce.clicked)
    }
    function reset() {
        intrfce.refresh()
        loveit.reset()
        lyric_btn.showing = false
        lyric_panel.content = []
    }

}
