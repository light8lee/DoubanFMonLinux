# -*- coding: utf-8 -*-

from PyQt5.QtCore import QObject
from PyQt5.QtCore import pyqtSlot
import sys

def log(info):
    print(info, file=sys.stderr)

def err(info):
    print(info, file=sys.stderr, flush=True)

class Logger(QObject):
    @pyqtSlot(str)
    def log(self, info):
        print(info, file=sys.stderr)

    @pyqtSlot(bool)
    def log_bool(self, info):
        print(info, file=sys.stderr)

    @pyqtSlot(bool)
    def err(self, info):
        print(info, file=sys.stderr)

