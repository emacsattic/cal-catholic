;; cal-catholic.el --- calendar functions for the Roman Catholic liturgical calendar

;; Copyright (C) 2000,2002 Bill White

;; Author: Bill White <billw@wolfram.com>
;; Keywords: calendar
;; Human-Keywords: calendar, diary, catholic, liturgical

;; This file is NOT a part of GNU Emacs.

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

;;; Commentary:

;; This collection of functions implements the features of calendar.el
;; and diary.el that deal with the Roman Catholic liturgical calendar.

;; Comments, corrections, and improvements should be sent to
;; 
;; Bill White
;; billw@wolfram.com
;; Wolfram Research
;; 100 Trade Center Drive
;; Champaign Illinois 61820

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Credits
;; 
;; -- Kenneth G. Bath and his ROMCAL program. See
;;    <url:http://romcal.homepage.com/index.html>
;; 
;; -- Tom McGinnis for ldate.el and the Franciscan calendar:
;; <url:http://www.andrew.cmu.edu/~tfm/romcal/romcal-source.html> and
;; for fixing the code for the second part of Ordinary Time.
;;
;; -- Daily Roman Missal, 4th ed., Socias
;; 
;; -- The Order of Prayer In the Liturgy of the Hours and Celebration
;;    of the Eucharist, 1999, 2000 and 2001 editions, Paulist Press.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Code:

(require 'calendar)

;----------------------------------------

(defun rc-current-date ()
  "Return the current date as a list (MM DD YEAR)."
  (list
   (string-to-number (format-time-string "%m"))
   (string-to-number (format-time-string "%e"))
   (string-to-number (format-time-string "%Y"))))

(defun rc-absolute-current-date ()
  "Return today's absolute date."
  (calendar-absolute-from-gregorian (rc-current-date)))

(defun rc-seasonal-variable-name (date)
  "Print name of the variable containing today's information from the
seasonal calendar. This also handles the dates for celebrations that
are not celebrated on the same date every year. This includes Trinity,
Body and Blood of Christ, Sacred Heart of Jesus, Immaculate Heart of
Mary, Christ the King, and Holy Family."
  (let ((absolute-date (calendar-absolute-from-gregorian date))
        (year (extract-calendar-year date))
        (month (extract-calendar-month date))
        (day (extract-calendar-day date)))
    (cond
; season of Chrismas, after January 1
     ((< absolute-date (rc-absolute-date-of-ordinary-time-1 date))
      (setq rc-current-season "christmas2")
      (cond
       ((= absolute-date (calendar-absolute-from-gregorian (list 1 1 year)))
        (format "%s" "mother-of-god"))
       ((= absolute-date (rc-absolute-date-of-epiphany date))
        (format "%s" "epiphany"))
; If Jan 1 is Monday or Tuesday, then Baptism is the Monday after the
; Sunday after January 1 - kbath rules
       ((and
         (or
          (string= "Sunday" (calendar-day-name (list 1 1 year)))
          (string= "Monday" (calendar-day-name (list 1 1 year))))
         (= absolute-date (calendar-dayname-on-or-before 
                           1 (+ 6 
                                (calendar-dayname-on-or-before 
                                 0 (+ 7 (calendar-absolute-from-gregorian
                                         (list 1 1 year)))))))
         (format "%s" "baptism-of-lord")))
       ((= absolute-date (calendar-dayname-on-or-before 
                          0 (calendar-absolute-from-gregorian 
                             (list 1 15 year))))
        (format "%s" "baptism-of-lord"))
       ((< absolute-date (rc-absolute-date-of-epiphany date))
        (format "%s-%s" (downcase (calendar-day-name date)) "before-epiphany"))
       (t
        (format "%s-%s" (downcase (calendar-day-name date)) "after-epiphany"))))
   ; first part of Ordinary Time
         ((< absolute-date (rc-absolute-date-of-lent date))           
	  (setq rc-current-season "ordinarytime1")
          (format "%s%03d" 
                  "ordinarytime-"
                  (1+ 
                   (- absolute-date (rc-absolute-real-date-of-ordinary-time-1 date)))))
   ; season of Lent
         ((< absolute-date (rc-absolute-date-of-holy-week date))
	  (setq rc-current-season "lent")
          (format "%s%02d" 
                  "lent-"
                  (1+ (- absolute-date (rc-absolute-date-of-lent date)))))
   ; Holy Week
         ((< absolute-date (rc-absolute-date-of-triduum date))        
	  (setq rc-current-season "holyweek")
          (format "%s%d" 
                  "holyweek-"
                  (1+ (- absolute-date (rc-absolute-date-of-holy-week date)))))
   ; Triduum
         ((< absolute-date (rc-absolute-date-of-easter date))         
	  (setq rc-current-season "triduum")
          (format "%s%d" 
                  "triduum-"
                  (1+ (- absolute-date (rc-absolute-date-of-triduum date)))))
   ; season of Easter
         ((< absolute-date (rc-absolute-date-of-ordinary-time-2 date))
	  (setq rc-current-season "easter")
          (cond 
           ((= absolute-date (rc-absolute-date-of-ascension date))      
            (format "%s" "ascension"))
           (t
            (format "%s%02d" 
                    "easter-"
                    (1+ (- absolute-date (rc-absolute-date-of-easter date)))))))
   ; second part of Ordinary Time 
   ; billw 15Dec00 - this should return something like "dec-17",
   ; "dec-18" for the final days of advent since they override the
   ; usual liturgical days.
         ((< absolute-date (rc-absolute-date-of-advent date))         
	  (setq rc-current-season "ordinarytime2")
   ; solemnities in the second part of Ordinary Time
          (cond 
           ((= absolute-date (rc-absolute-date-of-pentecost date))      
            (format "%s" "pentecost"))
           ((= absolute-date (rc-absolute-date-of-trinity-sunday date))      
            (format "%s" "trinity-sunday"))
           ((= absolute-date (rc-absolute-date-of-corpus-christi date))      
            (format "%s" "corpus-christi"))
           ((= absolute-date (rc-absolute-date-of-sacred-heart date))      
            (format "%s" "sacred-heart"))
           ((= absolute-date (rc-absolute-date-of-immaculate-heart date))      
            (format "%s" "immaculate-heart"))
           ((= absolute-date (rc-absolute-date-of-christ-the-king date))
            (format "%s" "christ-the-king"))
           (t
;;; billw 14 Sep 2002: Tom McGinnis fixed this for me!  This clause
;;; miscalculated the week of Ordinary Time when it's truncated by one
;;; week: I didn't allow for the truncation.
            (format "%s%03d"
                    "ordinarytime-"
                    (- 239           ;; There are 238 possible days of OT
                      (- (rc-absolute-date-of-advent date) absolute-date))))))
   ; season of Advent
         ((< absolute-date (rc-absolute-date-of-christmas date))
	  (setq rc-current-season "advent")
          (format "%s%02d" 
                  "advent-"
                  (1+ (- absolute-date (rc-absolute-date-of-advent date)))))
   ; handle Christmas and Holy Family:
   ; return "christmas-day", "holy-family", or "christmas-02" through "christmas-07"
         ((< absolute-date (calendar-absolute-from-gregorian (list 1 1 (1+ year))))
	  (setq rc-current-season "christmas1")
          (cond 
           ((= absolute-date (calendar-absolute-from-gregorian (list 12 25 year)))
            (format "%s" "christmas-day"))
           ((and 
             (string= "Sunday" (calendar-day-name (list 12 25 year))) 
             (= absolute-date (calendar-absolute-from-gregorian (list 12 30 year))))
            (format "%s" "holy-family"))
           ((= absolute-date (calendar-dayname-on-or-before 
                              0 (+ 6 (calendar-absolute-from-gregorian 
                                      (list 12 25 year)))))
            (format "%s" "holy-family"))
           (t
            (format "%s%02d" 
                    "christmas-"
                    (1+ (- absolute-date (rc-absolute-date-of-christmas date))))))))))

(defun rc-sanctoral-variable-name (date)
  "Return the name of a possible sanctoral calendar variable. The
calling function should check via intern-soft whether such a variable
actually exists."
  (format "rc-%02d-%02d" 
          (extract-calendar-month date) 
          (extract-calendar-day date)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Functions that calculate important dates

;; Start of Advent season

; note: calculates Advent for the given calendar year. Advent for the
; current liturgical year starts in the previous calendar year.

(defun rc-date-of-advent (date)
  "Date of first day of Advent for year in date = (mon day year)"
  (let ((year (extract-calendar-year date))
        (month (extract-calendar-month date)))
    (let ((rc-advent-date (calendar-gregorian-from-absolute
                   (calendar-dayname-on-or-before 0
                    (calendar-absolute-from-gregorian
                     (list 12 3 year))))))
      rc-advent-date)))

(defun rc-absolute-date-of-advent (date)
  "Absolute date of first day of Advent for year in date = (mon day year)"
  (calendar-absolute-from-gregorian (rc-date-of-advent date)))

;; Start of Christmas season

(defun rc-date-of-christmas (date)
  "Date of first day of Christmas for year in date = (mon day year)"
  (let ((year (extract-calendar-year date)))
    (let ((rc-christmas-date (list 12 25 year)))
      rc-christmas-date)))

(defun rc-absolute-date-of-christmas (date)
  "Absolute date of first day of Christmas for year in date = (mon day year)"
  (calendar-absolute-from-gregorian (rc-date-of-christmas date)))

;; Date of Epiphany

(defun rc-date-of-epiphany (date)
  "Date of Epiphany."
  (let ((year (extract-calendar-year date))
        (rc-epiphany-date 
         (calendar-dayname-on-or-before 
          0 (calendar-absolute-from-gregorian 
             (list 1 8 year)))))
    (calendar-gregorian-from-absolute rc-epiphany-date)))

(defun rc-absolute-date-of-epiphany (date)
  "Absolute date of Epiphany."
  (calendar-absolute-from-gregorian
   (rc-date-of-epiphany date)))

;; Start of Ordinary Time

(defun rc-date-of-ordinary-time-1 (date)
  "Returns the date (as a list (mm dd yyyy) of first day of Ordinary
Time for year in date = (mon day year). This is a Monday or a Tuesday,
the day after the Feast of the Baptism of the Lord."
  (let* ((year (extract-calendar-year date))
         (rc-ordinary-time-1-date
          (cond
           ((or
             (string= "Sunday" (calendar-day-name (list 1 1 year)))
             (string= "Monday" (calendar-day-name (list 1 1 year))))
  ; Tuesday (2) on or after (+ 6)...
            (calendar-dayname-on-or-before 
             2 (+ 6 
  ; Sunday (0) after (+ 7) date 1-1-year
                  (calendar-dayname-on-or-before 
                   0 (+ 7 (calendar-absolute-from-gregorian
                           (list 1 1 year)))))))
           (t
  ; Monday (1) on or after (+ 6) ...
            (calendar-dayname-on-or-before
             1 (+ 6
  ; Sunday (0) on or after (+ 6) date 1-9-year
                  (calendar-dayname-on-or-before
                   0 (+ 6 (calendar-absolute-from-gregorian
                           (list 1 9 year))))))))))
    (calendar-gregorian-from-absolute rc-ordinary-time-1-date)))

(defun rc-absolute-date-of-ordinary-time-1 (date)
  "Returns the absolute date of the first day of Ordinary Time for the
  year in date = (mon day year)."  
  (calendar-absolute-from-gregorian
   (rc-date-of-ordinary-time-1 date)))

(defun rc-absolute-real-date-of-ordinary-time-1 (date)
  "See docs for rc-real-date-of-ordinary-time-1."
  (calendar-absolute-from-gregorian
   (rc-real-date-of-ordinary-time-1 date)))

(defun rc-real-date-of-ordinary-time-1 (date)
  "The first actual day in Ordinary Time is Tuesday when the Feast of
the Baptism of the Lord falls on the Monday after Epiphany. When that
happens, juggle the numbers so Ordinary Time works out right."
  (let* ((year (extract-calendar-year date))
         (rc-real-ot-date
          (cond
           ((or
             (string= "Sunday" (calendar-day-name (list 1 1 year)))
             (string= "Monday" (calendar-day-name (list 1 1 year))))
            (- (rc-absolute-date-of-ordinary-time-1 date) 2))
           (t
            (- (rc-absolute-date-of-ordinary-time-1 date) 1)))))
    (calendar-gregorian-from-absolute rc-real-ot-date)))

;; Easter and related dates, including Lent, Holy Week, Triduum,
;; Easter season, Ascension, Pentecost, the resumption of Ordinary
;; Time, the summer feasts, and Christ the King.

(defun rc-absolute-date-of-easter (date)
  "Return absolute date of Easter for year in date = (mon day
year). Borrowed from Ed Reingold's calendar code."
  (let* ((year (extract-calendar-year date))
         (century (1+ (/ year 100)))
         (shifted-epact        ;; Age of moon for April 5...
          (% (+ 14 (* 11 (% year 19));;     ...by Nicaean rule
                (-           ;; ...corrected for the Gregorian century rule
                 (/ (* 3 century) 4))
                (/    ;; ...corrected for Metonic cycle inaccuracy.
                 (+ 5 (* 8 century)) 25)
                (* 30 century));;              Keeps value positive.
             30))
         (adjusted-epact       ;;  Adjust for 29.5 day month.
          (if (or (= shifted-epact 0)
                  (and (= shifted-epact 1) (< 10 (% year 19))))
              (1+ shifted-epact)
            shifted-epact))
         (paschal-moon       ;; Day after the full moon on or after March 21.
          (- (calendar-absolute-from-gregorian (list 4 19 year))
             adjusted-epact))
         (rc-absolute-easter-date (calendar-dayname-on-or-before 0 (+ paschal-moon 7))))
    rc-absolute-easter-date))

(defun rc-date-of-holy-week (date)
  "Date of Palm Sunday for year in date = (mon day year)"
  (calendar-gregorian-from-absolute (- (rc-absolute-date-of-easter date) 7)))
(defalias 'rc-date-of-palm-sunday 'rc-date-of-holy-week)

(defun rc-absolute-date-of-holy-week (date)
  "Absolute date of Palm Sunday for year in date = (mon day year)"
  (calendar-absolute-from-gregorian (rc-date-of-holy-week date)))
(defalias 'rc-absolute-date-of-palm-sunday 'rc-absolute-date-of-holy-week)

(defun rc-date-of-triduum (date)
  "Date of Holy Thursday for year in date = (mon day year)"
  (calendar-gregorian-from-absolute (- (rc-absolute-date-of-easter date) 3)))

(defun rc-absolute-date-of-triduum (date)
  "Absolute date of Holy Thursday for year in date = (mon day year)"
  (calendar-absolute-from-gregorian (rc-date-of-triduum date)))

(defun rc-date-of-lent (date)
  "Date of Ash Wednesday (first day of Lent) for year in date = (mon day year)"
  (calendar-gregorian-from-absolute (- (rc-absolute-date-of-easter date) 46)))

(defun rc-absolute-date-of-lent (date)
  "Absolute date of Ash Wednesday (first day of Lent) for year in date = (mon day year)"
  (calendar-absolute-from-gregorian (rc-date-of-lent date)))

(defun rc-date-of-ordinary-time-2 (date)
  "Date of first day of OT after Easter for year in date = (mon day
  year). This is a Sunday and is always superceded by Pentecost."
  (calendar-gregorian-from-absolute (+ (rc-absolute-date-of-easter
  date) 49)))

(defun rc-absolute-date-of-ordinary-time-2 (date)
  "Absolute date of first day of OT after Easter for year in date = (mon day year)"
  (calendar-absolute-from-gregorian (rc-date-of-ordinary-time-2 date)))

;; Ascension

(defun rc-date-of-ascension (date)
  "Date of the Solemnity of the Ascension; date = (mon day year)"
  (calendar-gregorian-from-absolute (+ (rc-absolute-date-of-easter date) 39)))

(defun rc-absolute-date-of-ascension (date)
  "Absolute date of the Solemnity of the Ascension; date = (mon day
  year)"
  (calendar-absolute-from-gregorian (rc-date-of-ascension date)))

;; Pentecost

(defun rc-date-of-pentecost (date)
  "Date of the Solemnity of Pentecost; date = (mon day year)"
  (calendar-gregorian-from-absolute (+ (rc-absolute-date-of-easter date) 49)))

(defun rc-absolute-date-of-pentecost (date)
  "Absolute date of the Solemnity of Pentecost; date = (mon day
  year)"
  (calendar-absolute-from-gregorian (rc-date-of-pentecost date)))

;; Holy Trinity

(defun rc-date-of-trinity-sunday (date)
  "Date of the Solemnity of the Most Holy Trinity; date = (mon day
  year)"
  (calendar-gregorian-from-absolute (+ (rc-absolute-date-of-easter date) 56)))

(defun rc-absolute-date-of-trinity-sunday (date)
  "Absolute date of the Solemnity of the Most Holy Trinity; date = (mon day
  year)"
  (calendar-absolute-from-gregorian (rc-date-of-trinity-sunday date)))

;; Body and Blood of Christ

(defun rc-date-of-corpus-christi (date)
  "Date of the Solemnity of the Body and Blood of Christ;
  date = (mon day year)" 
  (calendar-gregorian-from-absolute (+ (rc-absolute-date-of-easter date) 60)))

(defun rc-absolute-date-of-corpus-christi (date)
  "Absolute date of the Solemnity of the Body and Blood of Christ;
  date = (mon day year)" 
  (calendar-absolute-from-gregorian (rc-date-of-corpus-christi date)))

;; Sacred Heart

(defun rc-date-of-sacred-heart (date)
  "Date of the Solemnity of the Sacred Heart; date = (mon day year)"
  (calendar-gregorian-from-absolute (+ (rc-absolute-date-of-easter date) 68)))

(defun rc-absolute-date-of-sacred-heart (date)
  "Absolute date of the Solemnity of the Sacred Heart; date = (mon day year)"
  (calendar-absolute-from-gregorian (rc-date-of-sacred-heart date)))

;; Immaculate Heart of Mary

(defun rc-date-of-immaculate-heart (date)
  "Date of the memorial of the Immaculate Heart; date = (mon day year)"
  (calendar-gregorian-from-absolute (+ (rc-absolute-date-of-easter date) 69)))

(defun rc-absolute-date-of-immaculate-heart (date)
  "Absolute date of the memorial of the Immaculate Heart; date = (mon day year)"
  (calendar-absolute-from-gregorian (rc-date-of-immaculate-heart date)))

;; Christ the King

(defun rc-date-of-christ-the-king (date)
  "Date of the Solemnity of Christ the King; date = (mon day year)"
  (calendar-gregorian-from-absolute (- (rc-absolute-date-of-advent date) 7)))

(defun rc-absolute-date-of-christ-the-king (date)
  "Absolute date of the Solemnity of Christ the King; date = (mon day year)"
  (calendar-absolute-from-gregorian (rc-date-of-christ-the-king date)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; print information

(defun rc-print-seasonal-day-info (date)
  "Print today's info from the seasonal calendar, if any."
  (let* ((data (symbol-value (intern-soft (rc-seasonal-variable-name date)))))
    (if (rc-seasonal-variable-name date)
        (format "Celebration: %s: %s\nColor of vestments: %s\nRank: %s\n" 
                (cdr (assoc 'type  data))
                (cdr (assoc 'name  data))
                (cdr (assoc 'color data))
                (cdr (assoc 'rank  data)))
      ; this should never happen: every day has a seasonal variable name.
      nil)))

(defun rc-print-sanctoral-day-info (date)
  "Print today's info from the sanctoral calendar, if any."
  (let* ((data (symbol-value (intern-soft (rc-sanctoral-variable-name date)))))
    (if (rc-sanctoral-variable-name date)
        (format "Celebration: %s of %s\nColor of vestments: %s\nRank: %s\n" 
                (cdr (assoc 'type  data))
                (cdr (assoc 'name  data))
                (cdr (assoc 'color data))
                (cdr (assoc 'rank  data)))
      nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; other calendar code

(defun calendar-print-catholic-date ()
  "Show equivalent Catholic liturgical date for the date under the cursor."
  (interactive)
  (message "Catholic date: %s"
           (calendar-catholic-date-string (calendar-cursor-to-date t))))

(defun diary-catholic-date ()
  "Catholic liturgical date diary entry."
  (format "%s" (calendar-catholic-date-string date)))

(defun diary-catholic-variable-name ()
  "Catholic liturgical date diary entry."
  (format "%s" (calendar-catholic-variable-name date)))

(defun diary-catholic-complete-variable ()
  "Catholic liturgical date diary entry."
  (format "%s" (calendar-catholic-complete-variable date)))

;; Weekdays in Advent, the octave of Christmas, and Lent have a rank
;; of 9, which outranks the sanctoral calendar's general and proper
;; memorials and optional memorials, which have ranks 10, 11 and 12
;; respectively.

;; In order to make possible the celebration of memorials on these
;; weekdays, _General Norms for the Liturgical Year and the Calendar_
;; says that all memorials that occur on these weekdays may be
;; celebrated as optional memorials (rank 12).  On these days,
;; optional memorials are called "commemorations".

;; In the code below, this is implemented by raising the rank
;; (lowering the precedence) of these seasonal weekdays when they
;; coincide with sanctoral celebrations of rank 10, 11 or 12.

(defun calendar-catholic-date-string (&optional date)
  "String of Catholic liturgical date of Gregorian DATE.  Defaults to
today's date if DATE is not given."
  (let* ((absolute-date (calendar-absolute-from-gregorian date))
         (year (extract-calendar-year date))
         (month (extract-calendar-month date))
         (day (extract-calendar-day date))
         (seasonal-variable  (symbol-name  (intern-soft (rc-seasonal-variable-name date))))
         (sanctoral-variable (symbol-name  (intern-soft (rc-sanctoral-variable-name date))))
         (seasonal-data      (symbol-value (intern-soft seasonal-variable)))
         (sanctoral-data     (symbol-value (intern-soft sanctoral-variable))))
;; If today is the Saturday before Palm Sunday (i.e. lent-39), then
;; check to see whether today is March 18 or March 24. If so, then
;; tomorrow, Palm Sunday, is the Solemnity of St. Joseph or the
;; Solemnity of the Annunciation, respectively, and should be
;; anticipated today.
    (when (and
         (string= "lent-39" seasonal-variable)
         (= month 3)
         (cond
          ((= day 18)
           (setq seasonal-data (symbol-value (intern "rc-03-19"))))
          ((= day 24)
           (setq seasonal-data (symbol-value (intern "rc-03-25"))))))
        (setq seasonal-type  (cdr (assoc 'type seasonal-data))
              seasonal-name  (cdr (assoc 'name seasonal-data))
              seasonal-color (cdr (assoc 'color seasonal-data))
              seasonal-rank  (cdr (assoc 'rank seasonal-data))))
;; If today is the Monday or Tuesday of the Second Week of Easter
;; (easter-09 or easter-10), check to see whether St. Joseph and/or
;; Annunciation are moved to today. The 1951 Catholic Almanac implies
;; that when both are transferred, Annunciation is transferred to
;; Monday, St. Joseph to Tuesday. Otherwise, just Annunciation is
;; transferred to Monday.  

;; Annunciation is transferred when 25 March falls on or after the
;; Monday of Holy Week. Both are transferred when 25 March falls on or
;; after Easter Sunday. In other words, Annunciation is transferred
;; when Easter falls on or before March 31, and both are transferred
;; when Easter falls on or before March 25.
    (if (and
         (string= "easter-09" seasonal-variable)
         (<= (rc-absolute-date-of-easter date)
            (calendar-absolute-from-gregorian (list 3 31 year))))
        (setq seasonal-data  (symbol-value (intern "rc-03-25"))))
    (if (and
         (string= "easter-10" seasonal-variable)
         (<= (rc-absolute-date-of-easter date)
            (calendar-absolute-from-gregorian (list 3 25 year))))
        (setq seasonal-data  (symbol-value (intern "rc-03-19"))))
;; If today is Monday March 26 and the current season is Lent, then
;; Annunciation is celebrated today.  This implements the transfer of
;; Annunciation in most years.
    (if (and
	 (= month 3)
	 (= day 26)
	 (= 1 (calendar-day-of-week date))
	 (string= rc-current-season "lent"))
        (setq seasonal-data  (symbol-value (intern "rc-03-25"))))
;; ;; If today is Monday March 20 and the current season is Lent, then
;; ;; St. Joseph is celebrated today.  This implements the transfer of
;; ;; St. Joseph in most years.
    (if (and
	   (= month 3)
	   (= day 20)
	   (= 1 (calendar-day-of-week date))
	   (string= rc-current-season "lent"))
        (setq seasonal-data  (symbol-value (intern "rc-03-19"))))
;; The Solemnity of the Immaculate Conception always falls during
;; Advent and sometimes falls on a Sunday in Advent.  The Sundays of
;; Advent outrank solemnities, so in that case GNLY 60 applies and the
;; solemnity is transferred to the following Monday Dec 9, as in 2002.
;; Rule: when December 9 is a Monday, the Solemnity of the Immaculate
;; Conception is celebrated that day and overrides all lesser
;; celebrations.  I know of no greater celebrations that are
;; ordinarily celebrated on December 9, so I'll make this a general
;; rule for the universal calendar and all national and local
;; calendars.
    (if (and
	   (= month 12)
	   (= day 9)
	   (= 1 (calendar-day-of-week date)))
        (setq seasonal-data  (symbol-value (intern "rc-12-08"))))
;; December 17-24 are of rank 9 and are named "XXX of the Nth Week of
;; Advent", where XXX can be *any* dayname. I don't see a way to do
;; that via rc-seasonal-variable-name, so I'll do it here.
    (if (and
         (>= absolute-date (calendar-absolute-from-gregorian (list 12 17 year)))
         (<= absolute-date (calendar-absolute-from-gregorian (list 12 24 year)))
         (string= "Weekday" (cdr (assoc 'type seasonal-data))))
        (setcdr (assq 'rank seasonal-data) 9))
; if today has both seasonal and sanctoral data, and if the seasonal
; rank is 9 and the sanctoral rank is 10, 11, or 12
    (if (and 
         sanctoral-data
         (= 9 (cdr (assq 'rank seasonal-data)))
         (and
          (>= (cdr (assq 'rank sanctoral-data)) 10)
          (<= (cdr (assq 'rank sanctoral-data)) 12)))
   ; then reset sanctoral data so memorials can be celebrated as optional
   ; memorials.
        (progn
          (setcdr (assq 'rank seasonal-data)  13)
          (setcdr (assq 'rank sanctoral-data) 12)
          (setcdr (assq 'type sanctoral-data) "Commemoration")))
; if there is sanctoral data *and* its new values take precedence
; (have lower rank), then use it. Otherwise, use seasonal data.
    (if (and
         sanctoral-data
         (< (cdr (assq 'rank sanctoral-data)) (cdr (assq 'rank seasonal-data))))
        (format "%s: %s" (cdr (assq 'type sanctoral-data)) (cdr (assq 'name sanctoral-data)))
      (format "%s: %s" (cdr (assq 'type seasonal-data)) (cdr (assq 'name seasonal-data))))))

(defun calendar-catholic-variable-name (&optional date)
  "Variable name containing DATE's lit data. of Gregorian DATE.  Defaults to
today's date if DATE is not given."
  (let* ((absolute-date (calendar-absolute-from-gregorian date))
         (year (extract-calendar-year date))
         (month (extract-calendar-month date))
         (day (extract-calendar-day date))
         (seasonal-variable  (symbol-name  (intern-soft (rc-seasonal-variable-name date))))
         (sanctoral-variable (symbol-name  (intern-soft (rc-sanctoral-variable-name date))))
         (seasonal-data      (symbol-value (intern-soft seasonal-variable)))
         (sanctoral-data     (symbol-value (intern-soft sanctoral-variable))))
;; If today is the Saturday before Palm Sunday (i.e. lent-39), then
;; check to see whether today is March 18 or March 24. If so, then
;; tomorrow, Palm Sunday, is the Solemnity of St. Joseph or the
;; Solemnity of the Annunciation, respectively, and should be
;; anticipated today.
    (if (and
         (string= "lent-39" seasonal-variable)
         (= month 3)
         (cond
          ((= day 18)
           (setq seasonal-data (symbol-value (intern "rc-03-19"))))
          ((= day 24)
           (setq seasonal-data (symbol-value (intern "rc-03-25"))))))
        (setq seasonal-type  (cdr (assoc 'type seasonal-data))
              seasonal-name  (cdr (assoc 'name seasonal-data))
              seasonal-color (cdr (assoc 'color seasonal-data))
              seasonal-rank  (cdr (assoc 'rank seasonal-data))))
;; If today is the Monday or Tuesday of the Second Week of Easter
;; (easter-09 or easter-10), check to see whether St. Joseph and/or
;; Annunciation are moved to today. The 1951 Catholic Almanac implies
;; that when both are transferred, Annunciation is transferred to
;; Monday, St. Joseph to Tuesday. Otherwise, just Annunciation is
;; transferred to Monday.  Annunciation is transferred when 25 March
;; falls on or after the Monday of Holy Week. Both are transferred
;; when 25 March falls on or after Easter Sunday. In other words,
;; Annunciation is transferred when Easter falls on or before March
;; 31, and both are transferred when Easter falls on or before March
;; 25.
    (if (and
         (string= "easter-09" seasonal-variable)
         (<= (rc-absolute-date-of-easter date)
            (calendar-absolute-from-gregorian (list 3 31 year))))
        (setq seasonal-data  (symbol-value (intern "rc-03-25"))))
    (if (and
         (string= "easter-10" seasonal-variable)
         (<= (rc-absolute-date-of-easter date)
            (calendar-absolute-from-gregorian (list 3 25 year))))
        (setq seasonal-data  (symbol-value (intern "rc-03-19"))))
;; December 17-24 are of rank 9 and are named "XXX of the Nth Week of
;; Advent", where XXX can be *any* dayname. I don't see a way to do
;; that via rc-seasonal-variable-name, so I'll do it here.
    (if (and
         (>= absolute-date (calendar-absolute-from-gregorian (list 12 17 year)))
         (<= absolute-date (calendar-absolute-from-gregorian (list 12 24 year)))
         (string= "Weekday" (cdr (assoc 'type seasonal-data))))
        (setcdr (assq 'rank seasonal-data) 9))
; if today has both seasonal and sanctoral data, and if the seasonal
; rank is 9 and the sanctoral rank is 10, 11, or 12
    (if (and 
         sanctoral-data
         (= 9 (cdr (assq 'rank seasonal-data)))
         (and
          (>= (cdr (assq 'rank sanctoral-data)) 10)
          (<= (cdr (assq 'rank sanctoral-data)) 12)))
   ; then reset sanctoral data so memorials can be celebrated as optional
   ; memorials.
        (progn
          (setcdr (assq 'rank seasonal-data)  13)
          (setcdr (assq 'rank sanctoral-data) 12)
          (setcdr (assq 'type sanctoral-data) "Commemoration")))
; if there is sanctoral data *and* its new values take precedence
; (have lower rank), then use it. Otherwise, use seasonal data.
    (if (and
         sanctoral-data
         (< (cdr (assq 'rank sanctoral-data)) (cdr (assq 'rank seasonal-data))))
        (format "%s" sanctoral-variable)
      (format "%s" seasonal-variable))))

(defun calendar-catholic-complete-variable (&optional date)
  "Variable name containing DATE's lit data. of Gregorian DATE.  Defaults to
today's date if DATE is not given."
  (let* ((absolute-date (calendar-absolute-from-gregorian date))
         (year (extract-calendar-year date))
         (month (extract-calendar-month date))
         (day (extract-calendar-day date))
         (seasonal-variable  (symbol-name  (intern-soft (rc-seasonal-variable-name date))))
         (sanctoral-variable (symbol-name  (intern-soft (rc-sanctoral-variable-name date))))
         (seasonal-data      (symbol-value (intern-soft seasonal-variable)))
         (sanctoral-data     (symbol-value (intern-soft sanctoral-variable))))
;; If today is the Saturday before Palm Sunday (i.e. lent-39), then
;; check to see whether today is March 18 or March 24. If so, then
;; tomorrow, Palm Sunday, is the Solemnity of St. Joseph or the
;; Solemnity of the Annunciation, respectively, and should be
;; anticipated today.
    (if (and
         (string= "lent-39" seasonal-variable)
         (= month 3)
         (cond
          ((= day 18)
           (setq seasonal-data (symbol-value (intern "rc-03-19"))))
          ((= day 24)
           (setq seasonal-data (symbol-value (intern "rc-03-25"))))))
        (setq seasonal-type  (cdr (assoc 'type seasonal-data))
              seasonal-name  (cdr (assoc 'name seasonal-data))
              seasonal-color (cdr (assoc 'color seasonal-data))
              seasonal-rank  (cdr (assoc 'rank seasonal-data))))
;; If today is the Monday or Tuesday of the Second Week of Easter
;; (easter-09 or easter-10), check to see whether St. Joseph and/or
;; Annunciation are moved to today. The 1951 Catholic Almanac implies
;; that when both are transferred, Annunciation is transferred to
;; Monday, St. Joseph to Tuesday. Otherwise, just Annunciation is
;; transferred to Monday.  Annunciation is transferred when 25 March
;; falls on or after the Monday of Holy Week. Both are transferred
;; when 25 March falls on or after Easter Sunday. In other words,
;; Annunciation is transferred when Easter falls on or before March
;; 31, and both are transferred when Easter falls on or before March
;; 25.
    (if (and
         (string= "easter-09" seasonal-variable)
         (<= (rc-absolute-date-of-easter date)
            (calendar-absolute-from-gregorian (list 3 31 year))))
        (setq seasonal-data  (symbol-value (intern "rc-03-25"))))
    (if (and
         (string= "easter-10" seasonal-variable)
         (<= (rc-absolute-date-of-easter date)
            (calendar-absolute-from-gregorian (list 3 25 year))))
        (setq seasonal-data  (symbol-value (intern "rc-03-19"))))
;; December 17-24 are of rank 9 and are named "XXX of the Nth Week of
;; Advent", where XXX can be *any* dayname. I don't see a way to do
;; that via rc-seasonal-variable-name, so I'll do it here.
    (if (and
         (>= absolute-date (calendar-absolute-from-gregorian (list 12 17 year)))
         (<= absolute-date (calendar-absolute-from-gregorian (list 12 24 year)))
         (string= "Weekday" (cdr (assoc 'type seasonal-data))))
        (setcdr (assq 'rank seasonal-data) 9))
; if today has both seasonal and sanctoral data, and if the seasonal
; rank is 9 and the sanctoral rank is 10, 11, or 12
    (if (and 
         sanctoral-data
         (= 9 (cdr (assq 'rank seasonal-data)))
         (and
          (>= (cdr (assq 'rank sanctoral-data)) 10)
          (<= (cdr (assq 'rank sanctoral-data)) 12)))
   ; then reset sanctoral data so memorials can be celebrated as optional
   ; memorials.
        (progn
          (setcdr (assq 'rank seasonal-data)  13)
          (setcdr (assq 'rank sanctoral-data) 12)
          (setcdr (assq 'type sanctoral-data) "Commemoration")))
; if there is sanctoral data *and* its new values take precedence
; (have lower rank), then use it. Otherwise, use seasonal data.
    (if (and
         sanctoral-data
         (< (cdr (assq 'rank sanctoral-data)) (cdr (assq 'rank seasonal-data))))
        (format "%s%s%s%s%s%s%s%s%s%s%s%s%s" 
                "(defvar " 
                sanctoral-variable 
                " '((name . \"" 
                (cdr (assq 'name sanctoral-data)) 
                "\")\n                           (emailname . \"" 
                (cdr (assq 'emailname sanctoral-data)) 
                "\")\n                           (type . \"" 
                (cdr (assq 'type sanctoral-data)) 
                "\")\n                           (color . \"" 
                (cdr (assq 'color sanctoral-data)) 
                "\")\n                           (rank . " 
                (cdr (assq 'rank sanctoral-data)) 
                ")))")
      (format "%s%s%s%s%s%s%s%s%s%s%s%s%s" 
              "(defvar " 
              seasonal-variable 
              " '((name . \"" 
              (cdr (assq 'name seasonal-data)) 
              "\")\n                           (emailname . \"" 
              (cdr (assq 'emailname seasonal-data)) 
              "\")\n                           (type . \"" 
              (cdr (assq 'type seasonal-data)) 
              "\")\n                           (color . \"" 
              (cdr (assq 'color seasonal-data)) 
              "\")\n                           (rank . " 
              (cdr (assq 'rank seasonal-data)) 
              ")))")
)))

;; (defun diary-catholic-date ()
;;   "Catholic liturgical date diary entry."
;;   (format "%s" (calendar-catholic-date-string date)))

;; (defun diary-catholic-variable-name ()
;;   "Catholic liturgical date diary entry."
;;   (format "%s" (calendar-catholic-variable-name date)))


(defun diary-catholic-information ()
  "Daily catholic text in the diary buffer."
  (let* ((liturgical-date (calendar-catholic-variable-name (rc-current-date)))
         (filename (format "/billw/catholic/oor/master-list/%s.txt" liturgical-date)))
  (insert-file-contents filename)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; load the rest of the package

(require 'cal-sanctoral)
(require 'cal-seasonal)
;; (require 'cal-seasonal-updates)
;; (require 'cal-sanctoral-updates)
;; (require 'cal-catholic-diary.el)
;; for dioceses in the United States, uncomment the next line:
(require 'cal-particular)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; provide the package

(provide 'cal-catholic)

;;; cal-catholic.el ends here

