;;;; ecology-html.lisp

(in-package #:ecology)

(defparameter *ecology-dispatch-table* nil
  "Таблица диспетчеризации проекта adiabatic-temperature")

(defun ecology-stop()
  "Выполняет очистку таблицы диспетчеризации"
  (clean-dispatch-table '*ecology-dispatch-table*)) 


(defun ecology-start()
  (mnas-site-start)
  (define-url-fn (ecology/select *ecology-dispatch-table*)
    (standard-page ("Combustion-Chamber-Tools-select" :header (mnas-site-template:header) :footer (mnas-site-template:footer))
      (:h3 "Пересчет CO и ΝΟx, выраженных в ppm в мг/м3, и приведение к определенному количеству кислорода")
      (:form :action "show" :method "post"
	     (:table :border "2" :cols "4" :style "width:30em"
		     (:caption (:h3 "Таблица 1 - Состав пробы газа"))
		     (:tr (:th "Обозн.") (:th "Наименование")       (:th "Значение") (:th "Ед. изм.") )
		     (:tr (:td "CO"    ) (:td "Монооксид углерода") (:td (:input :type "text" :name "CO-ppm"   :class "txt" :value  "0") (:td "ppm")))
		     (:tr (:td "NO"    ) (:td "Монооксид азота")    (:td (:input :type "text" :name "NO-ppm"   :class "txt" :value  "0") (:td "ppm")))
		     (:tr (:td "NO2"   ) (:td "Оксид азота")        (:td (:input :type "text" :name "NO2-ppm"  :class "txt" :value  "0") (:td "ppm")))
		     (:tr (:td "O2"    ) (:td "Кислород")           (:td (:input :type "text" :name "O2-%"     :class "txt" :value "17") (:td "% об")))
		     (:tr (:td "O2-pr" ) (:td "Кислород")           (:td (:input :type "text" :name "O2-pr-%"  :class "txt" :value "15") (:td "% об"))))
	     (:p (:input :type "submit" :value "Рассчитать" :class "btn")))))
  (define-url-fn (ecology/show *ecology-dispatch-table*)
    (let* ((CO-ppm   (read-from-string-number (parameter "CO-ppm" ) 0))
	   (NO-ppm   (read-from-string-number (parameter "NO-ppm" ) 0))
	   (NO2-ppm  (read-from-string-number (parameter "NO2-ppm") 0))
	   (O2-%     (read-from-string-number (parameter "O2-%"   ) 18))
	   (O2-pr-%  (read-from-string-number (parameter "O2-pr-%") 15)))
      (standard-page ("Combustion-Chamber-Tools-show" :header (mnas-site-template:header) :footer (mnas-site-template:footer))
	(:form :action "show" :method "post"
	       (:table :border "2" :cols "4" :style "width:30em"
		       (:caption (:h3 "Таблица 1 - Состав пробы газа"))
		       (:tr (:th "Обозн.") (:th "Наименование")       (:th "Значение") (:th "Ед. изм.") )
		       (:tr (:td "CO"    ) (:td "Монооксид углерода") (:td (:input :type "text" :name "CO-ppm"   :class "txt"  :value  (str (write-to-string CO-ppm  ))))(:td "ppm"))
		       (:tr (:td "NO"    ) (:td "Монооксид азота")    (:td (:input :type "text" :name "NO-ppm"   :class "txt"  :value  (str (write-to-string NO-ppm  ))))(:td "ppm"))
		       (:tr (:td "NO2"   ) (:td "Оксид азота")        (:td (:input :type "text" :name "NO2-ppm"  :class "txt"  :value  (str (write-to-string NO2-ppm ))))(:td "ppm"))
		       (:tr (:td "O2"    ) (:td "Кислород")           (:td (:input :type "text" :name "O2-%"     :class "txt"  :value  (str (write-to-string O2-%    ))))(:td "% об"))
		       (:tr (:td "O2-pr" ) (:td "Кислород")           (:td (:input :type "text" :name "O2-pr-%"  :class "txt"  :value  (str (write-to-string O2-pr-% ))))(:td "% об")))
	       (:p (:input :type "submit" :value "Рассчитать" :class "btn")))
	(:table :border "2" :cols "3" :style "width:30em"
		(:caption (:h3 (str (concatenate 'string "Таблица 2 - Состав пробы газа, приведенный к " (write-to-string O2-pr-% ) "%, O2"))))
		(:tr (:th "CO, ppm")    (:th "NO, ppm")       (:th "NO2, ppm") (:th "O2, %") (:th "CO, mg/m3") (:th "NOx, mg/m3"))
		(:tr
		 (:td (str (write-to-string CO-ppm  )))
		 (:td (str (write-to-string NO-ppm  )))
		 (:td (str (write-to-string NO2-ppm )))
		 (:td (str (write-to-string O2-%    )))
		 (:td (str (write-to-string (CO-ppm->mg/m3 CO-ppm O2-% O2-pr-%))))
		 (:td (str (write-to-string (NOx-ppm->mg/m3 (+ NO-ppm NO2-ppm) O2-% O2-pr-%)))))))))
  )

(defun read-from-string-number (str &optional (default 0.0))
  (let ((val (read-from-string str)))
    (cond
      ((numberp val) val)
      (t default))))

;;;; (progn (ecology-stop) (ecology-start))

;;;; (mnas-site-start)

;;;; (mnas-site-stop)

;;;; *adiabatic-temperature-dispatch-table*

;;;; *dispatch-table*

