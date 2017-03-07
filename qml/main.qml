import QtQuick 2.0

Item {
    id: root
    width: 1020
    height: 620
    MainWindow {
        id: main
        //visible: false
        onLove: {

        }
        onUnlove: {

        }
        onNext: {

        }
        onThrowed: {

        }
    }
    Login {
        id: login
        width: 480
        height: 340
        //visible: true
        anchors.centerIn: parent
        onClicked: {
            var login_status = douban.login(login.uname, login.password)
            //login_status = true
            logger.log(uname)
            logger.log(password)
            logger.log_bool(login_status)
            if (login_status) {
                douban.get_playlist('n')
                douban.download_content()
                main.picture = douban.get_pic_name()

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
            var download_status = douban.download_content()
            if (download_status)
                main.picture = douban.get_pic_name()

            main.visible = true
            login.visible = false
        } else {
            main.visible = false
            login.visible = true
        }
    }

}
