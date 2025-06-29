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

sc056::rcontrol
appskey::rcontrol

#include, %a_scriptdir%\lib\timelineclick.ahk

#ifwinactive, ahk_exe onecommander.exe
!s::send ^{tab}
!w::send ^+{tab}
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
#ifwinactive

#ifwinactive ahk_exe firefox.exe
f1::^+t
f2::^w
^o::^+a
!w::send ^{pgup}
!s::send ^{pgdn}

!d::send !{left}
!e::send !{right}

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
send y{space}
send ^v
sleep 50
send {enter}
return
#ifwinactive

#ifwinactive ahk_exe windowsterminal.exe
f3::^+t
f2::^+w
!w::send ^{pgup}
!s::send ^{pgdn}

f13::^+t
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
tab & 2::run, "e:\obs\"

tab::tab

space & =::volume_up
space & -::volume_down

space & a::^#1
space & s::^#2
space & d::^#3
space & f::^#4
space & q::^#5
space & w::^#6
space & e::^#7
space & r::^#8

space & v::^#+v

space & u::pgup
space & p::pgdn

space & z::movingwindowtootherdisplay()

space & LButton::RButton

space & f13::bs
space & g::delete

space & wheeldown::volume_up
space & wheelup::volume_down

space & i::home
space & o::end

space & k::up
space & j::down
space & l::right
space & h::left

space & tab::
send {mbutton}
send !{f4}
return

space & PrintScreen::reload

space::send  {space}
+space::send +{space}
!space::send !{space}
#space::send #{space}
^space::send ^{space}
