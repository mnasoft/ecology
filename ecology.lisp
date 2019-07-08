;;;; ecology.lisp

(in-package #:ecology)

;;; "ecolpgy" goes here. Hacks and glory await!

(export '*O2-atm*)
(defparameter *O2-atm* 20.95 
"Объемное содержание кислорода в атмосфере, %")

(export '*O2_15*)
(defparameter *O2_15* 15 
  "Объемное содержание кислорода в отходящих газах ГТД для приведения к ним, %")

(export '*CO-ppm->mg/m3*)
(defparameter *CO-ppm->mg/m3* 1.25)


(export '*NOx-ppm->mg/m3*)
(defparameter *NOx-ppm->mg/m3* 2.053)

(export '*NO2-ppm->mg/m3*)
(defparameter *NO2-ppm->mg/m3* 2.053)

(export '*NO-ppm->mg/m3*)
(defparameter *NO-ppm->mg/m3* 1.339)

(export 'CO-ppm->mg/m3)
(defun CO-ppm->mg/m3 (CO_ppm Ο2 &optional (O2_pr *O2_15*))
"Пересчет концентрации CO из ppm в mg/m3;
Параметры:
CO_ppm  - концентрация CO[ppm];
Ο2      - концентрация Ο2[%];
O2_pr   - Ο2[%] к которой необходимо выполнить приведение;
; (CO-ppm->mg/m3 25 16)     ;; Приведение к 15%_O2
; (CO-ppm->mg/m3 25 16 10)  ;; Приведение к 10%_O2"
  (* *CO-ppm->mg/m3* CO_ppm (/ (- *O2-atm* O2_pr)(- *O2-atm* Ο2))))

(export 'NOx-ppm->mg/m3)
(defun NOx-ppm->mg/m3 (NOx_ppm Ο2 &optional (O2_pr *O2_15*))
  "Пересчет концентрации NOx из ppm в mg/m3;
Параметры:
NOx_ppm - концентрация NOx[ppm];
Ο2      - концентрация Ο2[%];
O2_pr   - Ο2[%] к которой необходимо выполнить приведение;
Пример использования:
 - Приведение к 15%_O2 (NOx-ppm->mg/m3 25 17)     => 77.31234
 - Приведение к 10%_O2 (NOx-ppm->mg/m3 25 17 10)  => 142.28067
  "
  (* *NOx-ppm->mg/m3* NOx_ppm (/ (- *O2-atm* O2_pr)(- *O2-atm* Ο2))))
