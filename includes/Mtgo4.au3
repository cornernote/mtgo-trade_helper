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
; Mtgo4
;=================================================================
#include-once

;
; Global Variables
;

Global $_Mtgo4_WindowTitle = IniRead(@ScriptDir & '\config.ini', 'main', 'window_title_mtgo4', 'Magic: The Gathering Online')
Global $_Mtgo4_Enable = False
Global $_Mtgo4_ToolTip = False
If IniRead(@ScriptDir & '\config.ini', 'main', 'enable_mtgo4', 1) > 0 Then $_Mtgo4_Enable = True


;
; Ingame Price ToolTip
;
Func _Mtgo4ToolTip()
   If Not $_Mtgo4_Enable Then 
	  Return
   EndIf
   Local $aPos[4]
   $aPos = _Mtgo4PopupFind()
   If $aPos[0] Then
	  If Not $_Mtgo4_ToolTip Then
		 $_Mtgo4_ToolTip = True
		 $aCard = _Mtgo4PopupRead($aPos)
		 If $aCard[1] Then
		   ToolTip('Loading card into MTGO WikiPrice helper.', $_Mtgo_LastPos[0], $_Mtgo_LastPos[1]-50, $aCard[1])
			_PopupGoto('/card/search/Card[cardname]/'&$aCard[1]&'/Card[set]/'&$aCard[0])
		 EndIf
	  EndIf
   Else
	  $_Mtgo4_ToolTip = False
	  ToolTip('')
   EndIf
EndFunc

;
; Read Popup
;
Func _Mtgo4PopupRead($aPos)
   Local $aCard[2]
   Local $sFile = _Mtgo4ScreenSave($aPos)
   Local $fFile = FileOpen($sFile&'.txt', 0)

   If $fFile = -1 Then
	  Return $aCard
   EndIf

   ToolTip('reading popup...', $_Mtgo_LastPos[0], $_Mtgo_LastPos[1]-50, 'Reading Card')
   $aCard[0] = _Mtgo4PopupReadEdition($fFile)
   $aCard[1] = _Mtgo4PopupReadName($fFile)
   FileClose($fFile)

   $_Globals_LastCard[0] = $aCard[0]
   $_Globals_LastCard[1] = $aCard[1]
   $_Globals_LastCard[2] = $sFile&'.txt'
   
   Return $aCard
EndFunc

;
; Read Popup Edition
;
Func _Mtgo4PopupReadEdition($fFile)
   Local $sText
   FileSetPos($fFile,0,0)
   While 1
	  $sText = FileReadLine($fFile)
	  If @error = -1 Then ExitLoop
	  $sText = _Mtgo4CleanEdition($sText)
	  For $i = 1 to $_Mtgo_Editions[0]
		 $aEdition = StringSplit($_Mtgo_Editions[$i], "|") 
		 For $ii = 1 to $aEdition[0]
			$sEdition = _Mtgo4CleanEdition($aEdition[$ii])
			If $sText And $sText==$sEdition Then 
			   Return $aEdition[1]
			EndIf
		 Next
	  Next
   WEnd
   Return ''
EndFunc

;
; Read Popup Card Name
;
Func _Mtgo4PopupReadName($fFile)
   FileSetPos($fFile,0,0)
   Local $sText = StringStripWS(FileReadLine($fFile),3)
   $sText = StringReplace($sText, '‘', "'")
   $sText = StringReplace($sText, '|', "l")

   For $i = 1 to $_Mtgo_Cards[0]
	  $aCard = StringSplit($_Mtgo_Cards[$i], "|") 
	  For $ii = 2 to $aCard[0]
		 $sCard = $aCard[$ii]
		 If $sText==$sCard Then 
			Return $aCard[1]
		 EndIf
	  Next
   Next
  
   
   Return $sText
EndFunc

;
; Read Card Number
;
Func _Mtgo4ReadNumber($fFile)
   FileSetPos($fFile,0,0)
   Local $sText = StringStripWS(FileReadLine($fFile),8)
   Return $sText
EndFunc

;
; Clean a Card Name
;
Func _Mtgo4CleanName($sName)
   $sName = StringRegExpReplace($sName, '[^0-9a-zA-Z]', '')
   $sName = StringStripWS($sName,8)
   $sName = StringLower($sName)
   Return $sName
EndFunc

;
; Clean an Edition Name
;
Func _Mtgo4CleanEdition($sName)
   $sName = StringRegExpReplace($sName, '[^a-zA-Z0-9]', '')
   $sName = StringStripWS($sName,8)
   $sName = StringLower($sName)
   Return $sName
EndFunc

;
; Save Screen (ocr, etc)
;
Func _Mtgo4ScreenSave($aPos)
   Local $iChecksum = PixelChecksum($aPos[0],$aPos[1],$aPos[2],$aPos[3])
   Local $sPath = @ScriptDir&'\data\text'
   Local $sFile = $sPath&'\'&$iChecksum
   
   If DirGetSize($sPath) = -1 Then
	  DirCreate($sPath)
   EndIf

   If Not FileExists($sFile&'.txt') Then
	  If Not FileExists($sFile&'_large.tif') Then
		 If Not FileExists($sFile&'.tif') Then
			ToolTip('please wait...', $_Mtgo_LastPos[0], $_Mtgo_LastPos[1]-50, 'Reading Card')
			_ScreenCapture_Capture($sFile&'.tif',$aPos[0],$aPos[1],$aPos[2],$aPos[3],False)
		 EndIf
		 If Not FileExists($sFile&'.tif') Then
			ToolTip('error - could not capture screen', $_Mtgo_LastPos[0], $_Mtgo_LastPos[1]-50, 'Reading Card')
			Return $sFile
		 EndIf
		 ShellExecuteWait($_Mtgo_ImageMagickPath, '"' & $sFile & '.tif" -resize ' & $_Mtgo_ZoomOcr & '% "' & $sFile & '_large.tif"', @ScriptDir, 'open', @SW_HIDE)
		 FileDelete($sFile & '.tif')
	  EndIf
	  If Not FileExists($sFile&'_large.tif') Then
		 ToolTip('error - could not resize image', $_Mtgo_LastPos[0], $_Mtgo_LastPos[1]-50, 'Reading Card')
		 Return $sFile
	  EndIf
	  ShellExecuteWait($_Mtgo_TesseractPath, '"' & $sFile & '_large.tif" "' & $sFile & '&', @ScriptDir, 'open', @SW_HIDE)
	  FileDelete($sFile & '_large.tif')
   EndIf
   If Not FileExists($sFile&'.txt') Then
	  ToolTip('error - could not read ocr', $_Mtgo_LastPos[0], $_Mtgo_LastPos[1]-50, 'Reading Card')
	  Return $sFile
   EndIf
   
   Return $sFile
EndFunc

;
; Find Popup Position and Size
;
Func _Mtgo4PopupFind()
   Local $aBottomPos[2]
   Local $aTopPos[2]
   Local $aPos[4]
   Local $aWinPos[4]
   
   ; get the window position
   If WinActive($_Mtgo4_WindowTitle) Then
	  $aWinPos = WinGetPos($_Mtgo4_WindowTitle)
	  If Not IsArray($aWinPos) Then
		 Return $aPos ; not found
	  EndIf
   Else
	  $aWinPos[0]=0
	  $aWinPos[1]=0
	  $aWinPos[2]=@DesktopWidth
	  $aWinPos[3]=@DesktopHeight
   EndIf

   ; find popup area
   $aTopPos = _Mtgo4PopupFindTop($aWinPos)
   If $aTopPos[0] Then
	  $aBottomPos = _Mtgo4PopupFindBottom($aTopPos)
	  If $aBottomPos[0] Then
		 $aPos[0] = $aTopPos[0]
		 $aPos[1] = $aTopPos[1]+5
		 $aPos[2] = $aBottomPos[0]
		 $aPos[3] = $aBottomPos[1]-5
		 $_Mtgo_LastPos[0] = $aPos[0]
		 $_Mtgo_LastPos[1] = $aPos[1]
	  EndIf
   EndIf
 
   ; return the position
   Return $aPos
EndFunc

;
; Find Popup's Top Left Corner
;
Func _Mtgo4PopupFindTop($aWinPos)
   Local $aChecksumMatch = StringSplit('3290440660,3305186269', ',')
   Return _Mtgo4PopupChecksumSearch($aWinPos[0],$aWinPos[1],$aWinPos[2],$aWinPos[3], 0x996600, $aChecksumMatch)
EndFunc

;
; Find Popup's Bottom Right Corner
;
Func _Mtgo4PopupFindBottom($aTopPos)
   Local $aBottomPos[2]

   ; right
   $aSearch = PixelSearch(_Min($aTopPos[0]+1000,@DesktopWidth),$aTopPos[1],$aTopPos[0],$aTopPos[1], 0x996600);
   If @error Then
	  ;_Debug('no bottom right')
	  Return $aBottomPos
   EndIf
   $aBottomPos[0] = $aSearch[0]

   ; down
   $aSearch = PixelSearch($aTopPos[0]-2,_Min($aTopPos[1]+1000,@DesktopHeight),$aTopPos[0]-4,$aTopPos[1], 0x996600)
   If @error Then
	  $aBottomPos[0] = False
	  ;_Debug('no bottom down')
	  Return $aBottomPos
   EndIf
   $aBottomPos[1] = $aSearch[1]
   
   Return $aBottomPos
EndFunc


;
; Search for Checksum for Popup
;
Func _Mtgo4PopupChecksumSearch($iLeft, $iTop, $iRight, $iBottom, $hPixelMatch, $aChecksumMatch)
   Local $aPos[2]

   ; find the matching pixel
   $aSearch = PixelSearch($iLeft,$iTop,$iRight,$iBottom, $hPixelMatch);
   If @error Then
	  ;_Debug('no pixel match')
	  Return $aPos ; not found
   EndIf

   ; set the position
   $aPos[0] = $aSearch[0]
   $aPos[1] = $aSearch[1]
   
   ; ensure the checksum matches
   $bMatch = false
   $iChecksum = PixelChecksum($aPos[0],$aPos[1],$aPos[0]+8,$aPos[1]+1)
   For $i = 1 to $aChecksumMatch[0]
	  If $iChecksum==Int($aChecksumMatch[$i]) Then
		 $bMatch = True
		 Break(1)
	  EndIf
   Next

   ; no match, keep looing from the last line
   If Not $bMatch Then
	  ;_Debug('no checksum match')
	  ;_ScreenCapture_Capture($iChecksum&'.tif',$aPos[0],$aPos[1],$aPos[0]+8,$aPos[1]+1,False)
	  ;MouseMove($aPos[0],$aPos[1])
	  ;Exit
	  $aPos = _Mtgo4PopupChecksumSearch($iLeft,$aSearch[1]+1,$iRight,$iBottom, $hPixelMatch, $aChecksumMatch)
   EndIf
   
   ; return the position
   Return $aPos
EndFunc
