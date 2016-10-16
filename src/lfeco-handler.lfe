;;; ====================================================== [ lfeco-handler.lfe ]

(defmodule lfeco-handler
  ;; TODO: write docstring
  (behaviour elli_handler)
  ;; elli_handler callbacks
  (export (handle 2) (handle_event 3)))

;;; ================================================= [ elli_handler callbacks ]

(defun handle (req args)
  (error_logger:info_msg "token: ~s~n" `[,(maps:get 'token args)])
  'ignore)

(defun handle_event (_event _data _args)
  'ok)

;;; ==================================================================== [ EOF ]
