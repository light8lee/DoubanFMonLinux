import QtQuick 2.0
import QtMultimedia 5.6
import QtQml 2.2

DoubanWindow {
    id: root
    width: 1020
    height: 620
    property bool remain: false
    property int passed_time: 0
    property var times: []
    MediaPlayer {
        id: player
        source: ""
        onPlaying: {
            timer.start()
        }

        onStopped: {
            var res
            if (root.remain) {
                res = douban.get_playlist('e')
                root.remain = false
            } else {
                res = douban.get_playlist('p')
            }
            if (!res) return
            main.picture = douban.get_pic_name()
            player.source = douban.get_music_name()
            reset()
            main.title = douban.get_title()
            main.artist = douban.get_artist()
            player.play()
        }
    }

    Connections {
        target: player
        onMediaObjectChanged: {
            if (player.mediaObject) {
                player.mediaObject.notifyInterval = 50;
            }
        }

    }

    Timer {
        id: timer
        interval: 500
        running: false
        repeat: true
        onTriggered: {
            if (main.showing)
                main.currentIndex = douban.get_index(main.completion_degree * player.duration)
        }
    }


    MainWindow {
        id: main
        visible: true
        completion_degree: player.duration > 0? player.position / player.duration: 0
        property bool showing: false
        picture: ""
        onLove: {
            var res = douban.get_playlist('r')
            if (!res) return
            root.remain = true
        }
        onUnlove: {
            var res = douban.get_playlist('u')
            if (!res) return
        }
        onNext: {
            var res = douban.get_playlist('s')
            if (!res) return
            main.picture = douban.get_pic_name()
            player.source = douban.get_music_name()
            reset()
            main.title = douban.get_title()
            main.artist = douban.get_artist()
            player.play()
        }
        onThrowed: {
            var res = douban.get_playlist('b')
            if (!res) return
            main.picture = douban.get_pic_name()
            player.source = douban.get_music_name()
            reset()
            main.title = douban.get_title()
            main.artist = douban.get_artist()
            player.play()
        }
        onStart: {
            player.play()
            if (main.showing)
                timer.start()
        }
        onPause: {
            player.pause()
            if (main.showing)
                timer.stop()
        }
        onSeek: {
            if (player.seekable) {
                player.seek(player.duration * mouseX / bar_width)
                if (showing) {
                    main.currentIndex = douban.get_index(main.completion_degree * player.duration)
                }
                logger.log("" + player.duration + "")
            }
        }
        onShowLyric: {
            var lyric_str = douban.get_lyric()
            var lyrics = lyric_str.split('\r\n')
            main.showing = true
            var time_str =
            main.content = lyrics
            logger.log(""+player.position)
            timer.start()
        }
        onDownload: {
            var download_status = douban.download_content()
            if (download_status) {
                logger.log("download success")
            } else {
                logger.err("download failed")
            }
        }
    }
    Rectangle {
        id: login_panel
        visible: false
        anchors.bottom: root.bottom
        anchors.left: root.left
        anchors.right: root.right
        width: root.width
        height: root.height - root.titlebar.height
        z: 2
        anchors.top: root.titlebar.bottom
        Login {
            id: login
            width: 480
            height: 340
            //visible: false
            anchors.centerIn: parent
            onClicked: {
                var login_status = douban.login(login.uname, login.password)
                logger.log(uname)
                logger.log(password)
                logger.log_bool(login_status)
                if (login_status) {
                    douban.get_playlist('n')
                    douban.download_content()
                    main.picture = douban.get_pic_name()
                    player.source = douban.get_music_name()
                    reset()
                    main.title = douban.get_title()
                    main.artist = douban.get_artist()

                    main.visible = true
                    login_panel.visible = false
                } else {
                    login.uname = ""
                    login.password = ""
                    show_tip()
                }
            }
        }
    }
    Component.onCompleted: {
        var is_login = douban.detect_login()
        if (is_login) {
            douban.get_playlist('n')
            logger.log("--------------------")
            main.picture = douban.get_pic_name()
            player.source = douban.get_music_name()
            reset()
            main.title = douban.get_title()
            main.artist = douban.get_artist()
            player.play()

            main.visible = true
            login_panel.visible = false
        } else {
            main.visible = false
            login_panel.visible = true
        }
    }
    function reset() {
        main.reset()
        timer.stop()
        main.currentIndex = -1
        main.showing = false
    }
}
