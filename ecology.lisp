;;;; ecology.lisp

(in-package #:ecology)

(annot:enable-annot-syntax)

@export 
(defparameter *O2-atm* 20.95 
"Объемное содержание кислорода в атмосфере, %")

@export
(defparameter *O2_15* 15 
  "Объемное содержание кислорода в отходящих газах ГТД для приведения к ним, %")

(export '*CO-ppm->mg/m3*)
(defparameter *CO-ppm->mg/m3* 1.25)

@export
(defparameter *NOx-ppm->mg/m3* 2.053)

@export 
(defparameter *NO2-ppm->mg/m3* 2.053)

@export
(defparameter *NO-ppm->mg/m3* 1.339)

@export
@annot.doc:doc
"Пересчет концентрации CO из ppm в mg/m3;
Параметры:
CO_ppm  - концентрация CO[ppm];
Ο2      - концентрация Ο2[%];
O2_pr   - Ο2[%] к которой необходимо выполнить приведение;
; (CO-ppm->mg/m3 25 16)     ;; Приведение к 15%_O2
; (CO-ppm->mg/m3 25 16 10)  ;; Приведение к 10%_O2"
(defun CO-ppm->mg/m3 (CO_ppm Ο2 &optional (O2_pr *O2_15*))
  (* *CO-ppm->mg/m3* CO_ppm (/ (- *O2-atm* O2_pr)(- *O2-atm* Ο2))))

@export
@annot.doc:doc
"Пересчет концентрации NOx из ppm в mg/m3;
Параметры:
NOx_ppm - концентрация NOx[ppm];
Ο2      - концентрация Ο2[%];
O2_pr   - Ο2[%] к которой необходимо выполнить приведение;
Пример использования:
 - Приведение к 15%_O2 (NOx-ppm->mg/m3 25 17)     => 77.31234
 - Приведение к 10%_O2 (NOx-ppm->mg/m3 25 17 10)  => 142.28067
"
(defun NOx-ppm->mg/m3 (NOx_ppm Ο2 &optional (O2_pr *O2_15*))
  (* *NOx-ppm->mg/m3* NOx_ppm (/ (- *O2-atm* O2_pr)(- *O2-atm* Ο2))))
