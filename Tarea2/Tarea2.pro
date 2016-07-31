#-------------------------------------------------
#
# Project created by QtCreator 2016-07-31T14:36:45
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = Tarea2
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h \
    lexico.l \
    sintactico.y

FORMS    += mainwindow.ui
