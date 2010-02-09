;; cal-benedictine.el   -*-Emacs-Lisp-*-

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

; Sources:
; 
; - Calendar of Feasts for the Benedictine Congregation
;   <url:http://www.osb.org/gen/saints/osbcal.html>
; 
; - The 1999 and 2000 Ordos for the American Cassinese Congregation
;   <url:http://www.osb.org/ordo/index.html>

(defvar benedictine-01-10 '((name . "St. Gregory of Nyssa, bishop (b)")
                            (type . "Optional Memorial")
                            (color . "White")
                            (rank . 12)))

(defvar benedictine-01-15 '((name . "St. Maurus and St. Placid, disciples of our Holy Father St. Benedict (b)")
                            (type . "Memorial")
                            (color . "White")
                            (rank . 11)))

(defvar benedictine-01-26 '((name . "St. Robert, St. Alberic and St. Stephen, abbots of Citeaux (b)")
                            (type . "Optional Memorial")
                            (color . "White")
                            (rank . 12)))

(defvar benedictine-02-10 '((name . "St. Scholastica, virgin (b)")
                            (type . "Feast")
                            (color . "White")
                            (rank . 8)))

(defvar benedictine-02-11 '((name . "St. Benedict of Aniane, abbot (b)")
                            (type . "Optional Memorial")
                            (color . "White")
                            (rank . 12)))

(defvar benedictine-03-21 '((name . "The Passing of Our Holy Father Benedict, abbot (b)")
                            (type . "Feast")
                            (color . "White")
                            (rank . 8)))

(defvar benedictine-04-23 '((name . "St. Adalbert, bishop and martyr (b)")
                            (type . "Optional Memorial")
                            (color . "Red")
                            (rank . 12)))

(defvar benedictine-05-11 '((name . "St. Odo, St. Maiolus, St. Odilo, St. Hugh and Blessed Peter the Venerable, abbots of Cluny (b)")
                            (type . "Memorial")
                            (color . "White")
                            (rank . 11)))

(defvar benedictine-05-15 '((name . "St. Pacomius, abbot (b)")
                            (type . "Optional Memorial")
                            (color . "White")
                            (rank . 12)))

(defvar benedictine-05-19 '((name . "St. Celestine, pope and hermit (b)")
                            (type . "Optional Memorial")
                            (color . "White")
                            (rank . 12)))

(defvar benedictine-07-11 '((name . "Solemnity of Our Holy Father Benedict, abbot (b)")
                            (type . "Solemnity")
                            (color . "White")
                            (rank . 4)))

(defvar benedictine-07-12 '((name . "St. John Gualberti, abbot (b)")
                            (type . "Optional Memorial")
                            (color . "White")
                            (rank . 12)))

(defvar benedictine-07-29 '((name . "St. Martha, St. Mary and St. Lazarus, hosts of the Lord (b)")
                            (type . "Memorial")
                            (color . "White")
                            (rank . 11)))

(defvar benedictine-08-19 '((name . "St. Bernard Tolomei, abbot (b)")
                            (type . "Optional Memorial")
                            (color . "White")
                            (rank . 12)))

(defvar benedictine-09-17 '((name . "St. Hildegard, virgin (b)")
                            (type . "Optional Memorial")
                            (color . "White")
                            (rank . 12)))

(defvar benedictine-11-07 '((name . "St. Willibrord, bishop (b)")
                            (type . "Optional Memorial")
                            (color . "White")
                            (rank . 12)))

(defvar benedictine-11-12 '((name . "St. Theodore of Studis, abbot (b)")
                            (type . "Optional Memorial")
                            (color . "White")
                            (rank . 12)))

(defvar benedictine-11-19 '((name . "St. Mechtild, virgin (b)")
                            (type . "Optional Memorial")
                            (color . "White")
                            (rank . 12)))

(defvar benedictine-11-26 '((name . "St. Silvester, abbot (b)")
                            (type . "Optional Memorial")
                            (color . "White")
                            (rank . 12)))

(defvar benedictine-12-05 '((name . "St. Saba, abbot (b)")
                            (type . "Optional Memorial")
                            (color . "White")
                            (rank . 12)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; provide the package

(provide 'cal-benedictine)
