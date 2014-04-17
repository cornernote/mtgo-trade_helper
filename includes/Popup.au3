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
; Popup
;=================================================================
#include-once


;
; Includes
;

#include <IE.au3>
#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>


;
; Global Variables
;

Global $_Popup_Title = 'MTGO WikiPrice'
Global $_Popup_Site = 'http://mtgowikiprice.com'
Global $_Popup_Url = '/site/page/view/helper-start'
Global $_Popup_ButtonView
Global $_Popup_Url
Global $_Popup_GUI = GUICreate($_Popup_Title, 350, 550, -1, -1)
Global $_Popup_IE = _IECreateEmbedded()


;
; Init
;
Func _PopupInit()
   GUISetIcon(@ScriptDir&'/icon.ico')
   $_Popup_ButtonView = GUICtrlCreateButton('View in Browser', 10, 515, 330)
   GUICtrlCreateObj($_Popup_IE, 0, 0, 350, 510)
   $oEvt = ObjEvent($_Popup_IE,"IEEvent_","DWebBrowserEvents2")
   GUISetState(@SW_SHOW, $_Popup_GUI)
   _PopupGoto('')
EndFunc


;
; Goto Url
;
Func _PopupGoto($sUrl)
   If Not $sUrl Then
	  $sUrl = $_Popup_Url
   EndIf
   _IENavigate($_Popup_IE, $_Popup_Site&$sUrl&'?layout=helper')
EndFunc


;
; CheckInput
;
Func _PopupCheckInput()
   Switch GUIGetMsg()
	  Case $_Popup_ButtonView
		 _PopupViewInBrowser()
	  Case $GUI_EVENT_CLOSE
		 Exit
   EndSwitch
EndFunc


;
; GetUrl
;
Func _PopupGetUrl()
   Return _IEPropertyGet($_Popup_IE, 'locationURL')
EndFunc


;
; ViewInBrowser
;
Func _PopupViewInBrowser()
   Local $sUrl = _PopupGetUrl()
   $sUrl = StringReplace($sUrl,'/site/page/view/helper-start','')
   $sUrl = StringReplace($sUrl,'/layout/helper','')
   $sUrl = StringReplace($sUrl,'?layout=helper','')
   $sUrl = StringReplace($sUrl,'/card/helper/set/','/card/view/set/','')
   _Debug($sUrl)
   ShellExecute($sUrl)
EndFunc
