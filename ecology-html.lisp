;;;; ecology-html.lisp

(in-package #:ecology)

(defparameter *ecology-acceptor* nil)

(setf (html-mode) :HTML5)

(defun clean-dispatch-table()
  (if (> (length *dispatch-table*) 1)
      (setf *dispatch-table* (last *dispatch-table*)))
  *dispatch-table*)

(defun ecology-stop()
  "Выполняет:
2. Остановку web-сервера: *ecology-acceptor*
3. Отсоединение от базы данных
"
  (clean-dispatch-table)
  (stop *ecology-acceptor*)
  ) ;; (disconnect-toplevel)  Postmaster disconnection

(defmacro standard-page ((&key title)  &body body)
  `(with-html-output-to-string (*standard-output* nil :prologue t :indent t)
     (:html
      (:head
       (:meta :chatset "utf-8")
       (:title ,title)
       (:link :type "text/css" :rel "stylesheet" :href "/retro.css"))
      (:body
       (:header
	(:table :width "1000px"
		(:tr
		 (:td (:a :href "http://mnasoft.ddns.net/" (:img :src "/static/images/MNASoft.png" :alt "Archlinux" :class "logo" :height "28px")))
		 (:td :width "300px" "")
		 (:td (:audio :controls "controls" ;; :autoplay "autoplay"
			      (:source  :src "/static/audio/dzhejms_last_-_odinokij_pastuh_(zvukoff.ru).mp3" :type "audio/mpeg")))))
	(:hr))
       (:main ,@body)
       (:footer 
	(:hr)
	(:table :width "1000px"
		(:tr
		 (:td "Поиск ГОСТов")
		 (:td :width "150px" "")
		 (:td
		  (:a :href "https://www.archlinux.org/"             (:img :src "/static/images/ArchlinuxLogo2.png" :alt "Archlinux"   :class "logo" :height "28px"))
		  (:a :href "http://www.gnu.org/software/emacs/"     (:img :src "/static/images/emacs-logo.png"     :alt "GNU Emacs"   :class "logo" :height "28px"))
		  (:a :href "https://common-lisp.net/project/slime/" (:img :src "/static/images/slime-small.png"    :alt "GNU Emacs"   :class "logo" :height "28px"))
		  (:a :href "http://www.postgresql.org/"             (:img :src "/static/images/PostgreSQL_01.png"  :alt "PostgreSQL"  :class "logo" :height "28px"))
		  (:a :href "http://www.sbcl.org/"                   (:img :src "/static/images/SBCL.png"           :alt "SBCL"        :class "logo" :height "28px"))
		  (:a :href "http://weitz.de/hunchentoot/"           (:img :src "/static/images/hunchentoot11.png"  :alt "Hunchentoot" :class "logo" :height "28px")))))
	(:hr))))))

(defmacro define-url-fn ((name) &body body)
  `(progn (defun ,name() ,@body)
	  (push (create-prefix-dispatcher ,(format nil "/~(~a~)" name) ',name) *dispatch-table*)))

(defun ecology-start()
  ;;  (connect-toplevel "namatv" "namatv" mnas-passwd:POSTGRESS@MNASOFT-PI "localhost") ;; Postmaster connaction
  (setf *ecology-acceptor* (start (make-instance 'easy-acceptor :port 8001))))

(define-url-fn (select)
  (standard-page
      (:title "Combustion-Chamber-Tools")
    (:h1 "Пересчет CO и ΝΟx")
    (:form :action "/show" :method "post"
	   (:table :style "width:25em"
		   (:caption "Таблица 1 - Состав пробы газа")
		   (:tr (:th "Обозн.") (:th "Наименование")       (:th "Значение") )
		   (:tr (:td "CO"    ) (:td "Монооксид углерода") (:td (:input :type "text" :name "CO-ppm"   :class "txt" :style "width:5em" :value  "0")))
		   (:tr (:td "NO"    ) (:td "Монооксид азота")    (:td (:input :type "text" :name "NO-ppm"   :class "txt" :style "width:5em" :value  "0")))
		   (:tr (:td "NO2"   ) (:td "Оксид азота")        (:td (:input :type "text" :name "NO2-ppm"  :class "txt" :style "width:5em" :value  "0")))
		   (:tr (:td "O2"    ) (:td "Кислород")           (:td (:input :type "text" :name "O2-%"     :class "txt" :style "width:5em" :value "18")))
		   (:tr (:td "O2-pr" ) (:td "Кислород")           (:td (:input :type "text" :name "O2-pr-%"  :class "txt" :style "width:5em" :value "15"))))
	   (:p (:input :type "submit" :value "Отобрать" :class "btn")))))

(define-url-fn (show)
  (let* ((CO-ppm   (read-from-string-number (parameter "CO-ppm" ) 0))
	 (NO-ppm   (read-from-string-number (parameter "NO-ppm" ) 0))
	 (NO2-ppm  (read-from-string-number (parameter "NO2-ppm") 0))
	 (O2-%     (read-from-string-number (parameter "O2-%"   ) 18))
	 (O2-pr-%  (read-from-string-number (parameter "O2-pr-%") 15)))
    (standard-page
	(:title "Combustion-Chamber-Tools")
      (:form :action "/show" :method "post"
	     (:table :style "width:25em"
		     (:caption (:h2 "Таблица 1 - Состав пробы газа"))
		     (:tr (:th "Обозн.") (:th "Наименование")       (:th "Значение") )
		     (:tr (:td "CO"    ) (:td "Монооксид углерода") (:td (:input :type "text" :name "CO-ppm"   :class "txt" :style "width:5em" :value  (str (write-to-string CO-ppm )))))
		     (:tr (:td "NO"    ) (:td "Монооксид азота")    (:td (:input :type "text" :name "NO-ppm"   :class "txt" :style "width:5em" :value  (str (write-to-string NO-ppm )))))
		     (:tr (:td "NO2"   ) (:td "Оксид азота")        (:td (:input :type "text" :name "NO2-ppm"  :class "txt" :style "width:5em" :value  (str (write-to-string NO2-ppm)))))
		     (:tr (:td "O2"    ) (:td "Кислород")           (:td (:input :type "text" :name "O2-%"     :class "txt" :style "width:5em" :value  (str (write-to-string O2-%   )))))
		     (:tr (:td "O2-pr" ) (:td "Кислород")           (:td (:input :type "text" :name "O2-pr-%"  :class "txt" :style "width:5em" :value "15"))))
	     (:p (:input :type "submit" :value "Отобрать" :class "btn")))
      (:table
       (:caption (:h2 "Таблица 2 - Состав пробы газа"))
       (:tr (:th "Обозн")     (:th "Наименование")       (:th "Значение"))
       (:tr (:td "CO,ppm")    (:td "Монооксид углерода") (:td (str (write-to-string CO-ppm  ))))
       (:tr (:td "NO,ppm")    (:td "Монооксид азота")    (:td (str (write-to-string NO-ppm  ))))
       (:tr (:td "NO2,ppm")   (:td "Оксид азота")        (:td (str (write-to-string NO2-ppm ))))
       (:tr (:td "O2,%")      (:td "Кислород")           (:td (str (write-to-string O2-%    ))))
       (:tr (:td "O2-pr,%")   (:td "Кислород")           (:td (str (write-to-string O2-pr-% ))))
       (:tr (:td "CO,mg/m3")  (:td "Монооксид углерода") (:td (str (write-to-string (CO-ppm->mg/m3 CO-ppm O2-% O2-pr-%)))))
       (:tr (:td "NOx,mg/m3") (:td "Оксиды азота")       (:td (str (write-to-string (NOx-ppm->mg/m3 NO-ppm O2-% O2-pr-%)))))))))

(defun read-from-string-number (str &optional (default 0.0))
  (let ((val (read-from-string str)))
    (cond
      ((numberp val) val)
      (t default))))

(ecology-start)

;;;;(progn (ecology-stop) (ecology-start))
