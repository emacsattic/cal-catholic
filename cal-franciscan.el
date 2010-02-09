;; cal-franciscan.el   -*-Emacs-Lisp-*-

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

; Source: Tom McGinnis' list of Francisan saints, beati, and
; celebrations at
; <url:http://www.andrew.cmu.edu/~tfm/romcal/fixed.dat.franciscan>

(defvar fran-01-03 '((name . "Holy Name of Jesus (f)")
                     (type . "Memorial")
                     (color . "White")
                     (rank . 11)))

(defvar fran-01-07 '((name . "Blessed Angela of Foligno, Religious, III Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-01-12 '((name . "Blessed Bernard of Corlenone, Religious, I Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-01-14 '((name . "Blessed Odoric of Pordenone, Priest, I Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-01-16 '((name . "Berard, priest, and companions, protomartyrs, I Order (f)")
                     (type . "Memorial")
                     (color . "Red")
                     (rank . 11)))

(defvar fran-01-30 '((name . "Hyacinth of Mariscotti, Virgin, II Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-02-04 '((name . "Joseph of Leonissa, Priest, I Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-02-06 '((name . "Peter Baptist, Paul Miki and companions, Martyrs, I and III Orders (f)")
                     (type . "Memorial")
                     (color . "Red")
                     (rank . 11)))

(defvar fran-02-07 '((name . "Colette, Virgin, II Order (f)")
                     (type . "Optional Memorial")
                     (color . "White")
                     (rank . 12)))

(defvar fran-02-10 '((name . "Conrad of Piacenza, hermit, III Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-03-02 '((name . "Blessed Agnes of Prague, Virgin, II Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-03-24 '((name . "Blessed Didacus Joseph of Gadiz, Priest, I Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-04-03 '((name . "Benedict the Black, Religious, I Order (f)")
                     (type . "Memorial")
                     (color . "White")
                     (rank . 11)))

(defvar fran-04-21 '((name . "Conrad of Parzham, Religious, I Order (f)")
                     (type . "Memorial")
                     (color . "White")
                     (rank . 11)))

(defvar fran-04-23 '((name . "Blessed Giles of Assisi, Religious, I Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-04-24 '((name . "Fidelis of Sigmaringen, Priest and Martyr, I Order (f)")
                     (type . "Feast")
                     (color . "Red")
                     (rank . 8)))

(defvar fran-04-28 '((name . "Blessed Luchesius, III Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-05-09 '((name . "Catherine of Bologna, Virgin, II Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-05-11 '((name . "Ignatius of Laconi, Religious, I Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-05-16 '((name . "Margaret of Cortona, III Order (f)")
                     (type . "Memorial")
                     (color . "White")
                     (rank . 11)))

(defvar fran-05-17 '((name . "Paschal Baylon, Religious, I Order (f)")
                     (type . "Memorial")
                     (color . "White")
                     (rank . 11)))

(defvar fran-05-18 '((name . "Felix of Cantalice, Religious, I Order (f)")
                     (type . "Feast")
                     (color . "White")
                     (rank . 8)))

(defvar fran-05-20 '((name . "Bernardine of Siena, Priest, I Order (f)")
                     (type . "Feast")
                     (color . "White")
                     (rank . 8)))

(defvar fran-05-24 '((name . "Dedication of the Basilica of Saint Francis of Assisi (f)")
                     (type . "Feast")
                     (color . "White")
                     (rank . 8)))

(defvar fran-05-28 '((name . "Mary Ann of Jesus of Paredes, Virgin, III Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-05-30 '((name . "Blessed Baptista Varano, Virgin, II Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-06-12 '((name . "Blessed Jolenta, Religious, II Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-06-13 '((name . "Anthony of Padua, Priest and Doctor of the Church, I Order (f)")
                     (type . "Feast")
                     (color . "White")
                     (rank . 8)))

(defvar fran-06-30 '((name . "Blessed Raymond Lull, Martyr, III Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-07-08 '((name . "Blesseds Gregory Grassi, Bishop, and companions, Martyrs, I and III Orders (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-07-09 '((name . "Nicholas Pick, Priest, and companions, Martyrs, I Order (f)")
                     (type . "Memorial")
                     (color . "Red")
                     (rank . 11)))

(defvar fran-07-10 '((name . "Veronica Giuliani, Virgin, II Order (f)")
                     (type . "Memorial")
                     (color . "White")
                     (rank . 11)))

(defvar fran-07-12 '((name . "John Jones and John Wall, Priests and Martyrs, I Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-07-13 '((name . "Blessed Angeline of Marisciano, Religious, III Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-07-14 '((name . "Francis Solano, Priest, I Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-07-15 '((name . "Bonaventure, Bishop and Doctor of the Church, I Order (f)")
                     (type . "Feast")
                     (color . "White")
                     (rank . 8)))

(defvar fran-07-21 '((name . "Lawrence of Brindisi, Priest and Doctor of the Church, I Order (f)")
                     (type . "Feast")
                     (color . "White")
                     (rank . 8)))

(defvar fran-07-23 '((name . "Blessed Cunegunda, Religious, II Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-07-24 '((name . "Blessed Louise of Savoy, Religious, II Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-07-27 '((name . "Blessed Mary Magdalene of Matinegro, Virgin, II Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-08-02 '((name . "Our Lady of the Angels of the Portiuncula (f)")
                     (type . "Feast")
                     (color . "White")
                     (rank . 8)))

(defvar fran-08-07 '((name . "Blesseds Agathangelus and Cassian, Priests and Martyrs, I Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-08-08 '((name . "Holy Father Dominic, Priest, Founder of the Order of Preachers (f)")
                     (type . "Feast")
                     (color . "White")
                     (rank . 8)))

(defvar fran-08-11 '((name . "Clare of Assisi, Virgin, II Order (f)")
                     (type . "Feast")
                     (color . "White")
                     (rank . 8)))

(defvar fran-08-14 '((name . "Maximilian Kolbe, Priest and Martyr (f)")
                     (type . "Memorial")
                     (color . "Red")
                     (rank . 11)))

(defvar fran-08-19 '((name . "Louis, Bishop, I Order (f)")
                     (type . "Memorial")
                     (color . "White")
                     (rank . 11)))

(defvar fran-08-25 '((name . "Louis IX, king, Patron of the III Order (f)")
                     (type . "Memorial")
                     (color . "White")
                     (rank . 11)))

(defvar fran-09-01 '((name . "Blessed Beatrice of Silva, Virgin, II Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-09-02 '((name . "Blesseds John Francis Burte, Severin Girault and companions, Martyrs, I and III Orders (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-09-04 '((name . "Rose of Viterbo, Virgin, III Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-09-17 '((name . "Stigmata of Our Holy Father Francis (f)")
                     (type . "Feast")
                     (color . "White")
                     (rank . 8)))

(defvar fran-09-18 '((name . "Joseph of Cupertino, Priest, I Order (f)")
                     (type . "Feast")
                     (color . "White")
                     (rank . 8)))

(defvar fran-09-20 '((name . "Francis Mary of Camporosso, Religious, I Order (f)")
                     (type . "Memorial")
                     (color . "White")
                     (rank . 11)))

(defvar fran-09-23 '((name . "Finding of the Body of St. Clare (f); Blessed Pio of Pietrelcina, Priest, I Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-09-26 '((name . "Elzear of Sabran and Blessed Delphina, husband and wife, III Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-10-04 '((name . "Our Holy Father Francis of Assisi, Deacon, Founder of the Three Orders (f)")
                     (type . "Solemnity")
                     (color . "White")
                     (rank . 4)))

(defvar fran-10-06 '((name . "Mary Frances of the Five Wounds, Virgin, III Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-10-10 '((name . "Daniel, Priest, and companions, Martyrs, I Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-10-12 '((name . "Seraphin of Montegranaro, Religious, I Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-10-20 '((name . "Blessed James of Strepar, Bishop, I Order (f); Blessed Contardo Ferrini, III Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-10-21 '((name . "Blessed Josephine Leroux, Virgin and Martyr, II Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-10-22 '((name . "Peter of Alcantara, Priest, I Order (f)")
                     (type . "Memorial")
                     (color . "White")
                     (rank . 11)))

(defvar fran-10-23 '((name . "John of Capistrano, Priest, I Order (f)")
                     (type . "Memorial")
                     (color . "White")
                     (rank . 11)))

(defvar fran-10-26 '((name . "Blessed Bonaveture of Potenza, Priest, I Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-10-30 '((name . "Anniversary of Dedication in Consecrated Churches of the Order (f)")
                     (type . "Solemnity")
                     (color . "White")
                     (rank . 4)))

(defvar fran-11-07 '((name . "Didacus of Alcala, Religious, I Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-11-14 '((name . "Nicholas Tavelic, Priest, and companions, Martyrs, I Order (f)")
                     (type . "Memorial")
                     (color . "Red")
                     (rank . 11)))

(defvar fran-11-17 '((name . "Elizabeth of Hungary, Patroness of the III Order (f)")
                     (type . "Feast")
                     (color . "White")
                     (rank . 8)))

(defvar fran-11-18 '((name . "Blessed Salome, Virgin, II Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-11-19 '((name . "Agnes of Assisi, Virgin, II Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-11-24 '((name . "Commemoration of all the Deceased of the Seraphic Order (f)")
                     (type . "Memorial")
                     (color . "White")
                     (rank . 11)))

(defvar fran-11-26 '((name . "Leonard of Port Maurice, Priest, I Order (f)")
                     (type . "Memorial")
                     (color . "White")
                     (rank . 11)))

(defvar fran-11-27 '((name . "Blessed Francis Anthony Fasani, Priest, I Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

(defvar fran-11-28 '((name . "James of the March, Priest, I Order (f)")
                     (type . "Memorial")
                     (color . "White")
                     (rank . 11)))

(defvar fran-11-29 '((name . "All Saints of the Seraphic Order (f)")
                     (type . "Feast")
                     (color . "White")
                     (rank . 8)))

(defvar fran-12-15 '((name . "Blessed Mary Frances Schervier, Virgin, III Order (f)")
                     (type . "Optional Memorial")
                     (color . "-")
                     (rank . 12)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; provide the package

(provide 'cal-franciscan)
