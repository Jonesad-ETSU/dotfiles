;==========================================================
;
;
;   ██████╗  ██████╗ ██╗  ██╗   ██╗██████╗  █████╗ ██████╗
;   ██╔══██╗██╔═══██╗██║  ╚██╗ ██╔╝██╔══██╗██╔══██╗██╔══██╗
;   ██████╔╝██║   ██║██║   ╚████╔╝ ██████╔╝███████║██████╔╝
;   ██╔═══╝ ██║   ██║██║    ╚██╔╝  ██╔══██╗██╔══██║██╔══██╗
;   ██║     ╚██████╔╝███████╗██║   ██████╔╝██║  ██║██║  ██║
;   ╚═╝      ╚═════╝ ╚══════╝╚═╝   ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
;
;
;   To learn more about how to configure Polybar
;   go to https://github.com/polybar/polybar
;
;   The README contains a lot of information
;
;==========================================================

[colors]
;background = ${xrdb:color0:#222}
background = #3B4252
background-alt = #444
;foreground = ${xrdb:color7:#222}
foreground = #ECEFF4
foreground-alt = #555
primary = #ffb52a
secondary = #e60053
alert = #bd2c40

[bar/example]
;monitor = ${env:MONITOR:HDMI-1}
width = 100%
height = 32
;offset-x = 1%
;offset-y = 1%
radius = 0.0
fixed-center = true

background = ${colors.background}
foreground = ${colors.foreground}

line-size = 3
line-color = #f00

border-size = 0
border-color = #00000000

padding-left = 0
padding-right = 0

module-margin-left = 0
module-margin-right = 0

font-0 = scientifica:size=16:antialias=true;2
font-1 = Ubuntu Nerd Font:fontformat=truetype:size=22:antialias=true;5
font-2 = siji:pixelsize=10;1

modules-left = launcher music bspwm i3 
modules-center = hearts
modules-right = pulseaudio memory cpu wlan eth lemtime

tray-position = right
tray-padding = 0
tray-background = #E5E9F0

wm-restack = bspwm
;wm-restack = i3

override-redirect = true

;scroll-up = bspwm-desknext
;scroll-down = bspwm-deskprev

;scroll-up = i3wm-wsnext
;scroll-down = i3wm-wsprev

cursor-click = pointer
cursor-scroll = ns-resize

enable-ipc = true

[module/xwindow]
type = internal/xwindow
label = %title:0:30:...%

[module/xkeyboard]
type = internal/xkeyboard
blacklist-0 = num lock

format-prefix = " "
format-prefix-foreground = ${colors.foreground-alt}
format-prefix-underline = ${colors.secondary}

label-layout = %layout%
label-layout-underline = ${colors.secondary}

label-indicator-padding = 2
label-indicator-margin = 1
label-indicator-background = ${colors.secondary}
label-indicator-underline = ${colors.secondary}

[module/filesystem]
type = internal/fs
interval = 25

mount-0 = /

label-mounted = %{F#0a81f5}%mountpoint%%{F-}: %percentage_used%%
label-unmounted = %mountpoint% not mounted
label-unmounted-foreground = ${colors.foreground-alt}

[module/bspwm]
type = internal/bspwm

label-focused = %index%
label-focused-background = ${colors.background-alt}
label-focused-underline= ${colors.primary}
label-focused-padding = 1

label-occupied = %index%
label-occupied-padding = 1

label-urgent = %index%!
label-urgent-background = ${colors.alert}
label-urgent-padding = 1

label-empty = %index%
label-empty-foreground = ${colors.foreground-alt}
label-empty-padding = 1

; Separator in between workspaces
; label-separator = |

[module/i3]
type = internal/i3
format = <label-state> <label-mode>
index-sort = true
wrapping-scroll = false

; Only show workspaces on the same output as the bar
;pin-workspaces = true

label-mode-padding = 2
label-mode-foreground = #000
label-mode-background = ${colors.primary}

; focused = Active workspace on focused monitor
label-focused = %index%
label-focused-background = ${colors.background-alt}
label-focused-underline= ${colors.primary}
label-focused-padding = 2

; unfocused = Inactive workspace on any monitor
label-unfocused = %index%
label-unfocused-padding = 2

; visible = Active workspace on unfocused monitor
label-visible = %index%
label-visible-background = ${self.label-focused-background}
label-visible-underline = ${self.label-focused-underline}
label-visible-padding = ${self.label-focused-padding}

; urgent = Workspace with urgency hint set
label-urgent = %index%
label-urgent-background = ${colors.alert}
label-urgent-padding = 2

; Separator in between workspaces
; label-separator = |


[module/mpd]
type = internal/mpd
format-online = <label-song>  <icon-prev> <icon-stop> <toggle> <icon-next>

icon-prev = 
icon-stop = 
icon-play = 
icon-pause = 
icon-next = 

label-song-maxlen = 25
label-song-ellipsis = true

[module/xbacklight]
type = internal/xbacklight

format = " BRI <bar>"
bar-width = 3
bar-indicator = |
bar-indicator-foreground = #fff
bar-indicator-font = 1
bar-fill = ─
bar-fill-font = 2
bar-fill-foreground = #9f78e1
bar-empty = ─
bar-empty-font = 2
bar-empty-foreground = ${colors.foreground-alt}

[module/backlight-acpi]
inherit = module/xbacklight
type = internal/backlight
card = intel_backlight

[module/cpu]
type = internal/cpu
interval = 2
format-prefix = ""
format-prefix-foreground = ${colors.foreground-alt}
;format-underline = #f90000
label = "CPU %percentage:2% "

[module/memory]
type = internal/memory
interval = 2
format-prefix = ""
format-prefix-foreground = ${colors.foreground-alt}
;format-underline = #4bffdc
label = "MEM %percentage_used% "

[module/wlan]
type = internal/network
interface = wlan0
interval = 3.0

format-connected = "<ramp-signal> <label-connected> "
;format-connected-underline = #9f78e1
label-connected = %local_ip%

format-disconnected =
;format-disconnected = <label-disconnected>
;format-disconnected-underline = ${self.format-connected-underline}
;label-disconnected = %ifname% disconnected
;label-disconnected-foreground = ${colors.foreground-alt}

ramp-signal-0 = 0
ramp-signal-1 = 1
ramp-signal-2 = 2
ramp-signal-3 = 3
ramp-signal-4 = 4
ramp-signal-foreground = ${colors.foreground-alt}

[module/eth]
type = internal/network
interface = eno2
interval = 3.0

format-connected-underline = #55aa55
format-connected-prefix = "NET "
format-connected-prefix-foreground = ${colors.foreground-alt}
label-connected = %local_ip%

format-disconnected =
;format-disconnected = <label-disconnected>
;format-disconnected-underline = ${self.format-connected-underline}
;label-disconnected = %ifname% disconnected
;label-disconnected-foreground = ${colors.foreground-alt}

[module/date]
type = internal/date
interval = 30

date = ""
date-alt = "%Y-%m-%d"

time = "%H:%M"
time-alt = "%H:%M:%S"

format-prefix = 
format-prefix-foreground = ${colors.foreground-alt}
;format-underline = #0a6cf5

label = "愈 %date% %time%"

[module/pulseaudio]
type = internal/pulseaudio

format-volume = <label-volume>
label-volume = "VOL %percentage% "
label-volume-foreground = ${root.foreground}

label-muted = "VOL🔇 muted "
label-muted-foreground = #666

click-left = #pulseaudio.mute
click-middle = pavucontrol

[module/alsa]
type = internal/alsa

format-volume = <label-volume> <bar-volume>
label-volume = VOL
label-volume-foreground = ${root.foreground}

format-muted-prefix = " "
format-muted-foreground = ${colors.foreground-alt}
label-muted = sound muted

bar-volume-width = 10
bar-volume-foreground-0 = #55aa55
bar-volume-foreground-1 = #55aa55
bar-volume-foreground-2 = #55aa55
bar-volume-foreground-3 = #55aa55
bar-volume-foreground-4 = #55aa55
bar-volume-foreground-5 = #f5a70a
bar-volume-foreground-6 = #ff5555
bar-volume-gradient = false
bar-volume-indicator = |
bar-volume-indicator-font = 2
bar-volume-fill = ─
bar-volume-fill-font = 2
bar-volume-empty = ─
bar-volume-empty-font = 2
bar-volume-empty-foreground = ${colors.foreground-alt}

[module/battery]
type = internal/battery
battery = BAT0
adapter = AC0
full-at = 98

format-charging = <animation-charging> <label-charging>
format-charging-underline = #ffb52a

format-discharging = <animation-discharging> <label-discharging>
format-discharging-underline = ${self.format-charging-underline}

format-full-prefix = " "
format-full-prefix-foreground = ${colors.foreground-alt}
format-full-underline = ${self.format-charging-underline}

ramp-capacity-0 = 
ramp-capacity-1 = 
ramp-capacity-2 = 
ramp-capacity-foreground = ${colors.foreground-alt}

animation-charging-0 = c1
animation-charging-1 = c2
animation-charging-2 = c3
animation-charging-foreground = ${colors.foreground-alt}
animation-charging-framerate = 750

animation-discharging-0 = d1
animation-discharging-1 = d2
animation-discharging-2 = d3
animation-discharging-foreground = ${colors.foreground-alt}
animation-discharging-framerate = 750

[module/temperature]
type = internal/temperature
thermal-zone = 0
warn-temperature = 60

format = <label>
;format-underline = #f50a4d
format-warn = <label-warn>
format-warn-underline = ${self.format-underline}

label = " %temperature-c% "  
label-warn = " %temperature-c% "  
label-warn-foreground = ${colors.secondary}

ramp-0 = 
ramp-1 = 
ramp-2 = 
ramp-foreground = ${colors.foreground-alt}

[module/powermenu]
type = custom/menu

expand-right = true

format-spacing = 1

label-open = 
label-open-foreground = ${colors.secondary}
label-close =  cancel
label-close-foreground = ${colors.secondary}
label-separator = |
label-separator-foreground = ${colors.foreground-alt}

menu-0-0 = reboot
menu-0-0-exec = menu-open-1
menu-0-1 = power off
menu-0-1-exec = menu-open-2

menu-1-0 = cancel
menu-1-0-exec = menu-open-0
menu-1-1 = reboot
menu-1-1-exec = sudo reboot

menu-2-0 = power off
menu-2-0-exec = sudo poweroff
menu-2-1 = cancel
menu-2-1-exec = menu-open-0

[module/hearts]
type = custom/script
exec = ~/.scripts/lemon/lemon-battery.sh
interval = 1
label = %output%

[module/music]
type = custom/script
exec = ~/.scripts/lemon/lemon-mpd.sh
interval = 1
label = %output%

[module/launcher]
type = custom/script
exec = ~/.scripts/lemon/lemon-edge.sh ~/.scripts/lemon/lemon-launcher.sh
label = %output%

[module/lemtime]
type = custom/script
exec = "~/.scripts/lemon/lemon-time.sh"
interval = 30
label = "%output%"


[settings]
screenchange-reload = true
;compositing-background = xor
;compositing-background = screen
;compositing-foreground = source
;compositing-border = over
;pseudo-transparency = false

[global/wm]
margin-top = 2
margin-bottom = 5

; vim:ft=dosini
