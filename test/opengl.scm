#! /usr/local/bin/guile -s
!#

;; simple opengl test
;; 
;; Created:    <2001-06-16 17:02:54 foof>
;; Time-stamp: <2001-06-16 17:14:55 foof>
;; Author:     Alex Shinn <foof@debian.org>

(use-modules ((sdl sdl)
              :rename (symbol-prefix-proc 'sdl-)))

(use-modules (opengl opengl))

;; initialize the SDL video module
(sdl-init sdl-init/video)

;; get a sample rect size from a list of available modes
(define test-rect
  (let ((modes (sdl-list-modes)))
    (cond ((eq? modes #f)
           (error "no supported video modes"))
          ((eq? modes #t)
           ;; any mode, use arbitrary 800x600
           (sdl-make-rect 0 0 800 600))
          (else
           ;; a list - choose the first mode
           (car modes)))))

;; set the video mode with opengl
(sdl-set-video-mode (sdl-rect:w test-rect) (sdl-rect:h test-rect) 16
                    (logior sdl-video/hwsurface sdl-video/opengl))

;; draw some lines
(gl-begin)
(gl-vertex2d 0 0)
(gl-vertex2d 0 100)
(gl-vertex2d 100 100)
(gl-vertex2d 100 0)
(gl-end)

;; swap the double buffer
(sdl-gl-swap-buffers)

;; wait then quit
(sdl-delay 3000)
(sdl-quit-all)

