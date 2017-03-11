# -*- coding: utf-8 -*-
from bs4 import BeautifulSoup
import urllib
import chardet
import requests
import sys
import getpass
import http.cookiejar as cookielib
import Logger
import re

from PyQt5.QtCore import QUrl
from PyQt5.QtCore import QObject
from PyQt5.QtCore import pyqtSlot

from PyQt5.QtWidgets import QApplication
from PyQt5.QtQuick import QQuickView

class DoubanFM(QObject):
    @pyqtSlot(result=bool)
    def detect_login(self):
        rqst = requests.Session()
        rqst.cookies = cookielib.LWPCookieJar('cookies')
        self.rqst = rqst
        try:
            rqst.cookies.load(ignore_discard=True)
        except:
            Logger.err("Not Login!")
            return False
        return True

    @pyqtSlot(str, str, result=bool)
    def login(self, name, passwd):
        headers = {
                    'Accept': 'application/json, text/javascript, */*; q=0.01',
                    'Accept-Encoding': 'gzip, deflate, br',
                    'Accept-Language': 'zh-CN,zh;q=0.8,en;q=0.6',
                    'Connection': 'keep-alive',
                    'Content-Length': '136',
                    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
                    'Cookie': 'bid=R02XdukjyTo',
                    'Host': 'accounts.douban.com',
                    'Origin': 'https://accounts.douban.com',
                    'Referer': 'https://accounts.douban.com/popup/login?source=fm&use_post_message',
                    'User-Agent': \
                        'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',
                    'X-Requested-With': 'XMLHttpRequest',
                }
        user_info = {
                    'source': 'fm',
                    'referer': 'https://douban.fm/user-guide',
                    'ck': '',
                    'name': name,
                    'password': passwd,
                    'captcha_solution': '',
                    'captcha_id': ''
                }
        url = 'https://accounts.douban.com/j/popup/login/basic'
        r = self.rqst.post(url, headers=headers, data=user_info)
        if r.status_code != 200:
            Logger.err("error login, status_code: %d" % r.status_code)
            return False
        json = r.json()
        print(json)
        if json[u'status'] == u'failed':
            Logger.err(json[u'description'])
            return False
        self.rqst.cookies.save()
        return True

    @pyqtSlot(str, result=bool)
    def get_playlist(self, rtype):
        query_str = {
                    'channel': '0',
                    'kbps': '192',
                    'client': 's:mainsite|y:3.0',
                    'app_name': 'radio_website',
                    'version': '100',
                    'type': rtype,
                    'sid': '',
                    'pt': '',
                    'pb': '128',
                    'apikey': ''
                }
        headers = {
                    'Accept': 'text/javascript, text/html, application/xml, text/xml, */*',
                    'Accept-Encoding': 'gzip, deflate, sdch, br',
                    'Accept-Language': 'zh-CN,zh;q=0.8,en;q=0.6',
                    'Connection': 'keep-alive',
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'Host': 'douban.fm',
                    'Referer': 'https://douban.fm/',
                    'User-Agent': \
                        'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',
                    'X-Requested-With': 'XMLHttpRequest',
                }
        Logger.log("type is %s" % rtype)
        if rtype != 'n':
            query_str['sid'] = self.song['sid']
        playlist_url = 'https://douban.com/j/v2/playlist'
        r = self.rqst.get(playlist_url, headers=headers, params=query_str)
        Logger.log(r.status_code)
        if r.status_code != 200:
            return False
        Logger.log(r)
        json = r.json()
        Logger.log(json)
        if json['r'] != 0:
            Logger.err(json['err'])
            return False
        if 'song' in json:
            self.song = json['song'][0]
        return True

    @pyqtSlot(result=bool)
    def download_content(self):
        headers = {
                   'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
                   'accept-encoding': 'gzip, deflate, sdch, br',
                   'accept-language': 'zh-CN,zh;q=0.8,en;q=0.6',
                   'cache-control': 'max-age=0',
                   'cookie': 'bid=ZD_5767jxic',
                    'user-agent': \
                            'Mozilla/5.0 (X11; Fedora; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36'
                }
        song = self.song
        pic_url = song['picture']
        r = self.rqst.get(pic_url, headers=headers, stream=True, timeout=10)
        pic_name = "picture/" + pic_url.split('/')[-1]
        if r.status_code != 200:
            Logger.err(pic_url)
            Logger.err('error get picture')
            Logger.err(r.status_code)
            return False
        else:
            with open(pic_name, 'wb') as target:
                for chunk in r.iter_content(1024):
                    target.write(chunk)

        music_url = song['url']
        r = self.rqst.get(music_url, headers=headers, stream=True, timeout=20)
        music_name = "music/" + music_url.split('/')[-1]
        if r.status_code != 200:
            Logger.err(music_url)
            Logger.err('error get music')
            Logger.err(r.status_code)
            return False
        else:
            with open(music_name, 'wb') as target:
                for chunk in r.iter_content(1024):
                    target.write(chunk)
        return True

    @pyqtSlot(result=str)
    def get_pic_name(self):
        res = self.song['picture'].split('/')[-1]
        Logger.log("pic_name %s" % res)
        return res

    @pyqtSlot(result=str)
    def get_music_name(self):
        res = self.song['url'].split('/')[-1]
        Logger.log("music_name %s" % res)
        return res

    @pyqtSlot(result=str)
    def get_artist(self):
        return self.song['artist']

    @pyqtSlot(result=str)
    def get_title(self):
        return self.song['title']

    @pyqtSlot(result=str)
    def get_lyric(self):
        headers = {
                   'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
                   'accept-encoding': 'gzip, deflate, sdch, br',
                   'accept-language': 'zh-CN,zh;q=0.8,en;q=0.6',
                   'cache-control': 'max-age=0',
                   'cookie': 'bid=ZD_5767jxic',
                    'user-agent': \
                            'Mozilla/5.0 (X11; Fedora; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36'
                }
        lyric_url = "https://douban.fm/j/v2/lyric"
        song_info = {
                'sid': self.song['sid'],
                'ssid': self.song['ssid']
                }
        r = requests.get(lyric_url, headers=headers, timeout=30, params=song_info)
        if r.status_code != 200:
            Logger.err('error')
            Logge.err(r.status_code)
        res = r.json()
        lyric = res['lyric']
        lr = re.compile("\[\d{2}:\d{2}\.\d{2}\]")
        content = lr.split(lyric)[1:]
        time = lr.findall(lyric)
        lyric_str = "".join(content)
        return lyric_str

