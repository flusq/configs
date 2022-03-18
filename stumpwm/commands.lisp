(in-package :stumpwm)
(defvar screenshot-mods '(("gui" :gui) ("copy" :copy) ("save" :save)))

(defcommand show-volume () ()
  (message "Volume: ~A"
           (uiop:run-program (list "pamixer" "--get-volume") :output '(:string :stripped t))))

(defcommand volume-up () ()
  (uiop:launch-program (list "pamixer" "-i5"))
  (show-volume))

(defcommand volume-down () ()
  (uiop:launch-program (list "pamixer" "-d5"))
  (show-volume))

(defcommand volume-mute () ()
  (uiop:launch-program (list "pamixer" "-t")))


(defcommand display-battery () ()
  (message "Bat0: ~A~%Bat1: ~A" 
           (get-bat0)
           (get-bat1)))

(defcommand acpi-bat () ()
  (message "~A"
           (uiop:run-program (list "acpi" "-b") :output '(:string :stripped t))))

(defcommand neofetch () ()
  (message "~A" 
           (uiop:run-program (list "neofetch" "--stdout") :output '(:string :stripped t))))


(defcommand screenshot () ()
  (let ((mode (select-from-menu
               (current-screen)
               screenshot-mods
               "Chose mode")))
    (case (second mode)
          (:gui
           (uiop:launch-program (list "flameshot" "gui")))
          (:copy
           (uiop:launch-program (list "flameshot" "screen" "--delay" "1" "--clipboard")))
          (:save
           (let* ((file-name (read-one-line (current-screen) "File name: "))
                  (file-path (make-pathname
                              :directory '(:relative "media" "pictures" "screenshots")
                              :name file-name
                              :type "png")))
             (with-open-file (file file-path
                                   :direction :output
                                   :if-exists :supersede
                                   :if-does-not-exist :create)
                             (uiop:launch-program '("flameshot" "screen" "-r") :output file)))))))             


(defun select-file (find-directory select-string)
  (let* ((directory-files (mapcar 
                           (lambda (pathname)
                             (namestring (make-pathname :directory nil :defaults pathname)))
                           (uiop:directory-files find-directory)))
         (selected-file (select-from-menu
                         (current-screen)
                         directory-files
                         select-string)))
    (merge-pathnames
     find-directory
     (car selected-file))))

(defcommand select-wallpaper () ()
  (let* ((wallpapers-directory #p"/home/runner/media/pictures/wallpapers/")
         (selected-wallpaper-file (select-file wallpapers-directory "Select wallpeper: ")))
    (uiop:launch-program (list "feh" "--bg-fill" (namestring selected-wallpaper-file)))))

(defcommand open-notes () ()
  (let* ((wallpapers-directory #p"/home/runner/media/pictures/notes/")
         (selected-wallpaper-file (select-file wallpapers-directory "Select note: ")))
    (uiop:launch-program (list "sxiv" "" (namestring selected-wallpaper-file)))))


