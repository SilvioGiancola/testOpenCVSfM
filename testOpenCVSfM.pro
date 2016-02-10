#-------------------------------------------------
#
# Project created by QtCreator 2016-02-08T10:39:13
#
#-------------------------------------------------

QT       += core

QT       -= gui

TARGET = testOpenCVSfM
CONFIG   += console
CONFIG   -= app_bundle

TEMPLATE = app


SOURCES += main.cpp

unix: CONFIG += link_pkgconfig
unix: PKGCONFIG += opencv
