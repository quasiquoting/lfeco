;;; ========================================================== [ lfeco-app.lfe ]

(defmodule lfeco-app
  "The lfeco application."
  (behaviour application)
  ;; Application callbacks
  (export (start 2) (stop 1)))

;;; ================================================== [ Application callbacks ]

(defun start (_type _args)
  "Start the application."
  (lfeco-sup:start_link))

(defun stop (_state)
  "Stop the application."
  'ok)

;;; ==================================================================== [ EOF ]
