;; cal-catholic-diary.el   -*-Emacs-Lisp-*-

;; Copyright (C) 2000,2002 Bill White


;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Interface with calendar/diary

;; "Catholic" menu item

(define-key calendar-mode-map [menu-bar catholic]
  (cons "Catholic" (make-sparse-keymap "Catholic")))

(defun calendar-catholic-rank (&optional date)
  "String indicating the numerical rank of the Catholic liturgical
celebration on Gregorian DATE.  Defaults to today's date if DATE is not
given."
  (let* ((seasonal-data  (symbol-value (intern-soft (rc-seasonal-variable-name date))))
         (sanctoral-data (symbol-value (intern-soft (rc-sanctoral-variable-name date))))
         (seasonal-rank  (cdr (assoc 'rank seasonal-data)))
         (sanctoral-rank (cdr (assoc 'rank sanctoral-data))))
; if there is sanctoral data, compare to seasonal. Otherwise, just use seasonal.
    (if sanctoral-data
        (if (< seasonal-rank sanctoral-rank)
            (setq data seasonal-data)
          (setq data sanctoral-data))
      (setq data seasonal-data))
    (format "%d" (cdr (assoc 'rank  data)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; List all Catholic liturgical celebrations in a 1-week period

(define-key calendar-mode-map [menu-bar catholic week]
  '("This Week" . calendar-catholic-week))

(define-key calendar-mouse-3-map [catholic-week]
  '("This Week" . calendar-catholic-week))

(define-key calendar-mode-map "cw"   'calendar-catholic-week)

(setq catholic-week-buffer "*Catholic Celebrations This Week*")

(defun calendar-catholic-week ()
  "Create a buffer with the Catholic celebrations for the current week
in the calendar window."
  (interactive)
  (message "Computing Catholic celebrations for the week...")
  (let ((m1 displayed-month)
        (y1 displayed-year)
        (m2 displayed-month)
        (y2 displayed-year))
    (increment-calendar-month m1 y1 -1)
    (increment-calendar-month m2 y2 1)
    (set-buffer (get-buffer-create catholic-dates-buffer))
    (setq buffer-read-only nil)
    (calendar-set-mode-line
     (if (= y1 y2)
         (format "Catholic celebrations from %s to %s, %d%%-"
                 (calendar-month-name m1) (calendar-month-name m2) y2)
       (format "Catholic celebrations from %s, %d to %s, %d%%-"
               (calendar-month-name m1) y1 (calendar-month-name m2) y2)))
    (erase-buffer)
    (insert
     (mapconcat
      '(lambda (x)
         (let ((date (car x))
               (celebration (car (cdr x))))
           (concat (calendar-date-string date)
                   ": "
                   (format "%s" celebration))))
      (catholic-optional-memorial-list m1 y1) "\n"))
    (goto-char (point-min))
    (set-buffer-modified-p nil)
    (setq buffer-read-only t)
    (display-buffer catholic-dates-buffer)
    (message "Computing Catholic celebrations for the week...done")))

(defun catholic-week-list (month year)
  "List of Catholic celebrations for one week starting with Gregorian
MONTH, DAY, YEAR."
  (let ((end-month month)
        (end-year year)
        (start-month month)
        (start-year year))
    (increment-calendar-month end-month end-year 3)
    (increment-calendar-month start-month start-year -1)
    (let* ((end-date (list (list end-month 1 end-year)))
           (start-date (list (list start-month 
                                   (calendar-last-day-of-month
                                    start-month start-year)
                                   start-year)))
           (day (calendar-absolute-from-gregorian (car start-date)))
           (rank (string-to-int 
                  (calendar-catholic-rank 
                   (calendar-gregorian-from-absolute day))))
           (liturgical-date 
            (list 
             (calendar-gregorian-from-absolute day) 
             (calendar-catholic-date-string (calendar-gregorian-from-absolute day))))
           (list))
      (while (calendar-date-compare (list (calendar-gregorian-from-absolute day)) end-date)
        (if (and
             (calendar-date-compare start-date 
                                    (list (calendar-gregorian-from-absolute day)))
             (>= rank 12))
            (setq list (append list (list liturgical-date))))
        (setq day (1+ day))
        (setq rank (string-to-int 
                    (calendar-catholic-rank 
                     (calendar-gregorian-from-absolute day))))
        (setq liturgical-date 
              (list 
               (calendar-gregorian-from-absolute day) 
               (calendar-catholic-date-string (calendar-gregorian-from-absolute day)))))
      list)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; List all Catholic liturgical optional memorials in a 3-month period

(define-key calendar-mode-map [menu-bar catholic optional-memorials]
  '("Optional Memorials" . calendar-catholic-optional-memorials))

(define-key calendar-mouse-3-map [catholic-optional-memorials]
  '("Optional Memorials" . calendar-catholic-optional-memorials))

(define-key calendar-mode-map "co"   'calendar-catholic-optional-memorials)

(setq catholic-optional-memorials-buffer "*Catholic Optional Memorials*")

(defun calendar-catholic-optional-memorials ()
  "Create a buffer with the Catholic optional memorials for the
current calendar window. Optional memorials have a rank of 12 or higher."
  (interactive)
  (message "Computing Catholic optional memorials...")
  (let ((m1 displayed-month)
        (y1 displayed-year)
        (m2 displayed-month)
        (y2 displayed-year))
    (increment-calendar-month m1 y1 -1)
    (increment-calendar-month m2 y2 1)
    (set-buffer (get-buffer-create catholic-dates-buffer))
    (setq buffer-read-only nil)
    (calendar-set-mode-line
     (if (= y1 y2)
         (format "Catholic optional memorials from %s to %s, %d%%-"
                 (calendar-month-name m1) (calendar-month-name m2) y2)
       (format "Catholic optional memorials from %s, %d to %s, %d%%-"
               (calendar-month-name m1) y1 (calendar-month-name m2) y2)))
    (erase-buffer)
    (insert
     (mapconcat
      '(lambda (x)
         (let ((date (car x))
               (celebration (car (cdr x))))
           (concat (calendar-date-string date)
                   ": "
                   (format "%s" celebration))))
      (catholic-optional-memorial-list m1 y1) "\n"))
    (goto-char (point-min))
    (set-buffer-modified-p nil)
    (setq buffer-read-only t)
    (display-buffer catholic-dates-buffer)
    (message "Computing Catholic memorials...done")))

(defun catholic-optional-memorial-list (month year)
  "List of Catholic optional memorials for three months starting with
Gregorian MONTH, YEAR. Feasts have a rank of 12 or higher."
  (let ((end-month month)
        (end-year year)
        (start-month month)
        (start-year year))
    (increment-calendar-month end-month end-year 3)
    (increment-calendar-month start-month start-year -1)
    (let* ((end-date (list (list end-month 1 end-year)))
           (start-date (list (list start-month 
                                   (calendar-last-day-of-month
                                    start-month start-year)
                                   start-year)))
           (day (calendar-absolute-from-gregorian (car start-date)))
           (rank (string-to-int 
                  (calendar-catholic-rank 
                   (calendar-gregorian-from-absolute day))))
           (liturgical-date 
            (list 
             (calendar-gregorian-from-absolute day) 
             (calendar-catholic-date-string (calendar-gregorian-from-absolute day))))
           (list))
      (while (calendar-date-compare (list (calendar-gregorian-from-absolute day)) end-date)
        (if (and
             (calendar-date-compare start-date 
                                    (list (calendar-gregorian-from-absolute day)))
             (>= rank 12))
            (setq list (append list (list liturgical-date))))
        (setq day (1+ day))
        (setq rank (string-to-int 
                    (calendar-catholic-rank 
                     (calendar-gregorian-from-absolute day))))
        (setq liturgical-date 
              (list 
               (calendar-gregorian-from-absolute day) 
               (calendar-catholic-date-string (calendar-gregorian-from-absolute day)))))
      list)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; List all Catholic liturgical memorials in a 3-month period

(define-key calendar-mode-map [menu-bar catholic memorials]
  '("Memorials" . calendar-catholic-memorials))

(define-key calendar-mouse-3-map [catholic-memorials]
  '("Memorials" . calendar-catholic-memorials))

(define-key calendar-mode-map "cm"   'calendar-catholic-memorials)

(setq catholic-memorials-buffer "*Catholic Memorials*")

(defun calendar-catholic-memorials ()
  "Create a buffer with the Catholic memorials for the current
calendar window. Memorials have a rank of 10 or 11."
  (interactive)
  (message "Computing Catholic memorials...")
  (let ((m1 displayed-month)
        (y1 displayed-year)
        (m2 displayed-month)
        (y2 displayed-year))
    (increment-calendar-month m1 y1 -1)
    (increment-calendar-month m2 y2 1)
    (set-buffer (get-buffer-create catholic-dates-buffer))
    (setq buffer-read-only nil)
    (calendar-set-mode-line
     (if (= y1 y2)
         (format "Catholic memorials from %s to %s, %d%%-"
                 (calendar-month-name m1) (calendar-month-name m2) y2)
       (format "Catholic memorials from %s, %d to %s, %d%%-"
               (calendar-month-name m1) y1 (calendar-month-name m2) y2)))
    (erase-buffer)
    (insert
     (mapconcat
      '(lambda (x)
         (let ((date (car x))
               (celebration (car (cdr x))))
           (concat (calendar-date-string date)
                   ": "
                   (format "%s" celebration))))
      (catholic-memorial-list m1 y1) "\n"))
    (goto-char (point-min))
    (set-buffer-modified-p nil)
    (setq buffer-read-only t)
    (display-buffer catholic-dates-buffer)
    (message "Computing Catholic memorials...done")))

(defun catholic-memorial-list (month year)
  "List of Catholic memorials for three months starting with Gregorian
MONTH, YEAR. Feasts have a rank of 10 or 11."
  (let ((end-month month)
        (end-year year)
        (start-month month)
        (start-year year))
    (increment-calendar-month end-month end-year 3)
    (increment-calendar-month start-month start-year -1)
    (let* ((end-date (list (list end-month 1 end-year)))
           (start-date (list (list start-month 
                                   (calendar-last-day-of-month
                                    start-month start-year)
                                   start-year)))
           (day (calendar-absolute-from-gregorian (car start-date)))
           (rank (string-to-int 
                  (calendar-catholic-rank 
                   (calendar-gregorian-from-absolute day))))
           (liturgical-date 
            (list 
             (calendar-gregorian-from-absolute day) 
             (calendar-catholic-date-string (calendar-gregorian-from-absolute day))))
           (list))
      (while (calendar-date-compare (list (calendar-gregorian-from-absolute day)) end-date)
        (if (and
             (calendar-date-compare start-date 
                                    (list (calendar-gregorian-from-absolute day)))
             (or (= rank 10) (= rank 11)))
            (setq list (append list (list liturgical-date))))
        (setq day (1+ day))
        (setq rank (string-to-int 
                    (calendar-catholic-rank 
                     (calendar-gregorian-from-absolute day))))
        (setq liturgical-date 
              (list 
               (calendar-gregorian-from-absolute day) 
               (calendar-catholic-date-string (calendar-gregorian-from-absolute day)))))
      list)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; List all Catholic liturgical feasts in a 3-month period

(define-key calendar-mode-map [menu-bar catholic feasts]
  '("Feasts" . calendar-catholic-feasts))

(define-key calendar-mouse-3-map [catholic-feasts]
  '("Feasts" . calendar-catholic-feasts))

(define-key calendar-mode-map "cf"   'calendar-catholic-feasts)

(setq catholic-feasts-buffer "*Catholic Feasts*")

(defun calendar-catholic-feasts ()
  "Create a buffer with the Catholic feasts for the current calendar window."
  (interactive)
  (message "Computing Catholic feasts...")
  (let ((m1 displayed-month)
        (y1 displayed-year)
        (m2 displayed-month)
        (y2 displayed-year))
    (increment-calendar-month m1 y1 -1)
    (increment-calendar-month m2 y2 1)
    (set-buffer (get-buffer-create catholic-dates-buffer))
    (setq buffer-read-only nil)
    (calendar-set-mode-line
     (if (= y1 y2)
         (format "Catholic feasts from %s to %s, %d%%-"
                 (calendar-month-name m1) (calendar-month-name m2) y2)
       (format "Catholic feasts from %s, %d to %s, %d%%-"
               (calendar-month-name m1) y1 (calendar-month-name m2) y2)))
    (erase-buffer)
    (insert
     (mapconcat
      '(lambda (x)
         (let ((date (car x))
               (celebration (car (cdr x))))
           (concat (calendar-date-string date)
                   ": "
                   (format "%s" celebration))))
      (catholic-feast-list m1 y1) "\n"))
    (goto-char (point-min))
    (set-buffer-modified-p nil)
    (setq buffer-read-only t)
    (display-buffer catholic-dates-buffer)
    (message "Computing Catholic feasts...done")))

(defun catholic-feast-list (month year)
  "List of Catholic feasts for three months starting with Gregorian
MONTH, YEAR. Feasts have a rank of 5, 6, 7, 8, or 9."
  (let ((end-month month)
        (end-year year)
        (start-month month)
        (start-year year))
    (increment-calendar-month end-month end-year 3)
    (increment-calendar-month start-month start-year -1)
    (let* ((end-date (list (list end-month 1 end-year)))
           (start-date (list (list start-month 
                                   (calendar-last-day-of-month
                                    start-month start-year)
                                   start-year)))
           (day (calendar-absolute-from-gregorian (car start-date)))
           (rank (string-to-int 
                  (calendar-catholic-rank 
                   (calendar-gregorian-from-absolute day))))
           (liturgical-date 
            (list 
             (calendar-gregorian-from-absolute day) 
             (calendar-catholic-date-string (calendar-gregorian-from-absolute day))))
           (list))
      (while (calendar-date-compare (list (calendar-gregorian-from-absolute day)) end-date)
        (if (and
             (calendar-date-compare start-date 
                                    (list (calendar-gregorian-from-absolute day)))
             (and (<= rank 9) (>= rank 5)))
            (setq list (append list (list liturgical-date))))
        (setq day (1+ day))
        (setq rank (string-to-int 
                    (calendar-catholic-rank 
                     (calendar-gregorian-from-absolute day))))
        (setq liturgical-date 
              (list 
               (calendar-gregorian-from-absolute day) 
               (calendar-catholic-date-string (calendar-gregorian-from-absolute day)))))
      list)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; List all Catholic liturgical solemnities in a 3-month period

(define-key calendar-mode-map [menu-bar catholic solemnities]
  '("Solemnities" . calendar-catholic-solemnities))

(define-key calendar-mouse-3-map [catholic-solemnities]
  '("Solemnities" . calendar-catholic-solemnities))

(define-key calendar-mode-map "cs"   'calendar-catholic-solemnities)

(setq catholic-solemnities-buffer "*Catholic Solemnities*")

(defun calendar-catholic-solemnities ()
  "Create a buffer with the Catholic solemnities for the current calendar window."
  (interactive)
  (message "Computing Catholic solemnities...")
  (let ((m1 displayed-month)
        (y1 displayed-year)
        (m2 displayed-month)
        (y2 displayed-year))
    (increment-calendar-month m1 y1 -1)
    (increment-calendar-month m2 y2 1)
    (set-buffer (get-buffer-create catholic-solemnities-buffer))
    (setq buffer-read-only nil)
    (calendar-set-mode-line
     (if (= y1 y2)
         (format "Catholic solemnities from %s to %s, %d%%-"
                 (calendar-month-name m1) (calendar-month-name m2) y2)
       (format "Catholic solemnities from %s, %d to %s, %d%%-"
               (calendar-month-name m1) y1 (calendar-month-name m2) y2)))
    (erase-buffer)
    (insert
     (mapconcat
      '(lambda (x)
         (let ((date (car x))
               (celebration (car (cdr x))))
           (concat (calendar-date-string date)
                   ": "
                   (format "%s" celebration))))
      (catholic-solemnity-list m1 y1) "\n"))
    (goto-char (point-min))
    (set-buffer-modified-p nil)
    (setq buffer-read-only t)
    (display-buffer catholic-solemnities-buffer)
    (message "Computing Catholic solemnities...done")))

(defun catholic-solemnity-list (month year)
  "List of Catholic solemnities for three months starting with
Gregorian MONTH, YEAR. Solemnities have a rank of 3 or 4."
  (let ((end-month month)
        (end-year year)
        (start-month month)
        (start-year year))
    (increment-calendar-month end-month end-year 3)
    (increment-calendar-month start-month start-year -1)
    (let* ((end-date (list (list end-month 1 end-year)))
           (start-date (list (list start-month 
                                   (calendar-last-day-of-month
                                    start-month start-year)
                                   start-year)))
           (day (calendar-absolute-from-gregorian (car start-date)))
           (rank (string-to-int 
                  (calendar-catholic-rank 
                   (calendar-gregorian-from-absolute day))))
           (liturgical-date 
            (list 
             (calendar-gregorian-from-absolute day) 
             (calendar-catholic-date-string (calendar-gregorian-from-absolute day))))
           (list))
      (while (calendar-date-compare (list (calendar-gregorian-from-absolute day)) end-date)
        (if (and
             (calendar-date-compare start-date 
                                    (list (calendar-gregorian-from-absolute day)))
             (<= rank 4))
            (setq list (append list (list liturgical-date))))
        (setq day (1+ day))
        (setq rank (string-to-int 
                    (calendar-catholic-rank 
                     (calendar-gregorian-from-absolute day))))
        (setq liturgical-date 
              (list 
               (calendar-gregorian-from-absolute day) 
               (calendar-catholic-date-string (calendar-gregorian-from-absolute day)))))
      list)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; List all Catholic liturgical dates in a 3-month period

(define-key calendar-mode-map [menu-bar catholic dates]
  '("All dates" . calendar-catholic-dates))

(define-key calendar-mouse-3-map [catholic-dates]
  '("All dates" . calendar-catholic-dates))

(define-key calendar-mode-map "cd"   'calendar-catholic-dates)

(setq catholic-dates-buffer "*Catholic Liturgical Dates*")

(defun calendar-catholic-dates ()
  "Create a buffer with all the Catholic dates for the current calendar window."
  (interactive)
  (message "Computing Catholic liturgical dates...")
  (let ((m1 displayed-month)
        (y1 displayed-year)
        (m2 displayed-month)
        (y2 displayed-year))
    (increment-calendar-month m1 y1 -1)
    (increment-calendar-month m2 y2 1)
    (set-buffer (get-buffer-create catholic-dates-buffer))
    (setq buffer-read-only nil)
    (calendar-set-mode-line
     (if (= y1 y2)
         (format "Catholic liturgical dates from %s to %s, %d%%-"
                 (calendar-month-name m1) (calendar-month-name m2) y2)
       (format "Catholic liturgical dates from %s, %d to %s, %d%%-"
               (calendar-month-name m1) y1 (calendar-month-name m2) y2)))
    (erase-buffer)
    (insert
     (mapconcat
      '(lambda (x)
         (let ((date (car x))
               (celebration (car (cdr x))))
           (concat (calendar-date-string date)
                   ": "
                   (format "%s" celebration))))
      (catholic-date-list m1 y1) "\n"))
    (goto-char (point-min))
    (set-buffer-modified-p nil)
    (setq buffer-read-only t)
    (display-buffer catholic-dates-buffer)
    (message "Computing Catholic liturgical dates...done")))

(defun catholic-date-list (month year)
  "List of all Catholic dates for three months starting with Gregorian MONTH, YEAR."
  (let ((end-month month)
        (end-year year)
        (start-month month)
        (start-year year))
    (increment-calendar-month end-month end-year 3)
    (increment-calendar-month start-month start-year -1)
    (let* ((end-date (list (list end-month 1 end-year)))
           (start-date (list (list start-month 
                                   (calendar-last-day-of-month
                                    start-month start-year)
                                   start-year)))
           (day (calendar-absolute-from-gregorian (car start-date)))
           (liturgical-date 
            (list 
             (calendar-gregorian-from-absolute day) 
             (calendar-catholic-date-string (calendar-gregorian-from-absolute day))))
           (list))
      (while (calendar-date-compare (list (calendar-gregorian-from-absolute day)) end-date)
        (if (calendar-date-compare start-date (list (calendar-gregorian-from-absolute day)))
            (setq list (append list (list liturgical-date))))
        (setq day (1+ day))
        (setq liturgical-date 
              (list 
               (calendar-gregorian-from-absolute day) 
               (calendar-catholic-date-string (calendar-gregorian-from-absolute day)))))
      list)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; List today's Catholic liturgical data in a new window.

(define-key calendar-mode-map [menu-bar catholic today]
  '("Today" . calendar-catholic-today))

(define-key calendar-mouse-3-map [catholic-today]
  '("Today" . calendar-catholic-today))

(define-key calendar-mode-map "ct"   'calendar-catholic-today)

(setq catholic-today-buffer "*Today's Catholic Liturgy*")

(defun calendar-catholic-today ()
  "Create a buffer with the Catholic liturgical data for the curent
date in the calendar window."
  (interactive)
  (message "Computing today's Catholic liturgical data...")
  (let* ((date (calendar-cursor-to-date))
        (day (extract-calendar-day date))
        (month displayed-month)
        (year displayed-year)
        (data (symbol-value (calendar-catholic-data date))))
    (set-buffer (get-buffer-create catholic-today-buffer))
    (setq buffer-read-only nil)
    (calendar-set-mode-line
     (format "Catholic liturgical data for %s %s, %d%%-" 
             (calendar-month-name month) day year))
    (erase-buffer)
    (insert
     (format "%s %s, %s\n" (calendar-month-name month) day year)
     (format "%s" (cdr (assoc 'type data)))
     (format "%s" ": ")
     (format "%s" (cdr (assoc 'name data))))
    (goto-char (point-min))
    (set-buffer-modified-p nil)
    (setq buffer-read-only t)
    (display-buffer catholic-today-buffer)
    (message "Computing today's Catholic liturgical data...done")))

(defun catholic-date-list (month year)
  "List of all Catholic dates for three months starting with Gregorian MONTH, YEAR."
  (let ((end-month month)
        (end-year year)
        (start-month month)
        (start-year year))
    (increment-calendar-month end-month end-year 3)
    (increment-calendar-month start-month start-year -1)
    (let* ((end-date (list (list end-month 1 end-year)))
           (start-date (list (list start-month 
                                   (calendar-last-day-of-month
                                    start-month start-year)
                                   start-year)))
           (day (calendar-absolute-from-gregorian (car start-date)))
           (liturgical-date 
            (list 
             (calendar-gregorian-from-absolute day) 
             (calendar-catholic-date-string (calendar-gregorian-from-absolute day))))
           (list))
      (while (calendar-date-compare (list (calendar-gregorian-from-absolute day)) end-date)
        (if (calendar-date-compare start-date (list (calendar-gregorian-from-absolute day)))
            (setq list (append list (list liturgical-date))))
        (setq day (1+ day))
        (setq liturgical-date 
              (list 
               (calendar-gregorian-from-absolute day) 
               (calendar-catholic-date-string (calendar-gregorian-from-absolute day)))))
      list)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; calendar menu stuff

(if calendar-mode-map
    nil
  (setq calendar-mode-map (make-sparse-keymap))
  (if window-system (require 'cal-menu))
  (calendar-for-loop i from 0 to 9 do
       (define-key calendar-mode-map (int-to-string i) 'digit-argument))
  (let ((l (list 'narrow-to-region 'mark-word 'mark-sexp 'mark-paragraph
                 'mark-defun 'mark-whole-buffer 'mark-page
                 'downcase-region 'upcase-region 'kill-region
                 'copy-region-as-kill 'capitalize-region 'write-region)))
    (while l
      (substitute-key-definition (car l) 'calendar-not-implemented
				 calendar-mode-map global-map)
      (setq l (cdr l))))
  (define-key calendar-mode-map "-"     'negative-argument)
  (define-key calendar-mode-map "\C-x>" 'scroll-calendar-right)
  (define-key calendar-mode-map [prior] 'scroll-calendar-right-three-months)
  (define-key calendar-mode-map "\ev"   'scroll-calendar-right-three-months)
  (define-key calendar-mode-map "\C-x<" 'scroll-calendar-left)
  (define-key calendar-mode-map [next]  'scroll-calendar-left-three-months)
  (define-key calendar-mode-map "\C-v"  'scroll-calendar-left-three-months)
  (define-key calendar-mode-map "\C-b"  'calendar-backward-day)
  (define-key calendar-mode-map "\C-p"  'calendar-backward-week)
  (define-key calendar-mode-map "\e{"   'calendar-backward-month)
  (define-key calendar-mode-map "\C-x[" 'calendar-backward-year)
  (define-key calendar-mode-map "\C-f"  'calendar-forward-day)
  (define-key calendar-mode-map "\C-n"  'calendar-forward-week)
  (define-key calendar-mode-map [left]  'calendar-backward-day)
  (define-key calendar-mode-map [up]    'calendar-backward-week)
  (define-key calendar-mode-map [right] 'calendar-forward-day)
  (define-key calendar-mode-map [down]  'calendar-forward-week)
  (define-key calendar-mode-map "\e}"   'calendar-forward-month)
  (define-key calendar-mode-map "\C-x]" 'calendar-forward-year)
  (define-key calendar-mode-map "\C-a"  'calendar-beginning-of-week)
  (define-key calendar-mode-map "\C-e"  'calendar-end-of-week)
  (define-key calendar-mode-map "\ea"   'calendar-beginning-of-month)
  (define-key calendar-mode-map "\ee"   'calendar-end-of-month)
  (define-key calendar-mode-map "\e<"   'calendar-beginning-of-year)
  (define-key calendar-mode-map "\e>"   'calendar-end-of-year)
  (define-key calendar-mode-map "\C-@"  'calendar-set-mark)
  ;; Many people are used to typing C-SPC and getting C-@.
  (define-key calendar-mode-map [?\C- ] 'calendar-set-mark)
  (define-key calendar-mode-map "\C-x\C-x" 'calendar-exchange-point-and-mark)
  (define-key calendar-mode-map "\e=" 'calendar-count-days-region)
  (define-key calendar-mode-map "gd"  'calendar-goto-date)
  (define-key calendar-mode-map "gj"  'calendar-goto-julian-date)
  (define-key calendar-mode-map "ga"  'calendar-goto-astro-day-number)
  (define-key calendar-mode-map "gh"  'calendar-goto-hebrew-date)
  (define-key calendar-mode-map "gi"  'calendar-goto-islamic-date)
  (define-key calendar-mode-map "gC"  'calendar-goto-chinese-date)
  (define-key calendar-mode-map "gk"  'calendar-goto-coptic-date)
  (define-key calendar-mode-map "ge"  'calendar-goto-ethiopic-date)
  (define-key calendar-mode-map "gp"  'calendar-goto-persian-date)
  (define-key calendar-mode-map "gc"  'calendar-goto-iso-date)
  (define-key calendar-mode-map "gf"  'calendar-goto-french-date)
  (define-key calendar-mode-map "gml"  'calendar-goto-mayan-long-count-date)
  (define-key calendar-mode-map "gmpc" 'calendar-previous-calendar-round-date)
  (define-key calendar-mode-map "gmnc" 'calendar-next-calendar-round-date)
  (define-key calendar-mode-map "gmph" 'calendar-previous-haab-date)
  (define-key calendar-mode-map "gmnh" 'calendar-next-haab-date)
  (define-key calendar-mode-map "gmpt" 'calendar-previous-tzolkin-date)
  (define-key calendar-mode-map "gmnt" 'calendar-next-tzolkin-date)
  (define-key calendar-mode-map "Aa"   'appt-add)
  (define-key calendar-mode-map "Ad"   'appt-delete)
  (define-key calendar-mode-map "S"   'calendar-sunrise-sunset)
  (define-key calendar-mode-map "M"   'calendar-phases-of-moon)
  (define-key calendar-mode-map " "   'scroll-other-window)
  (define-key calendar-mode-map "\C-c\C-l" 'redraw-calendar)
  (define-key calendar-mode-map "."   'calendar-goto-today)
  (define-key calendar-mode-map "o"   'calendar-other-month)
  (define-key calendar-mode-map "q"   'exit-calendar)
  (define-key calendar-mode-map "a"   'list-calendar-holidays)
  (define-key calendar-mode-map "h"   'calendar-cursor-holidays)
  (define-key calendar-mode-map "x"   'mark-calendar-holidays)
  (define-key calendar-mode-map "u"   'calendar-unmark)
  (define-key calendar-mode-map "m"   'mark-diary-entries)
  (define-key calendar-mode-map "d"   'view-diary-entries)
  (define-key calendar-mode-map "D"   'view-other-diary-entries)
  (define-key calendar-mode-map "s"   'show-all-diary-entries)
  (define-key calendar-mode-map "pd"  'calendar-print-day-of-year)
  (define-key calendar-mode-map "pC"  'calendar-print-chinese-date)
  (define-key calendar-mode-map "pk"  'calendar-print-coptic-date)
  (define-key calendar-mode-map "pe"  'calendar-print-ethiopic-date)
  (define-key calendar-mode-map "pp"  'calendar-print-persian-date)
  (define-key calendar-mode-map "pc"  'calendar-print-iso-date)
  (define-key calendar-mode-map "pj"  'calendar-print-julian-date)
  (define-key calendar-mode-map "pa"  'calendar-print-astro-day-number)
  (define-key calendar-mode-map "ph"  'calendar-print-hebrew-date)
  (define-key calendar-mode-map "pi"  'calendar-print-islamic-date)
  (define-key calendar-mode-map "pf"  'calendar-print-french-date)
  (define-key calendar-mode-map "pm"  'calendar-print-mayan-date)
  (define-key calendar-mode-map "po"  'calendar-print-other-dates)
  (define-key calendar-mode-map "id"  'insert-diary-entry)
  (define-key calendar-mode-map "iw"  'insert-weekly-diary-entry)
  (define-key calendar-mode-map "im"  'insert-monthly-diary-entry)
  (define-key calendar-mode-map "iy"  'insert-yearly-diary-entry)
  (define-key calendar-mode-map "ia"  'insert-anniversary-diary-entry)
  (define-key calendar-mode-map "ib"  'insert-block-diary-entry)
  (define-key calendar-mode-map "ic"  'insert-cyclic-diary-entry)
  (define-key calendar-mode-map "ihd" 'insert-hebrew-diary-entry)
  (define-key calendar-mode-map "ihm" 'insert-monthly-hebrew-diary-entry)
  (define-key calendar-mode-map "ihy" 'insert-yearly-hebrew-diary-entry)
  (define-key calendar-mode-map "iid" 'insert-islamic-diary-entry)
  (define-key calendar-mode-map "iim" 'insert-monthly-islamic-diary-entry)
  (define-key calendar-mode-map "iiy" 'insert-yearly-islamic-diary-entry)
  (define-key calendar-mode-map "?"   'calendar-goto-info-node)
  (define-key calendar-mode-map "tm" 'cal-tex-cursor-month)
  (define-key calendar-mode-map "tM" 'cal-tex-cursor-month-landscape)
  (define-key calendar-mode-map "td" 'cal-tex-cursor-day)
  (define-key calendar-mode-map "tw1" 'cal-tex-cursor-week)
  (define-key calendar-mode-map "tw2" 'cal-tex-cursor-week2)
  (define-key calendar-mode-map "tw3" 'cal-tex-cursor-week-iso)
  (define-key calendar-mode-map "tw4" 'cal-tex-cursor-week-monday)
  (define-key calendar-mode-map "tfd" 'cal-tex-cursor-filofax-daily)
  (define-key calendar-mode-map "tfw" 'cal-tex-cursor-filofax-2week)
  (define-key calendar-mode-map "tfW" 'cal-tex-cursor-filofax-week)
  (define-key calendar-mode-map "tfy" 'cal-tex-cursor-filofax-year)
  (define-key calendar-mode-map "ct"   'calendar-catholic-today)
  (define-key calendar-mode-map "cd"   'calendar-catholic-dates)
  (define-key calendar-mode-map "cs"   'calendar-catholic-solemnities)
  (define-key calendar-mode-map "cf"   'calendar-catholic-feasts)
  (define-key calendar-mode-map "cm"   'calendar-catholic-memorials)
  (define-key calendar-mode-map "co"   'calendar-catholic-optional-memorials)
  (define-key calendar-mode-map "ty" 'cal-tex-cursor-year)
  (define-key calendar-mode-map "tY" 'cal-tex-cursor-year-landscape))

(defun calendar-buffer-list ()
  "List of all calendar-related buffers."
  (let* ((diary-buffer (get-file-buffer diary-file))
         (buffers (list "*Yahrzeits*" lunar-phases-buffer holiday-buffer 
                        catholic-today-buffer 
                        catholic-dates-buffer 
                        catholic-solemnities-buffer
                        catholic-feasts-buffer
                        catholic-memorials-buffer
                        fancy-diary-buffer diary-buffer calendar-buffer
                        other-calendars-buffer))
         (buffer-list nil)
         b)
    (while buffers
      (setq b (car buffers))
      (setq b (cond ((stringp b) (get-buffer b))
                    ((bufferp b) b)
                    (t nil)))
      (if b (setq buffer-list (cons b buffer-list)))
      (setq buffers (cdr buffers)))
    buffer-list))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; provide the package

(provide 'cal-catholic-diary)
