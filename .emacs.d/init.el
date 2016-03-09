;;; konfigurasi awal package

(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			("marmalade" . "https://marmalade-repo.org/packages/")
			("melpa" . "https://melpa.org/packages/")
			("org" . "http://orgmode.org/elpa/")))

(package-initialize)

;;; setting nama dan email
;;

(setq user-full-name "Andika Demas Riyandi"
      user-mail.address "andika.riyan@gmail.com")

;;; install "use-package" apabila belum di install
;;; 


;;; kumpulan theme
;;



;;; fungsi open file as root
;;

(defadvice ido-find-file (after find-file-sudo activate)
  "Mencari file sebagai root jika diperlukan"
  (unless (and buffer-file-name
	       (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

;;; kumpulan mode yang dibutuhkan
;;

(require 'nix-mode)
(require 'haskell-mode)
(require 'org)
(require 'nixos-options)
(require 'helm-mode)
(require 'haskell-interactive-mode)
(require 'haskell-process)
(require 'flycheck)

(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(helm-mode 1)


;;; kumpulan keybinding

(global-set-key (kbd "C-c C-S-n") 'helm-nixos-options)


;;; kumpulan penambahan list

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-nixos-options)
  (add-to-list 'company-backends 'company-ghc)
  (add-to-list 'company-backends 'company-ghci)
  (add-to-list 'company-backends 'company-cabal))

;;; flychek dengan nix

(setq flycheck-command-wrapper-function
      (lambda (command) (apply 'nix-shell-command (nix-current-sandbox) command))
      flycheck-executable-find
      (lambda (cmd) (nix-executable-find (nix-current-sandbox) cmd)))

;;; haskell mode dengan nix

(setq haskell-process-wrapper-function
      (lambda (args) (apply 'nix-shell-command (nix-current-sandbox) args)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(haskell-process-type (quote stack-ghci))
 '(inhibit-startup-screen t)
 '(initial-scratch-message
   ";; Welcome Andika D. Riyandi...
;; C-x C-f to create or find file
;; ido-find-file to open root type file

"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;; Haskell


(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda() (ghc-init)))
