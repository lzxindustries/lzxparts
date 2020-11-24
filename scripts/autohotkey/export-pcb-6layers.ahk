#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

DIPTRACE_PCB_PATH = C:\Program Files\DipTrace\Pcb.exe
DIPTRACE_SCHEMATIC_PATH = C:\Program Files\DipTrace\Schematic.exe
KICAD_PATH = C:\Program Files\KiCad\bin\kicad.exe

PCB_FILE = %1% ;C:\world\dev\diptrace-ahk\MY_PROJECT_DIR\MY_PCB_FILE.dip
SCH_FILE = %2%
EXPORT_DIR = %3% ;C:\world\dev\diptrace-ahk\MY_EXPORT_DIR
LZX_PROJECT_NAME = %4% ;MYPROJECT
LZX_PROJECT_VERSION = %5% ;RevA
SRC_DIR = %6%

Loop, 1
{

FileCreateDir, %EXPORT_DIR%\kicad
FileCreateDir, %EXPORT_DIR%\eagle

; MsgBox, %PCB_FILE%
; MsgBox, %SCH_FILE%
; MsgBox, %EXPORT_DIR%
; MsgBox, %LZX_PROJECT_NAME%
; MsgBox, %LZX_PROJECT_VERSION%

; Launch Diptrace PCB & Export PCB ASCII
; Run, %DIPTRACE_PCB_PATH%
; SetTitleMatchMode, 2
; CoordMode, Mouse, Window

; tt = PCB Layout
; WinWaitActive, %tt%
; SendInput, {Blind} !fo
; tt = Open
; WinWaitActive, %tt%
; SendInput, {Blind} %PCB_FILE% {Enter}
; tt = PCB Layout
; WinWaitActive, %tt%
; SendInput, {Blind} !fxd
; tt = Save As
; WinWaitActive, %tt%
; SendInput, {Blind} {BackSpace} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-pcb-layout.asc!s
; Sleep, 2000
; SendInput, {Blind} {Enter}
; WinWaitClose, %tt%
; tt = PCB Layout
; WinWaitActive, %tt%
; WinClose, %tt%
; Sleep, 100
; SendInput, {Blind} {Enter}
; Sleep, 1000

; ; Sleep, 2000

; ; Launch Diptrace Schematic & Export Schematic ASCII
; Run, %DIPTRACE_SCHEMATIC_PATH%
; Sleep, 1000

; tt = Schematic
; WinWaitActive, %tt%
; Sleep, 1000
; SendInput, {Blind} !fo

; tt = Open
; WinWaitActive, %tt%
; Sleep, 1000
; SendInput, {Blind} %SCH_FILE% {Enter}

; tt = Schematic
; WinWaitActive, %tt%
; SendInput, {Blind} !fxd 
; tt = Save As
; WinWaitActive, %tt%
; SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-schematic.asc!s
; Sleep, 2000
; SendInput, {Blind} {Enter}
; WinWaitClose, %tt%

; tt = Schematic
; WinWaitActive, %tt%
; SendInput, {Blind} !fe

; Sleep, 2000
; SendInput, {Blind} {Enter}
; Sleep, 2000
; FileRead, SchematicASCII, %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-schematic.asc
; StringReplace, SchematicASCIIM, SchematicASCII, LZXNAME, %LZX_PROJECT_NAME%, All
; StringReplace, SchematicASCIIM, SchematicASCIIM, LZXVERSION, %LZX_PROJECT_VERSION%, All
; FileDelete, %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-schematic-modified.asc
; FileAppend, %SchematicASCIIM%, %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-schematic-modified.asc
; FileRead, PCBASCII, %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-pcb-layout.asc
; StringReplace, PCBASCIIM, PCBASCII, LZXNAME, %LZX_PROJECT_NAME%, All
; StringReplace, PCBASCIIM, PCBASCIIM, LZXVERSION, %LZX_PROJECT_VERSION%, All
; FileDelete, %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-pcb-layout-modified.asc
; FileAppend, %PCBASCIIM%, %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-pcb-layout-modified.asc
; Sleep, 2000
; Re-Import ASCII Schematic
Run, %DIPTRACE_SCHEMATIC_PATH%
tt = Schematic
WinWaitActive, %tt%  
;SendInput, {Blind} !fid 
SendInput, {Blind} !fo 

Sleep, 2000
tt = Open
WinWaitActive, %tt%
SendInput, {Blind} !n
Sleep, 500
;SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-schematic-modified.asc {Enter}
SendInput, {Blind} %SCH_FILE% {Enter}


tt = Schematic
WinWaitActive, %tt%
SendInput, {Blind} !fxe

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\eagle\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%.sch!s
Sleep, 1500
SendInput, {Blind} {Enter}
WinWaitClose, %tt%

tt = Schematic
WinWaitActive, %tt%
SendInput, {Blind} !ob

tt = Create Bill
WinWaitActive, %tt%
SendInput, {Blind} {Tab 15} {Enter}

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-bom.csv!s

tt = CSV Column Divider
WinWaitActive, %tt%
SendInput, {Blind} {Enter}

tt = Schematic
WinWaitActive, %tt%
SendInput, {Blind} !fe
Sleep, 500
SendInput, {Blind} n
Sleep, 500
SendInput, {Blind} {Tab 3} {Enter}
WinWaitClose, %tt%
; SendInput, {Blind} !fe

; tt = Confirm
; WinWaitActive, %tt%
; SendInput, {Blind} n

; Launch Diptrace PCB & Import PCB ASCII
Run, %DIPTRACE_PCB_PATH%
tt = PCB Layout
WinWaitActive, %tt%
;SendInput, {Blind} !fid
SendInput, {Blind} !fo

tt = Open
WinWaitActive, %tt%
;SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-pcb-layout-modified.asc {Enter}
SendInput, {Blind} %PCB_FILE% {Enter}

WinWaitClose, %tt%

tt = PCB Layout
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
Sleep, 1500
SendInput, {Blind} {Enter}
WinWaitClose, %tt%

; tt = PCB Layout
; WinWaitActive, %tt%
; SendInput, {Blind} !t33

; tt = 3D Preview
; WinWaitActive, %tt%
; SendInput, {Blind} {Tab 5} {Enter}

; tt = Export Step 3D
; WinWaitActive, %tt%
; SendInput, {Blind} {Tab 5} {Enter}

; tt = Save As
; WinWaitActive, %tt%
; SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-model3d.stp {Enter}
; WinWaitClose, %tt%

; tt = 3D Preview
; WinWaitActive, %tt%
; SendInput, {Blind} {Tab 8} {Enter}

tt = PCB Layout
WinWaitActive, %tt%
SendInput, {Blind} !fxa

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\eagle\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%.brd!s
WinWaitClose, %tt%

tt = PCB Layout
WinWaitActive, %tt%
SendInput, {Blind} {Enter}
Sleep, 500
SendInput, {Blind} {Enter}
Sleep, 500
SendInput, {Blind} !fe
Sleep, 500

tt = Confirm
WinWaitActive, %tt%
SendInput, {Tab} {Enter}
WinWaitClose, %tt%

Run, %KICAD_PATH%
tt = KiCad
WinWait, %tt%
IfWinNotActive, %tt%,, WinActivate, %tt%

Sleep, 100
MouseClick, L, 25, 38

Sleep, 100
MouseClick, L, 51, 170

Sleep, 100
MouseClick, L, 281, 172

Sleep, 100

tt = Import Eagle
WinWaitActive, %tt%
SendInput, {Blind} {BackSpace} %EXPORT_DIR%\eagle\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%.sch {Enter}
WinWaitClose, %tt%

tt = KiCad Project
WinWaitActive, %tt%
SendInput, {Blind} {BackSpace} %EXPORT_DIR%\kicad {Enter} {Enter}

tt = kicad Information
WinWaitActive, %tt%
SendInput, {Blind} {Enter}
WinWaitClose, %tt%

tt = Pcbnew
WinWaitActive, %tt%
SendInput, {Blind} {CtrlDown}s{CtrlUp}
Sleep, 500
WinClose, %tt%
WinWaitClose, %tt%

tt = Eeschema
WinWaitActive, %tt%
SendInput, {Blind} {CtrlDown}s{CtrlUp}
Sleep, 500
WinClose, %tt%
WinWaitClose, %tt%

tt = KiCad
WinWaitActive, %tt%
WinClose, %tt%
WinWaitClose, %tt%

}
