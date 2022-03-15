(in-package :stumpwm)
(set-prefix-key (kbd "s-s"))

(defvar *exec-map* (make-sparse-keymap))

(define-key *root-map* (kbd "u") "display-battery")
(define-key *root-map* (kbd "d") "exec")
(define-key *root-map* (kbd "s") "vsplit")
(define-key *root-map* (kbd "m") "mpd-ctrl-map")


(define-key *top-map* (kbd "XF86MonBrightnessDown") "exec light -U 10" )
(define-key *top-map* (kbd "XF86MonBrightnessUp") "exec light -A 10")

(define-key *top-map* (kbd "XF86AudioMute") "volume-mute")
(define-key *top-map* (kbd "XF86AudioLowerVolume") "volume-down")
(define-key *top-map* (kbd "XF86AudioRaiseVolume") "volume-up")


(define-key *root-map* (kbd "e") '*exec-map*)


(define-key *exec-map* (kbd "t") "exec alacritty")
(defprogram-shortcut qutebrowser :map *exec-map* :key (kbd "b"))
(defprogram-shortcut emacs :map *exec-map* :key (kbd "e"))

(loop for i from 1 to 6
      for key = (format nil "s-F~d" i)
      for cmd = (format nil "gselect ~d" i)
      do (define-key *top-map* (kbd key) cmd))
