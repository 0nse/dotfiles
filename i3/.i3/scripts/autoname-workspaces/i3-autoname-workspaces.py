#!/usr/bin/env python3

# https://gist.github.com/justbuchanan/70fdae0d5182f6039aa8383c06a3f4ad#file-i3-autoname-workspaces-py

# This script listens for i3 events and updates workspace names to show icons
# for running programs.  It contains icons for a few programs, but more can
# easily be added by inserting them into WINDOW_ICONS below.
#
# Dependencies
# * xorg-xprop - install through system package manager
# * i3ipc - install with pip


import i3ipc
import subprocess as proc
import re


# Add icons here for common programs you use.  The keys are the X window class
# (WM_CLASS) names and the icons can be any text you want to display. However
# most of these are character codes for font awesome:
#   http://fortawesome.github.io/Font-Awesome/icons/
FA_COMMENT_O = '\uf0e5'
FA_CHROME = '\uf268'
FA_CODE = '\uf121'
FA_FILE_IMAGE_O = '\uf1c5'
FA_FILE_PDF_O = '\uf1c1'
FA_FILE_TEXT_O = '\uf0f6'
FA_FILES_O = '\uf0c5'
FA_FIREFOX = '\uf269'
FA_ENVNELOPE_O = '\uf003'
FA_HEADPHONES = '\uf025'
FA_PICTURE_O = '\uf03e'
FA_UNLOCK_ALT = '\uf13e'
FA_TERMINAL = '\uf120'
WINDOW_ICONS = {
    'st-256color':                          FA_TERMINAL,
    'chromium':                             FA_CHROME,
    'nvim':                                 FA_CODE,
    'google play music desktop player':     FA_HEADPHONES,
    'Firefox':                              FA_FIREFOX,
    'libreoffice':                          FA_FILE_TEXT_O,
    'Mail':                                 FA_ENVNELOPE_O,
    'feh':                                  FA_PICTURE_O,
    'zathura':                              FA_FILE_PDF_O,
    'PDFXCview.exe':                        FA_FILE_PDF_O,
    'spacefm':                              FA_FILES_O,
    'crx_bikioccmkafdpakkkcpdbppfkghcmihk': FA_COMMENT_O,
    'telegram-desktop':                     FA_COMMENT_O,
    'keepassx':                             FA_UNLOCK_ALT,
    'gimp':                                 FA_FILE_IMAGE_O,
}


i3 = i3ipc.Connection()


# Returns an array of the values for the given property from xprop.  This
# requires xorg-xprop to be installed.
def xprop(win_id, property):
    try:
        xpropCommand = ['xprop', '-id', str(win_id), property]
        prop = proc.check_output(xpropCommand, stderr=proc.DEVNULL)
        prop = prop.decode('utf-8')
        return re.findall('"([^"]+)"', prop)
    except proc.CalledProcessError as e:
        print("Unable to get property for window '%s'" % str(win_id))
        return None


def icon_for_window(window):
    classes = xprop(window.window, 'WM_CLASS')
    if classes is not None and len(classes) > 0:
        for cls in classes:
            if cls in WINDOW_ICONS:
                return WINDOW_ICONS[cls]
        print('No icon available for window with classes: %s' % str(classes))
    return '*'


# renames all workspaces based on the windows present
def rename():
    for workspace in i3.get_tree().workspaces():
        icons = [icon_for_window(w) for w in workspace.leaves()]
        new_name = "%d: %s" % (workspace.num, '  '.join(icons))
        i3.command('rename workspace "%s" to "%s"'
                   % (workspace.name, new_name))


rename()


# call rename() for relevant window events
def on_change(i3, e):
    if e.change in ['new', 'close', 'move']:
        rename()


i3.on('window', on_change)
i3.main()
