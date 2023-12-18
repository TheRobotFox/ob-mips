;;; ob-mips.el --- org-babel functions for mips evaluation

;; Copyright (C) your name here

;; Author: your name here
;; Keywords: literate programming, reproducible research
;; Homepage: https://orgmode.org
;; Version: 0.01

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; This file is not intended to ever be loaded by org-babel, rather it is a
;; mips for use in adding new language support to Org-babel. Good first
;; steps are to copy this file to a file named by the language you are adding,
;; and then use `query-replace' to replace all strings of "mips" in this
;; file with the name of your new language.

;; After the `query-replace' step, it is recommended to load the file and
;; register it to org-babel either via the customize menu, or by evaluating the
;; line: (add-to-list 'org-babel-load-languages '(mips . t)) where
;; `mips' should have been replaced by the name of the language you are
;; implementing (note that this applies to all occurrences of 'mips' in this
;; file).

;; After that continue by creating a simple code block that looks like e.g.
;;
;; #+begin_src mips

;; test

;; #+end_src

;; Finally you can use `edebug' to instrumentalize
;; `org-babel-expand-body:mips' and continue to evaluate the code block. You
;; try to add header keywords and change the body of the code block and
;; reevaluate the code block to observe how things get handled.

;;
;; If you have questions as to any of the portions of the file defined
;; below please look to existing language support for guidance.
;;
;; If you are planning on adding a language to org-babel we would ask
;; that if possible you fill out the FSF copyright assignment form
;; available at https://orgmode.org/request-assign-future.txt as this
;; will make it possible to include your language support in the core
;; of Org-mode, otherwise unassigned language support files can still
;; be included in the contrib/ directory of the Org-mode repository.


;;; Requirements:

;; Use this section to list the requirements of this language.  Most
;; languages will require that at least the language be installed on
;; the user's system, and the Emacs major mode relevant to the
;; language be installed as well.

;;; Code:
(require 'ob)
(require 'ob-eval)
;; possibly require modes required for your language


(defcustom org-mips-mars-path nil
  "Path to the mars executable"
  :group 'org-babel
  :version "24.1"
  :type 'string)

;; optionally define a file extension for this language
(add-to-list 'org-babel-tangle-lang-exts '("mips" . "mips"))
(add-to-list 'org-src-lang-modes '("mips" . "asm"))

;; optionally declare default header arguments for this language
(defvar org-babel-default-header-args:mips '())

;; This is the main function which is called to evaluate a code
;; block.
;;
;; This function will evaluate the body of the source code and
;; return the results as emacs-lisp depending on the value of the
;; :results header argument
;; - output means that the output to STDOUT will be captured and
;;   returned
;; - value means that the value of the last statement in the
;;   source code block will be returned
;;
;; The most common first step in this function is the expansion of the
;; PARAMS argument using `org-babel-process-params'.
;;
;; Please feel free to not implement options which aren't appropriate
;; for your language (e.g. not all languages support interactive
;; "session" evaluation).  Also you are free to define any new header
;; arguments which you feel may be useful -- all header arguments
;; specified by the user will be available in the PARAMS variable.
(defun org-babel-execute:mips (body params)
  "Execute a block of Mips code with org-babel.
This function is called by `org-babel-execute-src-block'"
  (message "executing Mips source code block")
  (let ((in-file (org-babel-temp-file "m" ".asm")))
      (with-temp-file in-file
      (insert body))
      (org-babel-eval
      (concat "mars-mips sm we nc sen "
              (org-babel-process-file-name in-file))
      "")))

;; This function should be used to assign any variables in params in
;; the context of the session environment.
(defun org-babel-prep-session:mips (session params)
  (error "Session is not supported")
  )

(defun org-babel-mips-var-to-mips (var)
  "Convert an elisp var into a string of mips source code
specifying a var of the same value."
  (format "%S" var))

(defun org-babel-mips-table-or-string (results)
  "If the results look like a table, then convert them into an
Emacs-lisp table, otherwise return the results as a string."
  (error "Table not Supported")
  )

(provide 'ob-mips)
;;; ob-mips.el ends here
