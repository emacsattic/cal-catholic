;; cal-sanctoral-updates.el   -*-Emacs-Lisp-*-

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


(defvar rc-11-09 '((name . "The Dedication of the Lateran Basilica in Rome")
                   (emailname . "the Feast of the Dedication of the Lateran Basilica in Rome")
                   (type . "Feast")
                   (color . "White")
                   (rank . 7)
                   (reading-2000 . "Ez 47:1-2, 8-9, 12, 1 Cor 3:9c-11, 16-17, Jn 2:13-22")
                   (texreading-2000 . "\textit{Ez} 47\thinspace:\thinspace1--2, 8--9, 12, \textit{1 Cor} 3\thinspace:\thinspace9c--11, 16--17, \textit{Jn} 2\thinspace:\thinspace13--22")))

(defvar rc-11-10 '((name . "Saint Leo the Great, pope and doctor of the Church")
                   (emailname . "the Mem. of Leo the Great, pope and doctor of the Church")
                   (type . "Memorial")
                   (color . "White")
                   (rank . 10)
                   (reading-2000 . "Phil 3:17-4:1, Lk 16:1-8")
                   (texreading-2000 . "\textit{Phil} 3\thinspace:\thinspace17--4\thinspace:\thinspace1, \textit{Lk} 16\thinspace:\thinspace1--8")))

(defvar rc-11-11 '((name . "Saint Martin of Tours, bishop")
                   (emailname . "the Mem. of Martin of Tours, bishop")
                   (type . "Memorial")
                   (color . "White")
                   (rank . 10)
                   (reading-2000 . "Phil 4:10-19, Lk 16:9-15")
                   (texreading-2000 . "\textit{Phil} 4\thinspace:\thinspace10--19, \textit{Lk} 16\thinspace:\thinspace9--15")))


(defvar rc-11-13 '((name . "Saint Frances Xavier Cabrini, virgin")
                   (emailname . "the Mem. of Frances Xavier Cabrini, virgin")
                   (type . "Memorial")
                   (color . "White")
                   (rank . 10)
                   (reading-2000 . "Ti 1:1-9, Lk 17:1-6")
                   (texreading-2000 . "\textit{Ti} 1\thinspace:\thinspace1--9, \textit{Lk} 17\thinspace:\thinspace1--6")))


(defvar rc-11-15 '((name . "Saint Albert the Great, bishop and doctor of the Church")
                   (emailname . "the Opt. Mem. of Albert the Great, bishop and doctor of the Church")
                   (type . "Optional Memorial")
                   (color . "-")
                   (rank . 12)
                   (reading-2000 . "Ti 3:1-7, Lk 17:11-19")
                   (texreading-2000 . "\textit{Ti} 3\thinspace:\thinspace1--7, \textit{Lk} 17\thinspace:\thinspace{}11--19")))

(defvar rc-11-16 '((name . "Saint Margaret of Scotland; Saint Gertrude the Great, virgin")
                   (emailname . "the Opt. Mem. of Margaret of Scotland; Gertrude the Great, virgin")
                   (type . "Optional Memorial")
                   (color . "-")
                   (rank . 12)
                   (reading-2000 . "Phlm 7-20, Lk 17:20-25")
                   (texreading-2000 . "\textit{Phlm} 7--20, \textit{Lk} 17\thinspace{}:\thinspace{}20--25")))

(defvar rc-11-17 '((name . "Saint Elizabeth of Hungary, religious")
                   (emailname . "the Mem. of Elizabeth of Hungary, religious")
                   (type . "Memorial")
                   (color . "White")
                   (rank . 10)
                   (reading-2000 . "2 Jn 4-9, Lk 17:26-37")
                   (texreading-2000 . "\textit{2 Jn} 4--9, \textit{Lk} 17\thinspace:\thinspace26--37")))

(defvar rc-11-18 '((name . "The Dedication of the Basilicas of the Apostles Peter and Paul in Rome; Saint Rose Philippine Duchesne, religious")
                   (emailname . "the Opt. Mem. of the Dedication of the Basilicas of the Apostles Peter and Paul in Rome; Rose Philippine Duchesne, religious")
                   (type . "Optional Memorial")
                   (color . "-")
                   (rank . 12)
                   (reading-2000 . "3 Jn 5-8, Lk 18:1-8 or (for the memorial of the Dedication) Acts 28:11-16, 30-31, Mt 14:22-33")
                   (texreading-2000 . "\textit{3 Jn} 5--8, \textit{Lk} 18\thinspace:1--8 or (for the memorial of the Dedication) Acts 28\thinspace:\thinspace11--16, 30--31, \textit{Mt} 14\thinspace:\thinspace22--33")))



(defvar rc-11-21 '((name . "The Presentation of the Blessed Virgin Mary")
                   (emailname . "the Mem. of the Presentation of the Blessed Virgin Mary")
                   (type . "Memorial")
                   (color . "White")
                   (rank . 10)
                   (reading-2000 . "Rv 3:1-6, 14-22, Lk 19:1-10")
                   (texreading-2000 . "\textit{Rv} 3\thinspace:\thinspace1--6, 14--22, \textit{Lk} 19\thinspace:\thinspace1--10")))

(defvar rc-11-22 '((name . "Saint Cecilia, virgin and martyr")
                   (emailname . "the Mem. of Cecilia, virgin and martyr")
                   (type . "Memorial")
                   (color . "Red")
                   (rank . 10)
                   (reading-2000 . "Rv 4:1-11, Lk 19:11-28")
                   (texreading-2000 . "\textit{Rv} 4\thinspace:\thinspace1--11, \textit{Lk} 19\thinspace:\thinspace11--28")))

(defvar rc-11-23 '((name . "Saint Clement I, pope and martyr; Saint Columban, abbot; Blessed Miguel Agustín Pro, priest and martyr")
                   (emailname . "the Opt. Mem. of Clement I, pope and martyr; Columban, abbot; Blessed Miguel Agustín Pro, priest and martyri")
                   (type . "Optional Memorial")
                   (color . "-")
                   (rank . 12)
                   (reading-2000 . "Thanksgiving: Sir 50:22-24, 1 Cor 1:3-9, Lk 17:11-19")
                   (texreading-2000 . "Thanksgiving: \textit{Sir} 50\thinspace:\thinspace22--24, \textit{1 Cor} 1\thinspace:\thinspace3--9, \textit{Lk} 17\thinspace:\thinspace11--19")))

(defvar rc-11-24 '((name . "Saint Andrew Dung-Lac, priest and martyr, and his companions, martyrs")
                   (emailname . "the Mem. of Andrew Dung-Lac, priest and martyr, and his companions, martyrs")
                   (type . "Memorial")
                   (color . "Red")
                   (rank . 10)
                   (reading-2000 . "Rv 10:8-11, Lk 19:45-48")
                   (texreading-2000 . "\textit{Rv} 10\thinspace:\thinspace8--11, \textit{Lk} 19\thinspace:\thinspace45--48")))


(defvar rc-11-30 '((name . "Saint Andrew, apostle")
                   (emailname . "the Feast of Andrew, apostle")
                   (type . "Feast")
                   (color . "Red")
                   (rank . 7)
                   (reading-2000 . "Rom 10:9-18, Mt 4:18-22")
                   (texreading-2000 . "\textit{Rom} 10\thinspace:\thinspace9--18, \textit{Mt} 4\thinspace:\thinspace18--22")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; provide the package

(provide 'cal-sanctoral-updates)
