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
; Mtgo
;=================================================================
#include-once


;
; Includes
;
#include <Array.au3>
#include <File.au3>
#include <Math.au3>
#include <ScreenCapture.au3>


;
; Global Variables
;

Global $_Mtgo_LoopPause = Int(IniRead(@ScriptDir & '\config.ini', 'main', 'loop_pause', 200))
Global $_Mtgo_ZoomOcr = Int(IniRead(@ScriptDir & '\config.ini', 'main', 'zoom_ocr', 1000))
Global $_Mtgo_ImageMagickPath = @ScriptDir & '\vendors\imagemagick\ImageMagick-6.8.6-Q16\convert.exe'
Global $_Mtgo_TesseractPath = @ScriptDir & '\vendors\tesseract\tesseract-ocr-3.02.02\tesseract.exe'
Global $_Mtgo_LastPos[2]
Global $_Mtgo_Cards = StringSplit(FileRead('data/cards.txt'), @CRLF)
Global $_Mtgo_Editions = StringSplit(FileRead('data/editions.txt'), @CRLF)


;
; MainLoop
;
Func _MtgoMainLoop()
   Local $begin = TimerInit()
   While 1
	  _MtgoCheckInput()
	  If TimerDiff($begin) > $_Mtgo_LoopPause Then
		 _MtgoToolTip()
		 $begin = TimerInit()
	  EndIf
	  
   WEnd
EndFunc


;
; Init
;
Func _MtgoInit()
   _TrayInit()
   _PopupInit()
EndFunc


;
; CheckInput
;
Func _MtgoCheckInput()
   _TrayCheckInput()
   _PopupCheckInput()
EndFunc


;
; ToolTip
;
Func _MtgoToolTip()
   _Mtgo3ToolTip()
   _Mtgo4ToolTip()
EndFunc
