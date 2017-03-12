import QtQuick 2.0
import QtMultimedia 5.6

Item {
    id: root
    width: 1020
    height: 620

    property bool remain: false
    MediaPlayer {
        id: player
        source: ""
        onStopped: {
            var res
            if (root.remain) {
                res = douban.get_playlist('e')
                root.remain = false
            } else {
                res = douban.get_playlist('p')
            }
            if (!res) return
            //var download_status = douban.download_content()
            //if (download_status) {
                main.picture = douban.get_pic_name()
                player.source = douban.get_music_name()
                main.reset()
                main.title = douban.get_title()
                main.artist = douban.get_artist()
                player.play()
            //}
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



    MainWindow {
        id: main
        visible: true
        completion_degree: player.duration > 0? player.position / player.duration: 0
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
            //var download_status = douban.download_content()
            //if (download_status) {
                main.picture = douban.get_pic_name()
                player.source = douban.get_music_name()
                main.reset()
                main.title = douban.get_title()
                main.artist = douban.get_artist()
                player.play()
            //}
        }
        onThrowed: {
            var res = douban.get_playlist('b')
            if (!res) return
            //var download_status = douban.download_content()
            //if (download_status) {
                main.picture = douban.get_pic_name()
                player.source = douban.get_music_name()
                main.reset()
                main.title = douban.get_title()
                main.artist = douban.get_artist()
                player.play()
            //}
        }
        onStart: {
            player.play()
        }
        onPause: {
            player.pause()
        }
        onSeek: {
            if (player.seekable) {
                player.seek(player.duration * mouseX / bar_width);
                logger.log("" + player.duration + "")
            }
        }
        onShowLyric: {
            var lyric_str = douban.get_lyric()
            var lyrics = lyric_str.split('\r\n')
            main.content = lyrics
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
    Login {
        id: login
        width: 480
        height: 340
        visible: false
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
                main.reset()
                main.title = douban.get_title()
                main.artist = douban.get_artist()

                main.visible = true
                login.visible = false
            } else {
                login.uname = ""
                login.password = ""
                show_tip()
            }
        }
    }
    Component.onCompleted: {
        var is_login = douban.detect_login()
        if (is_login) {
            douban.get_playlist('n')
            //var download_status = douban.download_content()
            //logger.log_bool(download_status)
            //if (download_status) {
                logger.log("--------------------")
                main.picture = douban.get_pic_name()
                main.reset()
                player.source = douban.get_music_name()
                main.title = douban.get_title()
                main.artist = douban.get_artist()
                player.play()
            //}

            main.visible = true
            login.visible = false
        } else {
            main.visible = false
            login.visible = true
        }
    }
}
