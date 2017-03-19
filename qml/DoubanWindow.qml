import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ApplicationWindow {
    id: mainWindow
    visible: true
    width: Screen.width * 0.7
    height: width * 0.7
    flags: Qt.Window | Qt.FramelessWindowHint   //去标题栏
    x: 100
    y: 200
    property int mainWindowX //用来存储主窗口x坐标
    property int mainWindowY //存储窗口y坐标
    property int xMouse //存储鼠标x坐标
    property int yMouse //存储鼠标y坐标
    style: ApplicationWindowStyle {
        background: Rectangle {
            color: "white"
        }
    }

    Rectangle {
        id: mainTitle                       //创建标题栏
        anchors.top: parent.top             //对标题栏定位
        anchors.left: parent.left
        anchors.right: parent.right
        height: 25                          //设置标题栏高度
        Rectangle {
            id: close_r
            height: mainTitle.height
            width: height * 2
            color: "#EBBA49"
            anchors.right: mainTitle.right
            Image {
                width: 12
                height: 12
                id: close
                source: "assets/close2.png"
                anchors.centerIn: parent
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        mainWindow.close()
                    }
                    onEntered: {
                        close_r.color = "#FF0000"
                    }
                    onExited: {
                        close_r.color = "#EBBA49"
                    }
                }
            }
        }
        Rectangle {
            id: minus_r
            height: mainTitle.height
            width: height * 2
            color: "#EBBA49"
            anchors.right: close_r.left
            Image {
                width: 12
                height: 10
                id: minus
                source: "assets/down2.png"
                anchors.centerIn: parent
            }
            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    mainWindow.showMinimized()
                }
                onEntered: {
                    minus_r.color = "#F08000"
                }
                onExited: {
                    minus_r.color = "#EBBA49"
                }
            }
        }

        Rectangle {
            id: remain_title
            height: mainTitle.height
            width: mainTitle.width - 4*height
            anchors.left: mainTitle.left
            color: "#EBBA49"                    //设置标题栏背景颜色
            Image {
                width: parent.height
                height: parent.height
                id: icon
                source: "assets/doubanfm.png"
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            Text {
                id: title_str
                text: qsTr("豆瓣FM")
                height: parent.height
                width: parent.width
                font.pixelSize: 14
                anchors.left: icon.right
                //horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            MouseArea { //为窗口添加鼠标事件
                id: dragRegion
                anchors.fill: parent
                property point clickPos: "0,0"
                cursorShape: Qt.ArrowCursor
                onPressed: {
                    clickPos  = Qt.point(mouse.x,mouse.y)
                    cursorShape = Qt.SizeAllCursor
                }
                onPositionChanged: {
                    //鼠标偏移量
                    cursorShape = Qt.SizeAllCursor
                    var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                    //如果mainwindow继承自QWidget,用setPos
                    mainWindow.setX(mainWindow.x+delta.x)
                    mainWindow.setY(mainWindow.y+delta.y)
                }
                onExited: {
                    cursorShape = Qt.ArrowCursor
                }
            }
        }

    }
}
