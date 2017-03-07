import sys
from PyQt5.QtCore import QUrl
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQuick import QQuickView
from DoubanFM import DoubanFM
import Logger

# Main Function
if __name__ == '__main__':
    # Create main app
    main_app = QApplication(sys.argv)
    # Create a label and set its properties
    douban = DoubanFM()
    logger = Logger.Logger()
    view = QQuickView()
    root_context = view.rootContext()
    root_context.setContextProperty("douban", douban)
    root_context.setContextProperty("logger", logger)
    mainurl = "qml/main.qml"
    view.setSource(QUrl(mainurl))
    '''
    root_object = view.rootObject()
    root_object.setProperty("sid", "Love Story")
    '''

    # Show the Label
    view.show()

    # Execute the Application and Exit
    main_app.exec_()
    sys.exit()
