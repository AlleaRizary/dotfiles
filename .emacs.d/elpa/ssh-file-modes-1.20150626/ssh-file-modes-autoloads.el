;;; ssh-file-modes-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "ssh-file-modes" "ssh-file-modes.el" (22231
;;;;;;  673 215058 932000))
;;; Generated autoloads from ssh-file-modes.el

(autoload 'ssh-authorized-keys-mode "ssh-file-modes" "\
Major mode for ssh authorized_keys files.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '(".ssh/authorized_keys2?\\'" . ssh-authorized-keys-mode))

(autoload 'ssh-known-hosts-mode "ssh-file-modes" "\
Major mode for ssh known_hosts files.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '(".ssh/known_hosts\\'" . ssh-known-hosts-mode))

(add-to-list 'auto-mode-alist '("ssh_known_hosts\\'" . ssh-known-hosts-mode))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; ssh-file-modes-autoloads.el ends here
