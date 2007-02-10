;;;; General font definition

(in-package :lispbuilder-sdl)

(defclass sdl-font ()
  ((cached-surface :accessor cached-surface :initform nil))
  (:documentation
   "The SDL-FONT class is a generic font class."))

(defmethod fp ((font sdl-font))
  (fp (cached-surface font)))

(defmethod fp-position ((font sdl-font))
  (fp-position (cached-surface font)))

(defmethod width ((font sdl-font))
  (sdl-base::surf-w (fp (cached-surface font))))
(defmethod (setf width) (w-val (font sdl-font))
  (setf (sdl-base::rect-w (fp-position (cached-surface font))) w-val))

(defmethod height ((font sdl-font))
  (sdl-base::surf-h (fp (cached-surface font))))
(defmethod (setf height) (h-val (font sdl-font))
  (setf (sdl-base::rect-h (fp-position (cached-surface font))) h-val))

(defmethod x ((font sdl-font))
  (sdl-base::rect-x (fp-position (cached-surface font))))
(defmethod (setf x) (x-val (font sdl-font))
  (setf (sdl-base::rect-x (fp-position (cached-surface font))) x-val))

(defmethod y ((font sdl-font))
  (sdl-base::rect-y (fp-position (cached-surface font))))
(defmethod (setf y) (y-val (font sdl-font))
  (setf (sdl-base::rect-y (fp-position (cached-surface font))) y-val))

(defmethod free-cached-surface ((font sdl-font))
  (when (and (sdl:cached-surface font)
	     (typep (sdl:cached-surface font) 'sdl:sdl-surface))
    (free-surface (sdl:cached-surface font))
    (setf (sdl:cached-surface font) nil)))

(defmethod draw-font (&key (font *default-font*) (surface *default-surface*))
  (unless (typep font 'sdl-font)
    (error "ERROR; DRAW-FONT: FONT must be of type SDL-FONT."))
  (unless (cached-surface font)
    (error "ERROR; DRAW-FONT: FONT does not contain a cached SURFACE."))
  (blit-surface (cached-surface font) surface))

(defmethod draw-font-at (position &key (font *default-font*) (surface *default-surface*))
  (unless (typep font 'sdl-font)
    (error "ERROR; DRAW-FONT-AT: FONT must be of type SDL-FONT."))
  (unless (cached-surface font)
    (error "ERROR; DRAW-FONT-AT: FONT does not contain a cached SURFACE."))
  (draw-surface-at (cached-surface font) position :surface surface))

(defmethod draw-font-at-* (x y &key (font *default-font*) (surface *default-surface*))
  (unless (typep font 'sdl-font)
    (error "ERROR; DRAW-FONT-AT-*: FONT must be of type SDL-FONT."))
  (unless (cached-surface font)
    (error "ERROR; DRAW-FONT-AT-*: FONT does not contain a cached SURFACE."))
  (draw-surface-at-* (cached-surface font) x y :surface surface))
