import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Item {
    id: root
    width: 480
    height: 340
    signal clicked
    property alias uname: uid.text
    property alias password: passwd.text
    Rectangle {
        id: r1
        height: 30
        width: root.width
        anchors.topMargin: 20
        anchors.top: root.top
        Text {
            id: introduction
            text: "欢迎来到豆瓣FM, 请登录"
            font.pixelSize: 25
            anchors.top: parent.top
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: tip
        height: 20
        width: root.width
        anchors.topMargin: 20
        anchors.top: r1.bottom
        visible: false
        Text {
            text: "用户名或密码错误"
            font.pixelSize: 18
            anchors.top: parent.top
            anchors.centerIn: parent
            color: "red"
        }
    }

    function show_tip() {
        tip.visible = true
    }

    Rectangle {
        id: r2
        width: 358
        height: 36
        border.color: "lightgray"
        border.width: 1
        anchors.topMargin: 40
        anchors.top: tip.bottom
        x: (root.width - width) / 2.0
        TextField {
            id: uid
            anchors.fill: parent
            clip: true
            focus: true
            KeyNavigation.tab: passwd
            font.pixelSize: 14
            verticalAlignment: TextInput.AlignVCenter
            activeFocusOnPress: true
            placeholderText: "手机号 / 邮箱 / 用户名"
            style: TextFieldStyle {
                textColor: "black"
            }
            onCursorPositionChanged: {
                uid_tip.visible = false
                tip.visible = false
            }
        }
        Text {
            id: uid_tip
            anchors.right: parent.right
            width: 40
            visible: false
            text: "必填"
            font.pixelSize: 16
            color: "red"
        }
    }
    Rectangle {
        id: r3
        width: 358
        height: 36
        x: (root.width - width) / 2.0
        border.color: "lightgray"
        border.width: 1
        anchors.topMargin: 20
        anchors.top: r2.bottom
        TextField {
            id: passwd
            focus: false
            anchors.fill: parent
            echoMode: TextInput.Password
            KeyNavigation.backtab: uid
            KeyNavigation.tab: btn
            verticalAlignment: TextInput.AlignVCenter
            activeFocusOnPress: true
            font.pixelSize: 14
            placeholderText: "密码"
            style: TextFieldStyle {
                textColor: "black"
            }
            onCursorPositionChanged: {
                passwd_tip.visible = false
                tip.visible = false
            }
        }
        Text {
            id: passwd_tip
            anchors.right: parent.right
            width: 40
            visible: false
            text: "必填"
            font.pixelSize: 16
            color: "red"
        }
    }
    Rectangle {
        width: 358
        height: 36
        x: (root.width - width) / 2.0
        anchors.topMargin: 20
        anchors.top: r3.bottom
        Button {
            id: btn
            style: ButtonStyle {
                background: Rectangle {
                    width: btn.width
                    height: btn.height
                    color: "#59B36A"
                    radius: 4
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                    }
                }

                label: Item {
                    anchors.fill: parent
                    Text {
                        color: "white"
                        text: "登录豆瓣"
                        anchors.centerIn: parent
                    }
                }

            }

            anchors.fill: parent
            onClicked: {
                var status = false
                if (uid.text == "") {
                    uid_tip.visible = true
                    status = true
                }
                if (passwd.text == "") {
                    passwd_tip.visible = true
                    status = true
                }
                if (status) return

                root.clicked()
            }
        }
    }
}
