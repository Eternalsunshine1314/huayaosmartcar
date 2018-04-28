;; Auto-generated. Do not edit!


(when (boundp 'myserial::vehicleControl)
  (if (not (find-package "MYSERIAL"))
    (make-package "MYSERIAL"))
  (shadow 'vehicleControl (find-package "MYSERIAL")))
(unless (find-package "MYSERIAL::VEHICLECONTROL")
  (make-package "MYSERIAL::VEHICLECONTROL"))

(in-package "ROS")
;;//! \htmlinclude vehicleControl.msg.html


(defclass myserial::vehicleControl
  :super ros::object
  :slots (_mode _lidar _gamePad_x _gamePad_z _visual_x _visual_z ))

(defmethod myserial::vehicleControl
  (:init
   (&key
    ((:mode __mode) 0)
    ((:lidar __lidar) 0)
    ((:gamePad_x __gamePad_x) 0)
    ((:gamePad_z __gamePad_z) 0)
    ((:visual_x __visual_x) 0)
    ((:visual_z __visual_z) 0)
    )
   (send-super :init)
   (setq _mode (round __mode))
   (setq _lidar (round __lidar))
   (setq _gamePad_x (round __gamePad_x))
   (setq _gamePad_z (round __gamePad_z))
   (setq _visual_x (round __visual_x))
   (setq _visual_z (round __visual_z))
   self)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:lidar
   (&optional __lidar)
   (if __lidar (setq _lidar __lidar)) _lidar)
  (:gamePad_x
   (&optional __gamePad_x)
   (if __gamePad_x (setq _gamePad_x __gamePad_x)) _gamePad_x)
  (:gamePad_z
   (&optional __gamePad_z)
   (if __gamePad_z (setq _gamePad_z __gamePad_z)) _gamePad_z)
  (:visual_x
   (&optional __visual_x)
   (if __visual_x (setq _visual_x __visual_x)) _visual_x)
  (:visual_z
   (&optional __visual_z)
   (if __visual_z (setq _visual_z __visual_z)) _visual_z)
  (:serialization-length
   ()
   (+
    ;; int64 _mode
    8
    ;; int64 _lidar
    8
    ;; int64 _gamePad_x
    8
    ;; int64 _gamePad_z
    8
    ;; int64 _visual_x
    8
    ;; int64 _visual_z
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _mode
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _mode (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _mode) (= (length (_mode . bv)) 2)) ;; bignum
              (write-long (ash (elt (_mode . bv) 0) 0) s)
              (write-long (ash (elt (_mode . bv) 1) -1) s))
             ((and (class _mode) (= (length (_mode . bv)) 1)) ;; big1
              (write-long (elt (_mode . bv) 0) s)
              (write-long (if (>= _mode 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _mode s)(write-long (if (>= _mode 0) 0 #xffffffff) s)))
     ;; int64 _lidar
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _lidar (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _lidar) (= (length (_lidar . bv)) 2)) ;; bignum
              (write-long (ash (elt (_lidar . bv) 0) 0) s)
              (write-long (ash (elt (_lidar . bv) 1) -1) s))
             ((and (class _lidar) (= (length (_lidar . bv)) 1)) ;; big1
              (write-long (elt (_lidar . bv) 0) s)
              (write-long (if (>= _lidar 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _lidar s)(write-long (if (>= _lidar 0) 0 #xffffffff) s)))
     ;; int64 _gamePad_x
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _gamePad_x (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _gamePad_x) (= (length (_gamePad_x . bv)) 2)) ;; bignum
              (write-long (ash (elt (_gamePad_x . bv) 0) 0) s)
              (write-long (ash (elt (_gamePad_x . bv) 1) -1) s))
             ((and (class _gamePad_x) (= (length (_gamePad_x . bv)) 1)) ;; big1
              (write-long (elt (_gamePad_x . bv) 0) s)
              (write-long (if (>= _gamePad_x 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _gamePad_x s)(write-long (if (>= _gamePad_x 0) 0 #xffffffff) s)))
     ;; int64 _gamePad_z
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _gamePad_z (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _gamePad_z) (= (length (_gamePad_z . bv)) 2)) ;; bignum
              (write-long (ash (elt (_gamePad_z . bv) 0) 0) s)
              (write-long (ash (elt (_gamePad_z . bv) 1) -1) s))
             ((and (class _gamePad_z) (= (length (_gamePad_z . bv)) 1)) ;; big1
              (write-long (elt (_gamePad_z . bv) 0) s)
              (write-long (if (>= _gamePad_z 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _gamePad_z s)(write-long (if (>= _gamePad_z 0) 0 #xffffffff) s)))
     ;; int64 _visual_x
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _visual_x (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _visual_x) (= (length (_visual_x . bv)) 2)) ;; bignum
              (write-long (ash (elt (_visual_x . bv) 0) 0) s)
              (write-long (ash (elt (_visual_x . bv) 1) -1) s))
             ((and (class _visual_x) (= (length (_visual_x . bv)) 1)) ;; big1
              (write-long (elt (_visual_x . bv) 0) s)
              (write-long (if (>= _visual_x 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _visual_x s)(write-long (if (>= _visual_x 0) 0 #xffffffff) s)))
     ;; int64 _visual_z
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _visual_z (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _visual_z) (= (length (_visual_z . bv)) 2)) ;; bignum
              (write-long (ash (elt (_visual_z . bv) 0) 0) s)
              (write-long (ash (elt (_visual_z . bv) 1) -1) s))
             ((and (class _visual_z) (= (length (_visual_z . bv)) 1)) ;; big1
              (write-long (elt (_visual_z . bv) 0) s)
              (write-long (if (>= _visual_z 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _visual_z s)(write-long (if (>= _visual_z 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _mode
#+(or :alpha :irix6 :x86_64)
      (setf _mode (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _mode (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _lidar
#+(or :alpha :irix6 :x86_64)
      (setf _lidar (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _lidar (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _gamePad_x
#+(or :alpha :irix6 :x86_64)
      (setf _gamePad_x (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _gamePad_x (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _gamePad_z
#+(or :alpha :irix6 :x86_64)
      (setf _gamePad_z (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _gamePad_z (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _visual_x
#+(or :alpha :irix6 :x86_64)
      (setf _visual_x (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _visual_x (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _visual_z
#+(or :alpha :irix6 :x86_64)
      (setf _visual_z (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _visual_z (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(setf (get myserial::vehicleControl :md5sum-) "0b93a3ac7d139c45be24cc985db5ca1b")
(setf (get myserial::vehicleControl :datatype-) "myserial/vehicleControl")
(setf (get myserial::vehicleControl :definition-)
      "int64 mode
int64 lidar
int64 gamePad_x
int64 gamePad_z
int64 visual_x
int64 visual_z  



")



(provide :myserial/vehicleControl "0b93a3ac7d139c45be24cc985db5ca1b")


