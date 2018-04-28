
(cl:in-package :asdf)

(defsystem "myserial-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "vehicleControl" :depends-on ("_package_vehicleControl"))
    (:file "_package_vehicleControl" :depends-on ("_package"))
  ))