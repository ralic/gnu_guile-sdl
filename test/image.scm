#! /usr/local/bin/guile -s
!#

;; simple image test
;; 
;; Created:    <2001-05-29 20:38:26 foof>
;; Time-stamp: <2001-06-03 20:59:24 foof>
;; Author:     Alex Shinn <foof@debian.org>

(use-modules ((sdl sdl)
              :rename (symbol-prefix-proc 'sdl-)))

;; the directory to find the image in
(define datadir (if (getenv "srcdir")
                  (string-append (getenv "srcdir") "/test/")
                  "./"))

;; the size of our test image
(define gnu-rect (sdl-make-rect 0 0 200 153))

;; initialize the SDL video module
(sdl-init sdl-init/video)

;; set the video mode to the dimensions of our image
(sdl-set-video-mode 200 153 16 1)

;; load and blit the image
(let ((gnu-head (sdl-load-image (string-append datadir "gnu-goatee.jpg"))))
  (sdl-blit-surface gnu-head gnu-rect (sdl-get-video-surface) gnu-rect))

;; flip the double buffer
(sdl-flip (sdl-get-video-surface))

;; wait a half-second, then flip it upside-down
(usleep 500000)
(let ((upside-down (sdl-vertical-flip-surface (sdl-get-video-surface))))
  (sdl-blit-surface upside-down gnu-rect (sdl-get-video-surface) gnu-rect))
(sdl-flip (sdl-get-video-surface))

;; now flip horizontally
(usleep 500000)
(let ((left-right (sdl-horizontal-flip-surface (sdl-get-video-surface))))
  (sdl-blit-surface left-right gnu-rect (sdl-get-video-surface) gnu-rect))
(sdl-flip (sdl-get-video-surface))

;; ... and finally flip back
(usleep 500000)
(let ((orig (sdl-vh-flip-surface (sdl-get-video-surface))))
  (sdl-blit-surface orig gnu-rect (sdl-get-video-surface) gnu-rect))
(sdl-flip (sdl-get-video-surface))

;; wait then quit
(usleep 500000)
(sdl-quit-all)

