;;; ========================================================== [ lfeco-sup.lfe ]

(defmodule lfeco-sup
  "The lfeco top-level supervisor."
  (behaviour supervisor)
  ;; API
  (export (start_link 0))
  ;; Supervisor callbacks
  (export (init 1)))

;; (defmacro SERVER () `(MODULE))

;;; ==================================================================== [ API ]

(defun start_link ()
  (supervisor:start_link `#(local ,(MODULE)) (MODULE) []))

;;; =================================================== [ Supervisor callbacks ]

(defun init
  ([()]
   (let* ((oauth_token (case (application:get_env 'lfeco 'oauth_token)
                         ('undefined    (exit 'missing_oauth_token))
                         (`#(ok ,token) token)))
          (mods        `[#(elli_date [])
                         #(elli_middleware_compress [])
                         #(lfeco-handler #m(token ,oauth_token))])
          (elli-config `[#(callback      elli_middleware)
                         #(callback_args [#(mods ,mods)])
                         #(port          ,(application:get_env 'lfeco
                                                               'port 8080))])
          (children    `[#m(id       lfeco
                            start    #(elli start_link [,elli-config])
                            restart  permanent
                            shutdown 5000
                            type     worker
                            modules  [elli])])
          (sup-flags   #m(strategy one_for_one intensity 5 period 10)))
     `#(ok #(,sup-flags ,children)))))

;;; ==================================================================== [ EOF ]
