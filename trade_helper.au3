;=================================================================
; MTGO Trade Helper
;=================================================================
;
; Copyright (c) 2013 - Brett O'Donnell <cornernote@gmail.com>
;
; Home Page: https://sites.google.com/site/cornernote/mtgo/trade_helper
; Download: https://github.com/cornernote/mtgo-trade_helper/archive/master.zip
; Source Code: https://github.com/cornernote/mtgo-trade_helper
;
;=================================================================
; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
; You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
;=================================================================

;=================================================================
; Kill Other Onstances
;=================================================================
If WinExists('trade_helper') Then
	WinKill('trade_helper')
EndIf
AutoItWinSetTitle('trade_helper')

;=================================================================
; Includes
;=================================================================
#include "includes/Debug.au3"
#include "includes/Globals.au3"
#include "includes/Mtgo.au3"
#include "includes/Mtgo3.au3"
#include "includes/Mtgo4.au3"
#include "includes/Popup.au3"
#include "includes/Tray.au3"

;=================================================================
; Hotkeys
;=================================================================
HotKeySet('^!C', 'CopyLastCard')
HotKeySet('^!O', 'OpenLastCardFile')

;=================================================================
; Run
;=================================================================
_MtgoInit()
_MtgoMainLoop()