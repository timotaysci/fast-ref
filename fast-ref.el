;;; fast-ref.el --- Quickly add references to your buffers -*- lexical-binding: t; -*-

;; Author:  Timothy Johnson
;; URL: https://github.com/timotaysci/fast-refs/
;; Website: www.timothyjohnson.me.uk
;; Created: 2021

;; Copyright 2021 Timothy Johnson
;; Package-Requires: ( (emacs "24.1") )
;; Version: 1.0
;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use, copy,
;; modify, merge, publish, distribute, sublicense, and/or sell copies
;; of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.


;;; Commentary:
;;Note taking during talks is hard. Presenters move fast and often do not allow for sufficient time to note down a useful reference.
;;fast-ref allows you to quickly add references into your notes file by prompting for, and auto-formatting, the important information.
;;This package currently defaults to a plaim style using org mode markdown elements - this can, of course, be customised.

;;; Code:



(defvar fast-ref-first())
(defvar fast-ref-jour())
(defvar fast-ref-yr())
(defvar fast-ref-vol())
(defvar fast-ref-pg())
(defvar fast-ref-per-cite())


(defgroup fast-ref nil
  "Fast-ref customisation."
  :group 'convenience)


(defcustom fast-ref-cite-style "plain" "Set the desired ref style for `fast-ref'." :group 'fast-ref  :type '(repeat string)) 

(defcustom fast-ref-auto-insert t "Toggle auto put into point. nil will add to kill ring."  :group 'fast-ref  :type '(repeat string))

(defcustom fast-ref-per-ref-insert nil "Toggled per citation insert option."   :group 'fast-ref :type '(repeat string)) 

(defun fast-ref-style-final()
  "Function to format reference for `fast-ref'."
  (cond
   ((string= fast-ref-cite-style "rsc") (concat fast-ref-first ", /et al./, /" fast-ref-jour "/, " fast-ref-yr ", *" fast-ref-vol "*, " fast-ref-pg "."))
   ((string= fast-ref-cite-style "acs") (concat fast-ref-first ", /et al./, /" fast-ref-jour "/, *" fast-ref-yr "*, /" fast-ref-vol "/, " fast-ref-pg "."))
   ((string= fast-ref-cite-style "plain") (concat fast-ref-first ", et al., " fast-ref-jour ", " fast-ref-yr ", " fast-ref-vol ", " fast-ref-pg "."))
   ((string= fast-ref-cite-style "user") ( concat fast-ref-first ", et al., " fast-ref-jour ", " fast-ref-yr ", " fast-ref-vol ", " fast-ref-pg ".")   )))

(defun fast-ref-first-author()
  "Gets first author for `fast-ref'."
  (setq fast-ref-first (read-string "First Author: ")))

(defun fast-ref-journal()
  "Gets journal for `fast-ref'."
  (setq fast-ref-jour (read-string "Journal: ")))

(defun fast-ref-year()
  "Gets year for `fast-ref'."
  (setq fast-ref-yr (read-string "Year: ")))

(defun fast-ref-volume()
  "Gets volume for `fast-ref'."
  (setq fast-ref-vol (read-string "Volume: ")))

(defun fast-ref-pages()
  "Gets page(s) for `fast-ref'."
  (setq fast-ref-pg (read-string "Page(s): ")))

(defun fast-ref-insert()
  "Gets user input regarding per citation insertion."
  (setq fast-ref-per-cite (yes-or-no-p "Insert? ")))

(defun fast-ref()
  "Start `fast-ref' - requests various inputs - copies to clip board."
  (interactive)
  (if fast-ref-per-ref-insert
      (progn (fast-ref-first-author) (fast-ref-journal) (fast-ref-year) (fast-ref-volume) (fast-ref-pages) (fast-ref-insert))
    (progn (fast-ref-first-author) (fast-ref-journal) (fast-ref-year) (fast-ref-volume) (fast-ref-pages)))
  (if fast-ref-per-ref-insert
        (if fast-ref-per-cite
            (insert (fast-ref-style-final))
          (progn (kill-new (fast-ref-style-final)) (message nil)))
    (if fast-ref-auto-insert
        (insert (fast-ref-style-final))
      (kill-new (fast-ref-style-final)))))

(provide 'fast-ref)

;;; fast-ref.el ends here
