(in-package :stumpwm)


(defcommand mpc-request (&optional req) ((:rest))
  (when req
    (uiop:run-program (list* "mpc" "-q" (uiop:split-string req))))
  (send-mpd-ctrl))

(defun send-mpd-ctrl ()
  (let
      ((*timeout-wait* 3600)
       (cur-song (uiop:run-program '("mpc" "current") :output :string))
       (volume (uiop:run-program '("mpc" "volume") :output :string)))
    (message "~A~%~A~%~
             [n] next   [9] -5 vol ~%~
             [p] prev   [0] +5 vol ~%~
             [t] toggle [r] repeat" cur-song volume)))


(let ((timer nil))
  (define-interactive-keymap mpd-ctrl-map
      (:on-enter (lambda () (setf timer (run-with-timer 0.1 1 #'send-mpd-ctrl)))
       :on-exit (lambda () (cancel-timer timer)))

    ((kbd "n") "mpc-request next")
    ((kbd "p") "mpc-request prev")
    ((kbd "r") "mpc-request repeat")
    ((kbd "t") "mpc-request toggle")
    ((kbd "9") "mpc-request volume -5")
    ((kbd "0") "mpc-request volume +5")))
