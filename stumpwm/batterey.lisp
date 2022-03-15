(in-package :stumpwm)

(defvar *bat0-low* nil)
(defvar *bat1-low* nil)

(defun get-bat0 ()
  (parse-integer (uiop:read-file-string "/sys/class/power_supply/BAT0/capacity")))

(defun get-bat1 ()
  (parse-integer (uiop:read-file-string "/sys/class/power_supply/BAT1/capacity")))

(defun is-battery-charging ()
  (search "Charging" (uiop:run-program "acpi -b" :output '(:string :stripped t))))

     
(defun battery-notify ()
  (let ((bat0 (get-bat0))
        (bat1 (get-bat1))
        (*message-window-gravity* :top)
        (*timeout-wait* 3600)
        (*message-window-padding* 10)
        (*message-window-y-padding* 10))
    (cond
      ((is-battery-charging)
       (if (and *bat0-low* (> bat0 10))
           (setf *bat0-low* nil))
       (if (and *bat1-low* (> bat1 10))
           (setf *bat1-low* nil)))
      
      ((< bat0 10)
       (when (not *bat0-low*)
         (message "Bats is low")
         (setf *bat0-low* t)))
      
      ((< bat1 10)
       (when (not *bat1-low*)
         (message "Bat1 is low")
         (setf *bat1-low* t))))))

(defvar *battery-timer* (run-with-timer 60 60 #'battery-notify))
