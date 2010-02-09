;; cal-seasonal-updates.el   -*-Emacs-Lisp-*-

;; Copyright (C) 2002 Bill White


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


(defvar christ-the-king '((name . "Christ the King")
                          (emailname . "the Solemnity of Christ the King")
                          (type . "Solemnity")
                          (color . "White")
                          (rank . 3)
                          (reading-2000 . "Dn 7:13-14, Rv 1:5-8, Jn 18:33b-37")
                          (texreading-2000 . "\textit{Dn} 7\thinspace:\thinspace13--14, \textit{Rv} 1\thinspace:\thinspace5--8, \textit{Jn} 18\thinspace:\thinspace33b--37")))


(defvar ordinarytime-212 '((name . "Monday of the Thirty-first Week of Ordinary Time")
                           (emailname . "Monday of the Thirty-first Week of Ordinary Time")
                           (type . "Weekday")
                           (color . "Green")
                           (rank . 13)
                           (reading-2000 . "Phil 2:1-4, Lk 14:12-14")
                           (texreading-2000 . "\textit{Phil} 2\thinspace:\thinspace1--4, \textit{Lk} 14\thinspace:\thinspace12--14")))

(defvar ordinarytime-213 '((name . "Tuesday of the Thirty-first Week of Ordinary Time")
                           (emailname . "Tuesday of the Thirty-first Week of Ordinary Time")
                           (type . "Weekday")
                           (color . "Green")
                           (rank . 13)
                           (reading-2000 . "Phil 2:5-11, Lk 14:15-24")
                           (texreading-2000 . "\textit{Phil} 2\thinspace:\thinspace5--11, \textit{Lk} 14\thinspace:\thinspace15--24")))

(defvar ordinarytime-214 '((name . "Wednesday of the Thirty-first Week of Ordinary Time")
                           (emailname . "Wednesday of the Thirty-first Week of Ordinary Time")
                           (type . "Weekday")
                           (color . "Green")
                           (rank . 13)
                           (reading-2000 . "Phil 2:12-18, Lk 14:25-33")
                           (texreading-2000 . "\textit{Phil} 2\thinspace:\thinspace12--18, \textit{Lk} 14\thinspace:\thinspace25--33")))

(defvar ordinarytime-218 '((name . "Thirty-second Sunday of Ordinary Time")
                           (emailname . "the Thirty-second Sunday of Ordinary Time")
                           (type . "Sunday")
                           (color . "Green")
                           (rank . 6)
                           (reading-2000 . "1 Kgs 17:10-16, Heb 9:24-28, Mk 12:38-44 or 12:41-44")
                           (texreading-2000 . "\textit{1 Kgs} 17\thinspace:\thinspace10--16, \textit{Heb} 9\thinspace:\thinspace24--28, \textit{Mk} 12\thinspace:\thinspace38--44 or 12\thinspace:\thinspace41--44")))

(defvar ordinarytime-220 '((name . "Tuesday of the Thirty-second Week of Ordinary Time")
                           (emailname . "Tuesday of the Thirty-second Week of Ordinary Time")
                           (type . "Weekday")
                           (color . "Green")
                           (rank . 13)
                           (reading-2000 . "Ti 2:1-8, 11-14, Lk 17:7-10")
                           (texreading-2000 . "\textit{Ti} 2\thinspace:\thinspace1--8, 11--14, \textit{Lk} 17\thinspace:\thinspace7--10")))

(defvar ordinarytime-225 '((name . "Thirty-third Sunday of Ordinary Time")
                           (emailname . "the Thirty-third Sunday of Ordinary Time")
                           (type . "Sunday")
                           (color . "Green")
                           (rank . 6)
                           (reading-2000 . "Dn 12:1-3, Heb 10:11-14, 18, Mk 13:24-32")
                           (texreading-2000 . "\textit{Dn} 12\thinspace:\thinspace1--3, \textit{Heb} 10\thinspace:\thinspace11--14, 18, \textit{Mk} 13\thinspace:\thinspace24--32")))

(defvar ordinarytime-226 '((name . "Monday of the Thirty-third Week of Ordinary Time")
                           (emailname . "Monday of the Thirty-third Week of Ordinary Time")
                           (type . "Weekday")
                           (color . "Green")
                           (rank . 13)
                           (reading-2000 . "Rv 1:1-4; 2:1-5a, Lk 18:35-43")
                           (texreading-2000 . "\textit{Rv} 1\thinspace:\thinspace1--4; 2\thinspace:\thinspace1--5a, \textit{Lk} 18\thinspace:\thinspace35--43")))

(defvar ordinarytime-231 '((name . "Saturday of the Thirty-third Week of Ordinary Time")
                           (emailname . "Saturday of the Thirty-third Week of Ordinary Time")
                           (type . "Weekday")
                           (color . "Green")
                           (rank . 13)
                           (reading-2000 . "Rv 11:4-12, Lk 20:27-40")
                           (texreading-2000 . "\textit{Rv} 11\thinspace:\thinspace4--12, \textit{Lk} 20\thinspace:\thinspace27--40")))

(defvar ordinarytime-233 '((name . "Monday of the Thirty-fourth Week of Ordinary Time")
                           (emailname . "Monday of the Thirty-fourth Week of Ordinary Time")
                           (type . "Weekday")
                           (color . "Green")
                           (rank . 13)
                           (reading-2000 . "Rv 14:1-3, 4b-5, Lk 21:1-4")
                           (texreading-2000 . "\textit{Rv} 14\thinspace:\thinspace1--3, 4b--5, \textit{Lk} 21\thinspace:\thinspace1--4")))

(defvar ordinarytime-234 '((name . "Tuesday of the Thirty-fourth Week of Ordinary Time")
                           (emailname . "Tuesday of the Thirty-fourth Week of Ordinary Time")
                           (type . "Weekday")
                           (color . "Green")
                           (rank . 13)
                           (reading-2000 . "Rv 14:14-19, Lk 21:5-11")
                           (texreading-2000 . "\textit{Rv} 14\thinspace:\thinspace14--19, \textit{Lk} 21\thinspace:\thinspace5--11")))

(defvar ordinarytime-235 '((name . "Wednesday of the Thirty-fourth Week of Ordinary Time")
                           (emailname . "Wednesday of the Thirty-fourth Week of Ordinary Time")
                           (type . "Weekday")
                           (color . "Green")
                           (rank . 13)
                           (reading-2000 . "Rv 15:1-4, Lk 21:12-19")
                           (texreading-2000 . "\textit{Rv} 15\thinspace:\thinspace1--4, \textit{Lk} 21\thinspace:\thinspace12--19")))

(defvar ordinarytime-237 '((name . "Friday of the Thirty-fourth Week of Ordinary Time")
                           (emailname . "Friday of the Thirty-fourth Week of Ordinary Time")
                           (type . "Weekday")
                           (color . "Green")
                           (rank . 13)
                           (reading-2000 . "Rv 20:1-4, 11-21:2, Lk 21:29-33")
                           (texreading-2000 . "\textit{Rv} 20\thinspace:\thinspace1--4, 11--21\thinspace:\thinspace2, \textit{Lk} 21\thinspace:\thinspace29--33")))

(defvar ordinarytime-238 '((name . "Saturday of the Thirty-fourth Week of Ordinary Time")
                           (emailname . "Saturday of the Thirty-fourth Week of Ordinary Time")
                           (type . "Weekday")
                           (color . "Green")
                           (rank . 13)
                           (reading-2000 . "Rv 22:1-7, Lk 21:34-36")
                           (texreading-2000 . "\textit{Rv} 22\thinspace:\thinspace1--7, \textit{Lk} 21\thinspace:\thinspace34--36")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; provide the package

(provide 'cal-seasonal-updates)
