;; -*- Mode: emacs-lisp -*-

(setq luc-emacs-init-file load-file-name)
(setq luc-emacs-config-dir
      (file-name-directory luc-emacs-init-file))
(setq luc-elisp-dir
      (expand-file-name "elisp" luc-emacs-config-dir))
(add-to-list 'load-path luc-elisp-dir)

(setq luc-elisp-external-dir
      (expand-file-name "external" luc-elisp-dir))

; Add external project to load path
(dolist (project (directory-files luc-elisp-external-dir t "\\w+"))
  (when (file-directory-p project)
  (add-to-list 'load-path project)))

;; Derouler ligne par ligne au lieu d'une demie-page
(setq scroll-conservatively 1)

;; Enable gist mode
(require 'gist)
(setq github-user "lucb")


;; ===
;; Verifier les hooks
;;
;; Emacs-Lisp mode...
(defun my-lisp-mode-hook ()
  (define-key lisp-mode-map "\C-m" 'reindent-then-newline-and-indent)
  (define-key lisp-mode-map "\C-i" 'lisp-indent-line)
  (define-key lisp-mode-map "\C-j" 'eval-print-last-sexp))

(add-hook 'emacs-lisp-mode-hook 'my-lisp-mode-hook)

;; C++ and C mode...
(defun my-c++-mode-hook ()
  (setq tab-width 4)
  (define-key c++-mode-map "\C-m" 'reindent-then-newline-and-indent)
  (define-key c++-mode-map "\C-ce" 'c-comment-edit)
  (setq c++-auto-hungry-initial-state 'none)
  (setq c++-delete-function 'delete-char)
  (setq c++-tab-always-indent t)
  (setq indent-tabs-mode t)
  (setq c-indent-level 4)
  (setq c-continued-statement-offset 4)
  (setq c++-empty-arglist-indent 4)
  (c-set-offset 'inline-open 0)
  (c-set-offset 'inextern-lang 0)
)

(defun my-c-mode-hook ()
  (setq tab-width 4)
  (define-key c-mode-map "\C-m" 'reindent-then-newline-and-indent)
  (define-key c-mode-map "\C-ce" 'c-comment-edit)
  (setq c-auto-hungry-initial-state 'none)
  (setq c-delete-function 'delete-char)
  (setq c-tab-always-indent t)
;; BSD-ish indentation style
  (setq indent-tabs-mode t)
  (setq c-indent-level 4)
  (setq c-continued-statement-offset 'c-indent-level)
  (setq c-brace-offset -4)
  (setq c-argdecl-indent 0)
  (setq c-label-offset -4)
  (c-set-offset 'inextern-lang 0)
)

(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-hook 'c-mode-hook 'my-c-mode-hook)

(defun my-java-mode-hook ()
  "Hook for running java file"
  (setq tab-width 4)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 4)
  (setq java-basic-offset 4))

(add-hook 'java-mode-hook 'my-java-mode-hook)

;; Haskell mode
; reactivation plus tard
;(load "~/.elisp/haskell-mode/emacs/haskell-site-file")
;(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))

(add-hook 'inferior-octave-mode-hook
	  (lambda ()
	    (turn-on-font-lock)
	    (define-key inferior-octave-mode-map [up]
	      'comint-previous-input)
	    (define-key inferior-octave-mode-map [down]
              'comint-next-input)))


(load "my_functions.el")

;; Set up 'custom' system
(setq custom-file
      (expand-file-name "emacs-customizations.el" luc-emacs-config-dir))
(load custom-file)


