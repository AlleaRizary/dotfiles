;;; pgdevenv-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "pgdevenv" "pgdevenv.el" (22231 728 782508
;;;;;;  778000))
;;; Generated autoloads from pgdevenv.el

(autoload 'pgdev-open-shell "pgdevenv" "\
Open a shell for given branch

\(fn BRANCH)" t nil)

(autoload 'pgdev-insert-send-input "pgdevenv" "\
Insert format string filled with args and `coming-send-input'

\(fn STRING &rest ARGS)" nil nil)

(autoload 'pgdev-insert-git-clone "pgdevenv" "\
Open a shell a clone PostgreSQL in there

\(fn)" t nil)

(autoload 'pgdev-configure-string "pgdevenv" "\
return the configure command string

\(fn)" nil nil)

(autoload 'pgdev-insert-configure "pgdevenv" "\
Insert the ./configure command in the current Shell buffer

\(fn)" t nil)

(autoload 'pgdev-insert-pgctl-start "pgdevenv" "\
Insert and execute pg_ctl -l <logfile> start

\(fn)" t nil)

(autoload 'pgdev-insert-pgctl-stop "pgdevenv" "\
Execute pg_ctl stop

\(fn)" t nil)

(autoload 'pgdev-make "pgdevenv" "\
Execute make with `pgdev-make-extra-options'

\(fn)" t nil)

(autoload 'pgdev-reinitdb "pgdevenv" "\
Execute rm -rf $PGDATA && initdb

\(fn)" t nil)

(autoload 'pgdev-install-and-restart "pgdevenv" "\
send input `make install && pg_ctl restart`

\(fn)" t nil)

(autoload 'pgdev-maintainer-clean-rebuild "pgdevenv" "\
Execute make maintaner-clean && ./configure && make install

\(fn)" t nil)

(autoload 'pgdev-debug "pgdevenv" "\
Must be run from a pgdev shell, opens gdb in another shell

\(fn)" t nil)

(autoload 'pgdev-debug-this-psql "pgdevenv" "\
Must be run while psql is already running in a pgdev shell

\(fn)" t nil)

(autoload 'pgdev-edit-config "pgdevenv" "\
Must be run from a pgdev shell, visit the postgresql.conf file

\(fn)" t nil)

;;;***

;;;### (autoloads nil "pgsql-minor-mode" "pgsql-minor-mode.el" (22231
;;;;;;  728 816508 441000))
;;; Generated autoloads from pgsql-minor-mode.el

(autoload 'pgsql-beginning-of-query "pgsql-minor-mode" "\
Move backward to the beginning of a query.

\(fn &optional DONTMOVE)" t nil)

(autoload 'pgsql-end-of-query "pgsql-minor-mode" "\
Move forward to the end of a top level query.

\(fn &optional ARG)" t nil)

(autoload 'pgsql-mark-query "pgsql-minor-mode" "\
Put mark at end of the current SQL query and point at beginning

\(fn)" t nil)

(defvar *pgsql-eval-last-branch* nil)

(autoload 'pgsql-reset-eval-branch "pgsql-minor-mode" "\
reset where to evaluate the next SQL query

\(fn)" t nil)

(autoload 'pgsql-eval-query "pgsql-minor-mode" "\
Evaluate PostgreSQL query at point in target psql buffer

\(fn &optional BRANCH)" t nil)

(autoload 'pgsql-mode "pgsql-minor-mode" "\
postgresql sql minor mode.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("pgdevenv-pkg.el") (22231 728 884115 571000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; pgdevenv-autoloads.el ends here
