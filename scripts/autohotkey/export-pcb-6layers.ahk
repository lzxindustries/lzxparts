#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

DIPTRACE_PCB_PATH = C:\Program Files\DipTrace\Pcb.exe
PCB_FILE = %1% ;C:\world\dev\diptrace-ahk\MY_PROJECT_DIR\MY_PCB_FILE.dip
EXPORT_DIR = %2% ;C:\world\dev\diptrace-ahk\MY_EXPORT_DIR
LZX_PROJECT_NAME = %3% ;MYPROJECT
LZX_PROJECT_VERSION = %4% ;RevA

Loop, 1
{
; Launch Diptrace
Run, %DIPTRACE_PCB_PATH%

SetTitleMatchMode, 2
CoordMode, Mouse, Window

tt = PCB Layout
WinWaitActive, %tt%
SendInput, {Blind} !fo

tt = Open
WinWaitActive, %tt%
SendInput, {Blind} %PCB_FILE% {Enter}

tt = PCB Layout - [%PCB_FILE%]
WinWaitActive, %tt%
SendInput, {Blind} !fxg

tt = Export Gerber
WinWaitActive, %tt%
SendInput, {Blind} {Tab 22} {Enter}

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-top-silk.gbr!s
WinWaitClose, %tt%

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-top-mask.gbr!s
WinWaitClose, %tt%

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-top-paste.gbr!s
WinWaitClose, %tt%

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-layer-1-top.gbr!s
WinWaitClose, %tt%

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-layer-2.gbr!s
WinWaitClose, %tt%

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-layer-3.gbr!s
WinWaitClose, %tt%

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-layer-4.gbr!s
WinWaitClose, %tt%

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-layer-5.gbr!s
WinWaitClose, %tt%

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-layer-6-bottom.gbr!s
WinWaitClose, %tt%

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-bottom-paste.gbr!s
WinWaitClose, %tt%

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-bottom-mask.gbr!s
WinWaitClose, %tt%

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-bottom-silk.gbr!s
WinWaitClose, %tt%

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-board-outline.gbr!s
WinWaitClose, %tt%

tt = Export Gerber
WinWaitActive, %tt%
WinClose, %tt%
WinWaitClose, %tt%

tt = PCB Layout
WinWaitActive, %tt%
SendInput, {Blind} !fxn

tt = Export N/C Drill
WinWaitActive, %tt%
SendInput, {Blind} {Tab 2}
SendInput, {Blind} {Space}
SendInput, {Blind} {Tab 16}
SendInput, {Blind} {Enter}

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-nc-drill.drl!s
WinWaitClose, %tt%

tt = Export N/C Drill
WinWaitActive, %tt%
WinClose, %tt%
WinWaitClose, %tt%

tt = PCB Layout
WinWaitActive, %tt%
SendInput, {Blind} !fxp

tt = Pick and Place Report
WinWaitActive, %tt%
SendInput, {Blind} {Tab 2}
SendInput, {Blind} {Enter}

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-xy-placement-data.csv!s
Sleep, 500
SendInput, {Blind} {Enter}
WinWaitClose, %tt%

; tt = Pick and Place Report'
; WinWaitActive, %tt%
; WinClose, %tt%
; WinWaitClose, %tt%




; Sleep, 1000
; SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-TopMask.gbr
; Sleep, 1000
; SendInput, {Blind} !s
; Sleep, 1000
; SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-TopPaste.gbr
; Sleep, 1000
; SendInput, {Blind} !s
; Sleep, 1000
; SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-TopCopper.gbr
; Sleep, 1000
; SendInput, {Blind} !s
; Sleep, 1000
; SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-BottomCopper.gbr
; Sleep, 1000
; SendInput, {Blind} !s
; Sleep, 1000
; SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-BottomPaste.gbr
; Sleep, 2000
; SendInput, {Blind} !s
; Sleep, 2000
; SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-BottomMask.gbr
; Sleep, 2000
; SendInput, {Blind} !s
; Sleep, 2000
; SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-BottomSilk.gbr
; Sleep, 2000
; SendInput, {Blind} !s
; Sleep, 2000
; SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-BoardOutline.gbr
; Sleep, 2000
; SendInput, {Blind} !s
; Sleep, 1000

; !s
; Sleep, 1500
; SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%%LZX_PROJECT_VERSION%-TopMask.gbr!s
; Sleep, 1500
; SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%%LZX_PROJECT_VERSION%-TopPaste.gbr!s
; Sleep, 1500
; SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%%LZX_PROJECT_VERSION%-TopCopper.gbr!s
; Sleep, 1500
; SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%%LZX_PROJECT_VERSION%-BottomCopper.gbr!s
; Sleep, 1500
; SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%%LZX_PROJECT_VERSION%-BottomPaste.gbr!s
; Sleep, 1500
; SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%%LZX_PROJECT_VERSION%-BottomMask.gbr!s
; Sleep, 1500
; SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%%LZX_PROJECT_VERSION%-BottomSilk.gbr!s
; Sleep, 1500
; SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%%LZX_PROJECT_VERSION%-BoardOutline.gbr!s
; Sleep, 1500


}
