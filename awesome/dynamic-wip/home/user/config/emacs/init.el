(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(cursor-type 'box)
 '(custom-enabled-themes '(xresources))
 '(dashboard-startup-banner "/home/skullgamer205/.face")
 '(display-battery-mode t)
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-mode t)
 '(fringe-mode 0 nil (fringe))
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-screen t)
 '(minimap-always-recenter t)
 '(minimap-minimum-width 20)
 '(minimap-update-delay 0.1)
 '(minimap-window-location 'right)
 '(mode-line-compact 'long)
 '(package-selected-packages
   '(fzf todotxt minimap zoom markdown-mode luarocks lua-mode page-break-lines projectile all-the-icons nerd-icons dashboard dash ##))
 '(scroll-bar-mode nil)
 '(size-indication-mode t)
 '(tab-bar-auto-width t)
 '(tab-bar-close-button-show 'selected)
 '(tab-bar-format
   '(tab-bar-format-history tab-bar-format-tabs tab-bar-format-tabs-groups tab-bar-separator tab-bar-format-add-tab tab-bar-format-global))
 '(tab-bar-history-mode t)
 '(tab-bar-mode t)
 '(tab-bar-show 1)
 '(todotxt-file "/home/skullgamer205/.notes/notes/todo.txt")
 '(warning-suppress-log-types '((emacs) (emacs)))
 '(which-key-allow-evil-operators t)
 '(which-key-mode t)
 '(which-key-popup-type 'minibuffer)
 '(zoom-size '(0.618 . 0.618)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Terminess Nerd Font" :foundry "AX86" :slant normal :weight medium :height 105 :width normal))))
 '(button ((t (:underline (:color foreground-color :style wave :position nil)))))
 '(custom-button ((t (:box (:line-width (2 . 2) :style released-button) :foreground "#282828" :background "#ebdbb2"))))
 '(custom-button-mouse ((t (:box (:line-width (2 . 2) :style released-button) :foreground "#282828" :background "#ebdbb2"))))
 '(custom-button-pressed ((t (:box (:line-width (2 . 2) :style pressed-button) :foreground "#282828" :background "#ebdbb2"))))
 '(line-number-major-tick ((t (:background "grey75" :weight bold))))
 '(tab-bar ((t nil)))
 '(tab-bar-tab ((t (:inherit tab-bar))))
 '(tab-bar-tab-inactive ((t nil)))
 '(tab-line ((t (:height 0.99 :foreground "#ebdbb2" :background "#282828" :inherit tab-line-tab))))
 '(tab-line-highlight ((t (:background "white" :foreground "black" :box (:line-width (1 . 1) :style released-button)))))
 '(tab-line-tab ((t (:box (:line-width (1 . 1) :style released-button) :inherit tab-line))))
 '(tab-line-tab-current ((t (:foreground "#282828" :background "#ebdbb2" :inherit tab-line-tab))))
 '(tab-line-tab-inactive ((t (:background "#282828" :inherit tabline-tab))))
 '(tool-bar ((t (:box (:line-width (1 . 1) :style released-button) :foreground "#282828" :background "#ebdbb2")))))

;; Bootstrap
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Plug-ins:
;;(straight-use-package
;; '(nano :type git :host github :repo "rougier/nano-emacs"))
;;(require 'nano)

;; Dashboard
(straight-use-package 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-banner-logo-title "Добро пожаловать")
(setq dashboard-startup-banner "%HOME/.face")
(setq dashboard-center-content t)
(setq dashboard-navigation-cycle t)
(setq dashboard-items '((recents   . 7)
                        (bookmarks . 7)
                        (projects  . 7)
                        (registers . 7)))
(setq dashboard-item-shortcuts '((recents   . "r")
                                 (bookmarks . "m")
                                 (projects  . "p")
                                 (registers . "e")))
(setq dashboard-item-names '(("Recent Files:"               . "Недавние файлы:")
			     ("Bookmarks:"                  . "Закладки:")
			     ("Projects:"                   . "Проекты:")
			     ("Registers:"                  . "Регистры:")))
(setq dashboard-icon-type 'all-the-icons)
(dashboard-modify-heading-icons '((recents   . "file-text")
                                  (bookmarks . "book")))

;; Icons
;; All the icons
(straight-use-package 'all-the-icons)
(straight-use-package 'all-the-icons-completion)
(all-the-icons-completion-mode)

(straight-use-package 'nerd-icons)
(straight-use-package 'nerd-icons-completion)
(nerd-icons-completion-mode)

;; Dashboard
(straight-use-package 'dashboard)

;; Projectile
(straight-use-package 'projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Minimap
(straight-use-package 'minimap)
(minimap-mode)

;; Markdown
(straight-use-package 'markdown-mode)

;; ToDo
(straight-use-package 'todotxt)
(global-set-key (kbd "C-c t") 'todotxt)

;; Zoom
(straight-use-package 'zoom)

;; Tree Sitter
(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-langs)
(global-tree-sitter-mode)


;; Pulsar
(straight-use-package 'pulsar)
(setq pulsar-pulse t)
(setq pulsar-delay 0.055)
(setq pulsar-iterations 10)
(global-set-key (kbd "C-c h") 'pulsar-pulse-line)
(global-set-key (kbd "C-c l") 'pulsar-highlight-line)

;; Fuzzy
(straight-use-package 'fuzzy)

;; Popup
(straight-use-package 'popup)

;; Auto-Complete
(straight-use-package 'auto-complete)
(auto-complete-mode)
(global-set-key "\M-/" 'auto-complete)

;; FZF
(straight-use-package 'fzf)
(setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        ;; command used for `fzf-grep-*` functions
        ;; example usage for ripgrep:
        ;; fzf/grep-command "rg --no-heading -nH"
        fzf/grep-command "grep -nrH"
        ;; If nil, the fzf buffer will appear at the top of the window
        fzf/position-bottom t
        fzf/window-height 15)

;; Which Key
(straight-use-package 'which-key)
(which-key-mode)
(which-key-setup-minibuffer)

(global-set-key (kbd "C-h M") 'which-key-show-major-mode)

;; ErgoEmacs (Modern keybinds)
(straight-use-package 'ergoemacs-mode)
(setq ergoemacs-theme nil)
(setq ergoemacs-keyboard-layout "us")
(ergoemacs-mode 1)

;; exwm
;; (load-file ".config/emacs/exwm/config.el")


