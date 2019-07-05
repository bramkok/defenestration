; AutoHotKey script to change Alt+Tab

App := "Alt+Tab Binding"
SetWorkingDir %A_ScriptDir%
#NoEnv
#SingleInstance force
#InstallKeybdHook
#InstallMouseHook
#UseHook on
SetTitleMatchMode, 2
DetectHiddenWindows, Off
CoordMode, Mouse, Screen
SetWinDelay, -1
#Persistent
AutoTrim Off
SetCapsLockState, AlwaysOff
return

; You can use Ctrl+Shift+Esc or Rwin+Del to open task manager instead of Ctrl + Alt + Del:
#Del::Run, taskmgr

; This would can be useful anyway: http://www.autohotkey.com/docs/misc/Remap.htm#registry

; Alt+Tab/Alt+Shift+Tab: Hotkeys + Mouse alternative:
;Ctrl+Shift+PageDown or Right-click + Tab
^+PGDN::
~RButton & Tab::
Send, ^+!{tab}
return

; Rwin replaces the Alt key... Read: http://www.autohotkey.com/docs/misc/Remap.htm
Rwin::Alt
