(define-key global-map (kbd "C-c t") telega-prefix-map)
(define-key global-map (kbd "M-o") 'other-window)

(define-key tab-prefix-map "t" 'toggle-tab-bar-mode-from-frame)

(define-key global-map (kbd "C-w") 'backward-kill-word)
(define-key global-map (kbd "C-h") 'delete-backward-char)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map (kbd "M-i") 'imenu)
