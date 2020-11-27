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
NUM_LAYERS = %7%

Loop, 1
{

FileCreateDir, %EXPORT_DIR%\kicad
FileCreateDir, %EXPORT_DIR%\eagle

; MsgBox, %PCB_FILE%
; MsgBox, %SCH_FILE%
; MsgBox, %EXPORT_DIR%
; MsgBox, %LZX_PROJECT_NAME%
; MsgBox, %LZX_PROJECT_VERSION%

;Launch Diptrace PCB & Export PCB ASCII
   ;Launch Diptrace PCB & Export PCB ASCII
    Run, %DIPTRACE_PCB_PATH%
    SetTitleMatchMode, 1
    CoordMode, Mouse, Window

    tt = PCB Layout
    WinWaitActive, %tt%, , 10
    SendInput, !fo
    
    tt = Open
    WinWaitActive, %tt%
    SendInput, %PCB_FILE% {Enter}

    tt = PCB Layout
    WinWaitActive, %tt%
    SendInput, !fxd  

    tt = Save As
    WinWaitActive, %tt%
    SendInput, {BackSpace} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-pcb-layout.asc!s
    ;Sleep, 500
    ;SendInput, {Blind} {Enter}
    ;MsgBox, ""
    WinWaitClose, %tt%

    tt = PCB Layout
    WinWaitActive, %tt%
    WinClose, %tt%
    
    tt = Confirm
    WinWait, %tt%, , 2
    if ErrorLevel
    {
    }
    else
    {
        WinActivate, %tt%
        SendInput, {Blind} {Enter}
        WinWaitClose, %tt%
    }

; Sleep, 2000

; Launch Diptrace Schematic & Export Schematic ASCII
Run, %DIPTRACE_SCHEMATIC_PATH%
Sleep, 1000

tt = Schematic
WinWaitActive, %tt%
Sleep, 1000
SendInput, {Blind} !fo

tt = Open
WinWaitActive, %tt%
Sleep, 1000
SendInput, {Blind} %SCH_FILE% {Enter}

tt = Schematic
WinWaitActive, %tt%
SendInput, {Blind} !fxd 
tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-schematic.asc!s
Sleep, 2000
SendInput, {Blind} {Enter}
WinWaitClose, %tt%


tt = Schematic
WinWaitActive, %tt%
WinClose, %tt%
    
tt = Confirm
WinWait, %tt%, , 2
if ErrorLevel
{
}
else
{
    WinActivate, %tt%
    SendInput, {Blind} {Enter}
    WinWaitClose, %tt%
}

; tt = Confirm
; WinWaitActive, %tt%
; SendInput, {Blind} {Enter}

RunWait, python pcb-text-replace.py LZXVERSION %LZX_PROJECT_VERSION% "%EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-schematic.asc"
RunWait, python pcb-text-replace.py LZXVERSION %LZX_PROJECT_VERSION% "%EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-pcb-layout.asc"
RunWait, python pcb-text-replace.py LZXPARTNAME %LZX_PROJECT_NAME% "%EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-schematic.asc"
RunWait, python pcb-text-replace.py LZXPARTNAME %LZX_PROJECT_NAME% "%EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-pcb-layout.asc"

; Re-Import ASCII Schematic
Run, %DIPTRACE_SCHEMATIC_PATH%

tt = Schematic
WinWaitActive, %tt%  
Sleep, 1000
WinActivate, %tt%
SendInput, !fid 
;SendInput, {Blind} !fo 

tt = Open
WinWaitActive, %tt%
WinActivate, %tt%
SendInput, !n
SendInput, %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-schematic.asc {Enter}

tt = Schematic
WinWaitActive, %tt%
SendInput, !fxe

tt = Save As
WinWaitActive, %tt%
SendInput, %EXPORT_DIR%\eagle\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%.sch!s
Sleep, 1500
SendInput, {Blind} {Enter}
WinWaitClose, %tt%

tt = Schematic
WinWaitActive, %tt%
SendInput, !ob

tt = Create Bill
WinWaitActive, %tt%
SendInput, {Tab 15} {Enter}

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-bom.csv!s

tt = CSV Column Divider
WinWaitActive, %tt%
SendInput, {Enter}

tt = Schematic
WinWaitActive, %tt%
SendInput, !fp

tt = Print
WinWaitActive, %tt%
SendInput, {Tab 4} {Enter}

tt = Save PDF File As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-schematics.pdf!s
WinWaitClose, %tt%

tt = %LZX_PROJECT_NAME%
WinWaitActive, %tt%
WinClose, %tt%

tt = Schematic
WinWaitActive, %tt%
SendInput, !fs
    
tt = Save As
WinWaitActive, %tt%
SendInput, %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%.dch!s
WinWaitClose, %tt%

tt = Schematic
WinWaitActive, %tt%
WinClose, %tt%

; Launch Diptrace PCB & Import PCB ASCII
Run, %DIPTRACE_PCB_PATH%
tt = PCB Layout
WinWaitActive, %tt%
SendInput, !fid

tt = Open
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-pcb-layout.asc {Enter}
WinWaitClose, %tt%


tt = PCB Layout
WinWaitActive, %tt%
Sleep, 500
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

Loop %NUM_LAYERS%
{
    tt = Save As
    WinWaitActive, %tt%
    index = %A_Index%
    ;index += 1
    SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-layer-%index%.gbr!s
    WinWaitClose, %tt%
}

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
SendInput, !fxn

tt = Export N/C Drill
WinWaitActive, %tt%
SendInput, {Tab 2}
SendInput, {Space}
SendInput, {Tab 16}
SendInput, {Enter}

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
SendInput, {Blind} !vum
Sleep, 500
SendInput, {Blind} !fxp

tt = Pick and Place Report
WinWaitActive, %tt%
;SendInput, {Blind} {Tab 1}
SendInput, {Blind} {Up 2} {Down}
SendInput, {Blind} {Tab 14}
SendInput, {Blind} {Enter}

tt = Save As
WinWaitActive, %tt%
SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-xy-placement-data-top.csv!s
Sleep, 1500
SendInput, {Blind} {Enter}
WinWaitClose, %tt%

 tt = PCB Layout
 WinWaitActive, %tt%
 SendInput, {Blind} !vum
 SendInput, {Blind} !fxp

 tt = Pick and Place Report
 WinWaitActive, %tt%
 Sleep, 200
 SendInput, {Tab 3}
 Sleep, 200
 SendInput, {Down}
 Sleep, 200
 SendInput, {Tab 14}
 Sleep, 200
 SendInput, {Enter}

 tt = Save As
 WinWaitActive, %tt%
 SendInput, {Blind} %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-xy-placement-data-bottom.csv!s
 Sleep, 1500
 SendInput, {Blind} {Enter}
 WinWaitClose, %tt%

tt = PCB Layout
WinWaitActive, %tt%
SendInput, {Blind} !t33

tt = 3D Preview
WinWaitActive, %tt%
Sleep, 1000
WinWaitActive, %tt%
Sleep, 1000
WinWaitActive, %tt%
SendInput, {Tab 5}
Sleep, 1000
SendInput, {Space}
Sleep, 1000
SendInput, {Blind} {Tab 3} {Down} {Tab 1} {Enter} 
Sleep, 1000
SendInput, {Blind} !n%EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%-model3d.stp!s

tt = 3D Preview
WinWaitActive, %tt%
SendInput, {Blind} {Tab 8} {Enter}

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

tt = PCB Layout 
WinWaitActive, %tt%
SendInput, !fs
    
tt = Save As
WinWaitActive, %tt%
SendInput, %EXPORT_DIR%\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%.dip!s
WinWaitClose, %tt%

tt = PCB Layout
WinWaitActive, %tt%
WinClose, %tt%

WinWaitClose, %tt%
; tt = Confirm
; WinWaitActive, %tt%
; SendInput, {Tab} {Enter}
; ;WinWaitClose, %tt%
; Sleep, 500

Run, %KICAD_PATH%
tt = KiCad
WinWaitActive, %tt%

Sleep, 100
MouseClick, L, 25, 38

Sleep, 100
MouseClick, L, 51, 170

Sleep, 100
MouseClick, L, 281, 172

Sleep, 100

tt = Import Eagle
WinWaitActive, %tt%
SendInput, {BackSpace} %EXPORT_DIR%\eagle\%LZX_PROJECT_NAME%-%LZX_PROJECT_VERSION%.sch {Enter}
WinWaitClose, %tt%

tt = KiCad Project
WinWaitActive, %tt%
SendInput, {BackSpace} %EXPORT_DIR%\kicad {Enter} {Enter}


;tt = kicad Information
;WinWaitActive, %tt%,
;SendInput, {Enter}
;WinWaitClose, %tt%

tt = Pcbnew
WinWait, %tt%
WinActivate, %tt%
WinWaitActive, %tt%
WinClose, %tt%

tt = kicad.exe
WinWaitActive, %tt%
SendInput, {Blind} {Enter}

tt = Eeschema
WinWait, %tt%
WinActivate, %tt%
WinWaitActive, %tt%
WinClose, %tt%

tt = kicad.exe
WinWaitActive, %tt%
SendInput, {Blind} {Enter}

tt = KiCad (
WinClose, %tt%
WinWaitClose, %tt%

tt = KiCad (
WinClose, %tt%
}
