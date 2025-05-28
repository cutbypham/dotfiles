;#KeyHistory
#Persistent
#noenv
#singleinstance force
#installmousehook
#installkeybdhook
setbatchlines -1
listlines off
sendmode input
setworkingdir %a_scriptdir%
CoordMode, Mouse, Screen

#o::suspend
space & f::RButton

insert::f14
delete::f15
home::f16
end::f17
pgup::f18
pgdn::f19
left::f20
up::f21
down::f22
right::f23
!#m::f24

f15::
send #^v
sleep 300
send {enter}
send {esc}
return

f16::
send #^v
sleep 300
send {down}
sleep 300
send {enter}
send {esc}
return

f17::
send #^v
sleep 300
send {down}
sleep 300
send {down}
sleep 300
send {enter}
send {esc}
return

#wheeldown::volume_up
#wheelup::volume_down

PrintScreen::
    Sleep, 1000
    SendMessage, 0x112, 0xF170, 2,, Program Manager
return
^PrintScreen::
DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0)
return
^f14::
Run, shutdown.exe /r /t 0 
Return
^f15::
Run, shutdown /s /t 0
Return

sc056::rcontrol

appskey::rcontrol

#include, %a_scriptdir%\lib\timelineclick.ahk
;#include, %a_scriptdir%\lib\snippets.ahk

#ifwinactive, ahk_exe onecommander.exe
!s::send ^{tab}
!w::send ^+{tab}
f1::
send {mbutton}
sleep 50
send ^+c
sleep 50
send #4
sleep 50
send ^+t
sleep 150
send useby
sleep 200
send {enter}
sleep 50
return
#ifwinactive


#SingleInstance, Force

; Set the working directory to the script's location
SetWorkingDir, %A_ScriptDir%

; Set the coordinate mode for mouse and pixel to screen
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

#ifwinactive, ahk_exe resolve.exe
f13:: ;change hotkey to desired hotkey
   timelineclick(["\imagesearch\resolve\editpage.png", "\imagesearch\resolve\fairlight.png",  "\imagesearch\resolve\cutpage.png"], [70,63,50])
return
`; & d::
send +v
send {del}
return
`; & j::
send +v
send ^+,
return
`; & l::
send +v
send ^+.
return
`; & 3::
send m
send {esc}
send {del}
return

`;::send  {;}
+`;::send +{;}
!`;::send !{;}
#`;::send #{;}

space & a::send +4
space & s::send +6
space & t::send +7
#ifwinactive

#ifwinactive, ahk_exe Sononym.exe
f13:: ;change hotkey to desired hotkey
   timelineclick(["\imagesearch\resolve\editpage.png", "\imagesearch\resolve\fairlight.png",  "\imagesearch\resolve\cutpage.png"], [70,63,50])
return
#ifwinactive

#ifwinactive ahk_exe chrome.exe
f1::^+t
f2::^w
f3::
send ^c
sleep 50
send ^t
sleep 50
send ^v
send {enter}
return
f4::
send ^c
sleep 50
send ^t
sleep 50
send v{space}
send ^v
sleep 50
send {enter}
return
^o::^+a
f13::^+a
!w::send ^{pgup}
!s::send ^{pgdn}
space & a::send !{Left}
space & s::send !{Right}
;Click, 1490, 50
!a::
image := A_ScriptDir "\imagesearch\resolve\stran.png"
WinGetPos, winX, winY, winW, winH, A
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

Loop {
    ;Sleep, 50
    ImageSearch, foundX, foundY, winX, winY, winX+winW, winY+winH, %image%
    if (ErrorLevel = 0) {
        MouseClick, left, foundX, foundY
        break
    }
}

MouseMove, 0, 90, 0, R
Click
return
#ifwinactive

#ifwinactive ahk_exe windowsterminal.exe
f3::^+t
f2::^+w
!w::send ^{pgup}
!s::send ^{pgdn}

f13 & l::send !{right}
f13 & h::send !{left}
f13 & j::send !{down}
f13 & k::send !{up}

f13::^+t
#ifwinactive

#ifwinactive ahk_exe obsidian.exe
f1::+1
f13::p
#ifwinactive

movingwindowtootherdisplay() {
    send #+{left}
    sysget, monitors, monitorcount

        sysget, monitorcount, monitorcount
        sysget, monitorprimary, monitorprimary

        current := 0
        loop, %monitorcount%
        {
            sysget, monitor, monitor, %a_index%
                coordmode, mouse, screen
                mousegetpos, mousex, mousey
                if (  (mousex >= monitorleft) && (mousex < monitorright) && (mousey >= monitortop) && (mousey < monitorbottom) )
                {
current := a_index
             currentrx := (mousex - monitorleft) / (monitorright - monitorleft)
             currentry := (mousey - monitortop) / (monitorbottom - monitortop)
             break
                }
        }
next := current + 1

          if (next > monitorcount)
              next := 1
                  sysget, monitor, monitor, %next%

                  newx := monitorleft + currentrx*(monitorright - monitorleft)
                  newy := monitortop + currentry*(monitorbottom - monitortop)

                  dllcall("setcursorpos", "int", newx, "int", newy)
                  dllcall("setcursorpos", "int", newx, "int", newy)
}

JumpCursorBetweenMonitors() {
    MouseGetPos, MouseX, MouseY ; Get current mouse position
    SysGet, MonitorCount, MonitorCount ; Get number of monitors

    if (MonitorCount < 2) {
        MsgBox, You need at least two monitors for this script to work.
        return
    }

    ; Get dimensions of both monitors
    SysGet, M1, Monitor, 1
    SysGet, M2, Monitor, 2

    ; Determine which monitor the mouse is currently on
    if (MouseX >= M1Left && MouseX <= M1Right && MouseY >= M1Top && MouseY <= M1Bottom) {
        ; Move to monitor 2
        NewX := MouseX - M1Left + M2Left
        NewY := MouseY - M1Top + M2Top
        MouseMove, NewX, NewY
    } else {
        ; Move to monitor 1
        NewX := MouseX - M2Left + M1Left
        NewY := MouseY - M2Top + M1Top
        MouseMove, NewX, NewY
    }
}

togglemaxwindow()
{
    winget, winstate, minmax, a
        if (winstate = 1)
        {
            winrestore, a
        }
        else
        {
            winmaximize, a
        }
}

tab & e::run, "c:\users\master\editing\projects\"
tab & w::run, "c:\users\master\downloads\"
tab & r::run, "e:\render\"
tab & t::run, "C:\Users\master\Pictures"
tab & 2::run, "e:\obs\"
tab & 3::run, "E:\phone\Camera\Camera"

tab::tab

space & [::send !{left}
space & ]::send !{right}
space & d::bs

space & i::home
space & o::end

space & `;::send #{space}

space & h::left
space & j::down
space & k::up
space & l::right

space & p::^pgdn
space & u::^pgup

space & m::pgdn
space & ,::pgup

space & v::send !+^v
space & x::del
space & g::send {enter}
space & b::#tab

space & +::volume_up
space & -::volume_down

space & `::!^s

space & tab::
send {mbutton}
send !{f4}
return

space & f13::
send {mbutton}
movingwindowtootherdisplay()
JumpCursorBetweenMonitors()
return

space & 1::send ^#1
space & 2::send ^#2
space & 3::send ^#3
space & 4::send ^#4
space & 5::send ^#5

space & f1::send #^6
space & f2::send #^7
space & f3::send #^8
space & f4::send #^9
space & f5::send #^0
Space & f6::send #+s
space & f9::reload

space & q::left
space & e::up
space & w::down
space & r::right

space::send  {space}
+space::send +{space}
!space::send !{space}
#space::send #{space}
^space::send ^{space}
