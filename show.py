import sys
from PyQt5.QtCore import QUrl
from PyQt5.QtWidgets import QApplication
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQuick import QQuickView
from PyQt5.QtQml import QQmlApplicationEngine
from DoubanFM import DoubanFM
import Logger

# Main Function
if __name__ == '__main__':
    # Create main app
    main_app = QGuiApplication(sys.argv)
    # Create a label and set its properties
    douban = DoubanFM()
    logger = Logger.Logger()

    engine = QQmlApplicationEngine(parent=main_app)
    root_context = engine.rootContext()
    root_context.setContextProperty("douban", douban)
    root_context.setContextProperty("logger", logger)
    mainurl = "qml/main.qml"
    engine.load(QUrl(mainurl))

    # Execute the Application and Exit
    rc = main_app.exec_()
    sys.exit(rc)
