;; cal-dominican.el   -*-Emacs-Lisp-*-

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
; - Dominican Lectionary
;   <url:http://www.op.org/domcentral/life/optexts.htm>

; - Dominican Ordo -- 2000
;   <url:http://www.op.org/domcentral/life/00ordo.htm>

; - Dominican Ordo -- 1999
;   <url:http://www.op.org/domcentral/life/99ordo.htm>

; - Dominican Ordo -- 1998
;   <url:http://www.op.org/domcentral/life/98ordo.htm>


(defvar dominican-01-04 '((name . "Saint Zedíslava Berkiana, OP (d)")
                          (type . "Optional Memorial")
                          (color . "White")
                          (rank . 12)))

(defvar dominican-01-07 '((name . "Saint Raymond of Penyafort, Priest (d)")
                          (type . "Memorial")
                          (color . "White")
                          (rank . 11)))

(defvar dominican-01-18 '((name . "Saint Margaret of Hungary, Virgin (d)")
                          (type . "Memorial")
                          (color . "White")
                          (rank . 11)))

(defvar dominican-01-28 '((name . "Saint Thomas Aquinas, Priest and Doctor (d)")
                          (type . "Feast")
                          (color . "White")
                          (rank . 8)))

(defvar dominican-02-04 '((name . "Saint Catherine de Ricci, Virgin (d)")
                          (type . "Memorial")
                          (color . "White")
                          (rank . 11)))

(defvar dominican-02-07 '((name . "Anniversary of Deceased Parents (d)")
                          (type . "Memorial")
                          (color . "White/Violet")
                          (rank . 11)))

(defvar dominican-02-12 '((name . "Blessed Reginald, Priest (d)")
                          (type . "Optional Memorial")
                          (color . "White")
                          (rank . 12)))

(defvar dominican-02-13 '((name . "Blessed Jordan of Saxony, Priest (d)")
                          (type . "Memorial")
                          (color . "White")
                          (rank . 11)))

(defvar dominican-04-05 '((name . "Saint Vincent Ferrer, Priest (d)")
                          (type . "Memorial")
                          (color . "White")
                          (rank . 11)))

(defvar dominican-04-20 '((name . "Saint Agnes of Monte Pulciano, Virgin (d)")
                          (type . "Memorial")
                          (color . "White")
                          (rank . 11)))

(defvar dominican-04-29 '((name . "Saint Catherine of Siena, Virgin and Doctor (d)")
                          (type . "Feast")
                          (color . "White")
                          (rank . 8)))

(defvar dominican-04-30 '((name . "Saint Pius V, Pope (d)")
                          (type . "Memorial")
                          (color . "White")
                          (rank . 11)))

(defvar dominican-05-10 '((name . "Saint Antoninus, Bishop (d)")
                          (type . "Memorial")
                          (color . "White")
                          (rank . 11)))

(defvar dominican-05-24 '((name . "Translation of our Holy Father Dominic (d)")
                          (type . "Memorial")
                          (color . "White")
                          (rank . 11)))

(defvar dominican-06-04 '((name . "Saint Peter of Verona, Martyr (d)")
                          (type . "Memorial")
                          (color . "Red")
                          (rank . 11)))

(defvar dominican-06-08 '((name . "Blessed Diana and Blessed Cecilia, Virgins (d)")
                          (type . "Optional Memorial")
                          (color . "White")
                          (rank . 12)))

(defvar dominican-06-10 '((name . "Blessed John Dominici, Bishop (d)")
                          (type . "Optional Memorial")
                          (color . "White")
                          (rank . 12)))

(defvar dominican-07-09 '((name . "Saint John of Cologne, Priest, and his Companions, Martyrs (d)")
                          (type . "Memorial")
                          (color . "Red")
                          (rank . 11)))

(defvar dominican-07-17 '((name . "Blessed Ceslaus, Priest (d)")
                          (type . "Optional Memorial")
                          (color . "White")
                          (rank . 12)))

(defvar dominican-08-02 '((name . "Blessed Jane, Mother of our Holy Father Dominic (d)")
                          (type . "Optional Memorial")
                          (color . "White")
                          (rank . 12)))

(defvar dominican-08-08 '((name . "Our Holy Father Dominic, Priest (d)")
                          (type . "Solemnity")
                          (color . "White")
                          (rank . 4)))

(defvar dominican-08-17 '((name . "Saint Hyacinth, Priest (d)")
                          (type . "Memorial")
                          (color . "White")
                          (rank . 11)))

(defvar dominican-08-18 '((name . "Blessed Mannes, Priest and brother of our Holy Father Dominic (d)")
                          (type . "Optional Memorial")
                          (color . "White")
                          (rank . 12)))

(defvar dominican-08-23 '((name . "Saint Rose of Lima, Virgin (d)")
                          (type . "Memorial")
                          (color . "White")
                          (rank . 11)))

(defvar dominican-08-28 '((name . "Saint Augustine, Bishop and Doctor (d)")
                          (type . "Feast")
                          (color . "White")
                          (rank . 8)))

; "Memorial" is a guess - bw
(defvar dominican-09-05 '((name . "Anniversary of Deceased Friends and Benefactors (d)")
                          (type . "Memorial")
                          (color . "White/Violet")
                          (rank . 11)))

(defvar dominican-09-18 '((name . "Saint Juan Macias, Religious (d)")
                          (type . "Memorial")
                          (color . "White")
                          (rank . 11)))

(defvar dominican-10-04 '((name . "Our Holy Father, Saint Francis of Assisi, Deacon (d)")
                          (type . "Feast")
                          (color . "White")
                          (rank . 8)))

(defvar dominican-10-05 '((name . "Blessed Raymond of Capua, Priest (d)")
                          (type . "Optional Memorial")
                          (color . "White")
                          (rank . 12)))

(defvar dominican-10-07 '((name . "Our Lady of the Rosary (d)")
                          (type . "Feast")
                          (color . "White")
                          (rank . 8)))

(defvar dominican-10-09 '((name . "Saint Louis Bertrán, Priest (d)")
                          (type . "Memorial")
                          (color . "White")
                          (rank . 11)))

(defvar dominican-10-22 '((name . "Anniversary of the Dedication of a Church (d)")
                          (type . "Solemnity")
                          (color . "White")
                          (rank . 4)))

(defvar dominican-11-03 '((name . "Saint Martin de Porres, Religious (d)")
                          (type . "Feast")
                          (color . "White")
                          (rank . 8)))

(defvar dominican-11-06 '((name . "Blesseds Ignatius, Francis, Alphonsus and Companions, Martyrs of the East (d)")
                          (type . "Memorial")
                          (color . "Red")
                          (rank . 11)))

(defvar dominican-11-07 '((name . "All Saints of the Order of Preachers (d)")
                          (type . "Feast")
                          (color . "White")
                          (rank . 8)))
; "Memorial" is a guess - bw
(defvar dominican-11-08 '((name . "Anniversary of Deceased Brothers and Sisters of the Order (d)")
                          (type . "Memorial")
                          (color . "White/Violet")
                          (rank . 11)))

(defvar dominican-11-15 '((name . "Saint Albert the Great, Bishop and Doctor (d)")
                          (type . "Feast")
                          (color . "White")
                          (rank . 8)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; provide the package

(provide 'cal-dominican)
