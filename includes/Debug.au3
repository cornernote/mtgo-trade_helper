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
; Debug Functions
;=================================================================
#include-once

Func _Debug($debug)
   ConsoleWrite(_DebugArray($debug))
EndFunc

Func _DebugArray($aArray,$sPad='')
	$sString = ''
	If (IsArray($aArray)) Then
		$sString = $sString & $sPad & 'array:' & @CRLF
		For $a In $aArray
			$sString = $sString & _DebugArray($a, $sPad & '> ')
		Next
	Else
		$sString = $sString & $sPad & $aArray & @CRLF
	EndIf
	Return $sString
EndFunc

Func _DebugPixelChecksum($l,$t,$r,$b)
	$checksum = PixelChecksum($l,$t,$r,$b)
	$clip = "PixelChecksum("&$l&","&$t&","&$r&","&$b&")=="&$checksum
	_Debug($clip)
	ClipPut($clip)
	TrayTip('copied to clipboard',$checksum,500)
EndFunc