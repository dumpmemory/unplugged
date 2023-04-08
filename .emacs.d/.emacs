;; LIU Xinyu
;; Started from 2007

(setq debug-on-error nil)

(setq explicit-shell-file-name "/bin/zsh")

;;==========================================
;;  start the emacsserver that listens to emacsclient
;; (server-start)

;; =======================================
;; proxy settings
;; set the use-proxy to true (t) when need proxy

(defvar use-proxy nil)
(when use-proxy
  (setq url-proxy-services
        '(("no_proxy" . "^\\(localhost\\|10.*\\)")
          ("http"  . "proxy.ip.addr:port")
          ("https" . "proxy.ip.addr:port"))))


;; uncomment the below section in case the proxy need authentication
;; ===========================================
;; (setq url-http-proxy-basic-auth-storage
;;     (list (list "proxy.com:8080"
;;                 (cons "Input your LDAP UID !"
;;                       (base64-encode-string "LOGIN:PASSWORD")))))

(defvar use-socks-proxy nil)
(when use-socks-proxy
  (setq socks-noproxy '("127.0.0.1"))
  (setq socks-server '("Default server" "127.0.0.1" 7070 5))
  (setq url-gateway-method 'socks))

(defvar my-site-lisp "~/.emacs.d/site-lisp")

;; ==========================================
;; ELPA and MELPA

(require 'package)

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(current-language-environment "UTF-8")
 '(package-selected-packages
   '(magit auto-complete graphviz-dot-mode smart-tabs-mode flyspell-popup markdown-mode flycheck haskell-mode))
 '(tab-stop-list
   '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
 '(tool-bar-mode nil))

(package-initialize)

;; =====================================
;;   Theme
(load-theme 'tango-dark t) ;;solarize-dark  ;;zenburn-dark

;; =====================================
;;   Don't use tab for indent

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Disable auto indent in Tex Mode
(add-to-list 'auto-mode-alist '("\\.tex$" . LaTeX-mode))

(defun remove-electric-indent-mode ()
  (electric-indent-local-mode 0))

(add-hook 'LaTeX-mode-hook 'remove-electric-indent-mode)
(add-hook 'plain-TeX-mode-hook 'remove-electric-indent-mode)
(add-hook 'text-mode-hook 'remove-electric-indent-mode)

;; =======================================
;;    Interactive with host OS
;; ======================================

;; clipboard between emacs and X
(when (equal system-type 'gnu/linux)
  (setq x-select-enable-clipboard t))

;; Fix a problem in Mac OS X that shell path are not sync with emacs
(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable
   to match that used by the user's shell.
   This is particularly useful under Mac OSX, where GUI apps
   are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when (equal system-type 'darwin)
  (set-exec-path-from-shell-PATH))

;; ==================================
;;    Mac OS X only: set drag-drop to open file instead of append
(when (equal system-type 'darwin)
  (global-set-key [ns-drag-file] 'ns-find-file))

;; =======================================
;; CSCOPE
;; (require 'xcscope)
;; (require 'ascope)

;; =======================================
;;   Winner Mode
;;    Support undo/redo with windows, C-c left/right
;;(when (fboundp 'winner-mode)
;;      (winner-mode 1))

;; ========================================
;;    ASpell
(setq-default ispell-program-name "aspell")
(setq ispell-list-command "list")

;; ========================================
;;    FlySpell
(flyspell-mode 1)
(define-key flyspell-mode-map (kbd "C-;") #'flyspell-popup-correct)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; =======================================
;;      Syntax check
;; (global-flycheck-mode)

;; Defines tab spacing in sgml mode (includes XML mode)
;; source: http://www.emacswiki.org/emacs/IndentingHtml
(add-hook 'sgml-mode-hook
        (lambda ()
          ;; Default indentation is usually 2 spaces, changing to 4.
          (set (make-local-variable 'sgml-basic-offset) 4)))

;; Set to C indent
(setq-default c-basic-offset 4)

;; =============================================
;; Auto completion mode
;;
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
             (concat my-site-lisp "/data/ac-dict")) ;; my own dict
(ac-config-default)
;; (setq ac-auto-start nil) ;; Uncomment this line to stop auto start

;; =================================
;; Enable the built-in CEDET
;;
;; (when (boundp 'semantic-mode)
;;   (semantic-mode 1)
;;   (global-ede-mode 1)
;;   (ede-enable-generic-projects)
;;   (global-semantic-idle-summary-mode 1))

(global-set-key [(f5)] 'speedbar)

;; =================================================
;; helper function for case insenstive sort lines
(defun sort-lines-nocase ()
  (interactive)
  (let ((sort-fold-case t))
    (call-interactively 'sort-lines)))

;; ============================================
;; auto save desktop session
(desktop-save-mode 1)

;; ============================================
;; Language and font
(set-language-environment 'UTF-8)
(set-locale-environment "UTF-8")

;; self-contained CN/Latin hybrid font settings.
;; ===============================
;; Alternative: https://github.com/tumashu/cnfonts, (or melpa cnfonts)
;;
(defun font-exists-p (font)
  (not (null (x-list-fonts font))))

(require 'cl-lib)  ;; for cl-remove-if-not, cl-find-if
(defalias 'filter 'cl-remove-if-not)
(defalias 'map 'mapcar)

;; Latin mono (fixed-width) fonts, ordered by preference
(defvar latin-mono-fonts
  (filter #'font-exists-p
          '("Monaco"   ;; Mac OS X
            "Consolas" "Courier New" ;; Windows
            "Source Code Pro" "Noto Sans Mono CJK" "Noto Mono"
            "DejaVu Sans Mono"))) ;; Linux

;; CN fonts, ordered by preference
(defvar cn-fonts
  (filter #'font-exists-p
          '("STSong" "STHeiti" "STKaiti" "STFangsong" "STXingkai"   ;; Mac OS X
            "微软雅黑" "Microsoft Yahei" "Microsoft_Yahei"
            "宋体" "SimSun" "新宋体" "NSimSun" "黑体" "SimHei"   ;; Windows
            "Noto Serif CJK SC" "Noto Sans CJK SC" "文泉驿等宽微米黑"))) ;; Linux

(defun xe-set-font (latin-fonts cn-fonts size)
  (xe--set-font latin-fonts size cn-fonts 1.0))

(defvar global-latin-font-size nil)
(defun xe--set-font (latin-fonts latin-font-size cn-fonts cn-font-scale)
  (setq face-font-rescale-alist
        (map (lambda (fnt) `(,fnt . ,cn-font-scale)) cn-fonts))
  (setq global-latin-font-size latin-font-size)
  (let* ((latin-font-family (car latin-fonts))
         (latin-font (format "%s-%s" latin-font-family latin-font-size))
         (zh-font (font-spec :family (cl-find-if #'font-exists-p cn-fonts))))
      (set-face-attribute 'default nil :font latin-font)     ;; default Latin font
      (condition-case font-error
          (progn
            (set-face-font 'italic (font-spec :family latin-font-family :slant 'italic
                                              :weight 'normal :size latin-font-size))
            (set-face-font 'bold-italic (font-spec :family latin-font-family :slant 'italic
                                                   :weight 'bold :size latin-font-size))
            (set-fontset-font t 'symbol (font-spec :family latin-font-family)))
        (error nil))
      (dolist (charset '(kana han cjk-misc bopomofo))
        (set-fontset-font t charset zh-font))))

;; deprecated:
;; (defvar latin-font-size-steps '(9 10.5 11.5 12.5 14 16 17 18 20 22))
;; (defvar cn-font-scale-alist
;;          (cond
;;           ((string-equal system-type "darwin")     ;; Mac OS X
;;            '((10.5 . 1.3) (11.5 . 1.3) (16 . 1.3) (18 . 1.25)))
;;           ((string-equal system-type "windows-nt") ;; Windows
;;            '((11.5 . 1.25) (16 . 1.25)))
;;           ((string-equal system-type "gnu/linux")  ;; Linux
;;            '((12.5 . 1.25) (14 . 1.25) (16 . 1.25) (20 . 1.25)))))

;; +/- font size
(defun zoom-frame-font (step)
  (let* ((delta (if (< global-latin-font-size 14) (* 0.5 step) step))
         (next-size (max (min (+ delta global-latin-font-size) 22) 9)))
    (xe-set-font latin-mono-fonts cn-fonts next-size)
    (message "Set font size to %.1f" next-size)))

;; Main process to set CN/Latin fonts
;; ====================================
;; Default size: 17, use M-x describe-char to see the details of char at cursor
(xe-set-font latin-mono-fonts cn-fonts 17)
(global-set-key (kbd "C--") (lambda () (interactive) (zoom-frame-font -1)))
(global-set-key (kbd "C-=") (lambda () (interactive) (zoom-frame-font  1)))

;; Some memo:
;; ===============================
;; alias in eshell:
;; stored in ~/.eshell/alias
;; example:
;;   alias ff 'find-file $1'
;;   alias ll 'ls -l $*'
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
