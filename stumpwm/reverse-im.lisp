(in-package :stumpwm)

(defvar *in-map-layout* "us")
(defvar *curent-layout* nil)
(defvar *in-map* nil)
(defvar *counter* 0)

(defun set-layout (layout)
  (uiop:run-program (format nil "xkb-switch -s ~A" layout)))

(defun in-map-hook (key key-seq cmd)
  (cond
    ((and (= 1 (length key-seq)) (symbolp cmd))
     (setf *counter* 0)
     (setf *in-map* t)
     (setf *curent-layout* (uiop:run-program "xkb-switch" :output :string))
     (set-layout *in-map-layout*))
    
    ((not cmd)
     (setf *counter* 0)
     (setf *in-map* nil)
     (when *curent-layout*
       (set-layout *curent-layout*)))))

(defun pre-command-layout-change (command)
  (incf *counter*))

(defun post-command-layout-change (command)
  (decf *counter*)
  (when (and (zerop *counter*) *curent-layout* *in-map*)
    (set-layout *curent-layout*)
    (setf *in-map* nil)))

(add-hook *key-press-hook* 'in-map-hook)
(add-hook *pre-command-hook* 'pre-command-layout-change)
(add-hook *post-command-hook* 'post-command-layout-change)
