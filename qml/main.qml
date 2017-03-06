import QtQuick 2.0

Item {
    id: root
    width: 1020
    height: 620
    MainWindow {
        id: main
        visible: false
    }
    Login {
        id: login
        width: 480
        height: 340
        visible: true
        anchors.centerIn: parent
        onClicked: {
            main.visible = true
            login.visible = false
        }
    }

}
