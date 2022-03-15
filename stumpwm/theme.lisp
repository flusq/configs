(in-package :stumpwm)

(setf *startup-message* "Hello user")
(uiop:launch-program "feh --bg-fill ~/media/pictures/wallpapers/lap.jpg")

(setf *colors* 
    `("#2b303b" ;black
      "#bf616a" ;red
      "#a3be8c" ;green
      "#ecbe7b" ;yellow
      "#8fa1b3" ;blue
      "#b48ead" ;magenta
      "#46d9ff" ;cyan
      "#c0c5ce" ;white
      ))

(update-color-map (current-screen))
(set-fg-color "#c0c5ce")
(set-bg-color "#2b303b")
(set-border-color "#d08770")


(setf *mode-line-background-color* "#2b303b")
(setf *mode-line-foreground-color* "#c0c5ce")
(setf *mode-line-border-color* "#d08770")

(set-msg-border-width 1)
(setf *maxsize-border-width* 1)
(setf *transient-border-width* 1)
(setf *normal-border-width* 1)
(setf *maxsize-border-width* 1)
(setf *normal-border-width* 1)

(setf *window-border-style* :thin)

(set-font "Firacode 14")
