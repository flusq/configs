;;; Org
;;org-settings
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode ))
(setq org-log-done t)

(add-hook 'org-mode-hook #'visual-line-mode)

;;org-bullets 
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;;;

;;pdf-tools
(pdf-loader-install t t)

;;emmet-mode
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)

;;telega.el
(add-to-list 'load-path "~/software/telega.el")
(require 'telega)
(setq telega-accounts (list
                       (list "i" 'telega-database-dir telega-database-dir)
                       (list "l" 'telega-database-dir
                             (expand-file-name "l" telega-database-dir))))

(setq telega-root-default-view-function 'telega-view-two-lines)
(setq telega-emoji-company-backend 'telega-company-emoji)
(setq telega-completing-read-function 'ivy-completing-read)

(defun my-telega-chat-mode ()
  (set (make-local-variable 'company-backends)
       (append (list telega-emoji-company-backend
                   'telega-company-username
                   'telega-company-hashtag)
             (when (telega-chat-bot-p telega-chatbuf--chat)
               '(telega-company-botcmd))))
  (company-mode 1))

(add-hook 'telega-chat-mode-hook 'my-telega-chat-mode)

;;; Lisp
(setq inferior-lisp-program "/home/runner/.guix-profile/bin/sbcl")

;;sly
(add-hook 'sly-mode-hook 'company-mode)
(add-hook 'sly-mode-hook 'smartparens-mode)

(add-hook 'smartparens-mode-hook
          (lambda () (turn-on-show-smartparens-mode)))

(with-eval-after-load 'sly
  (setq sly-lisp-implementations
        '((sbcl  ("sbcl"))
          (ecl   ("ecl"))
          (ccl   ("ccl"))
          (clisp ("clisp"))
          (abcl  ("abcl")))))
;;;

;reverse-im
(reverse-im-add-input-method "russian-computer")
(reverse-im-mode t)

;;tramp
(setq tramp-default-method "ssh")
(setq tramp-terminal-type "tramp")


;;python
(elpy-enable)
(setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
(add-hook 'elpy-mode-hook 'flycheck-mode)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;;tab-bar
(tab-new)
(tab-close-other)
(dotimes (repeat 2) (tab-new))

(toggle-tab-bar-mode-from-frame)
(tool-bar-mode -1)

;;ivy
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-auto-select-single-candidate t)

;;;Mail
(setq send-mail-function 'sendmail-send-it
      sendmail-program  (executable-find "msmtp")
      mail-specify-envelope-from t
      message-sendmail-envelope-from 'header
      mail-envelope-from 'header)

;;notmuch
;(use-package notmuch
;  :ensure t
;  :defer t)
;;;

;; Repos
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
