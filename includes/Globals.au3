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
; Globals
;=================================================================
#include-once

;
; Global Variables
;

Global $_Globals_LastCard[3]


;
; Copy Last Card Data
;
Func CopyLastCard()
   If $aLastCard[0] Then
	  ClipPut($aLastCard[0])
   EndIf
EndFunc
 
;
; Open Last Card File
;
Func OpenLastCardFile()
   If $aLastCard[2] Then
	  ShellExecute($aLastCard[2])
   EndIf
EndFunc
