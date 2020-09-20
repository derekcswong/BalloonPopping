;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname balloon-lab) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require spd/tags)
(require 2htdp/image)
(require 2htdp/universe)

; Balloon popping

(@Problem 1)
(@HtDW Balloon)
;; CONSTANTS ==========================

(define WIDTH 500)
(define HEIGHT 500)
(define MTS (empty-scene WIDTH HEIGHT))

(define BALLOON-COLOR "red")
(define POP-IMAGE (overlay (text "POP!" 80 "black")
                           (radial-star 30 (/ WIDTH 10) (/ WIDTH 2) "solid" "yellow")))

(define CTR-X (/ WIDTH 2))
(define CTR-Y (/ HEIGHT 2))

(define SPEED 2)

(define MAX-SIZE (/ WIDTH 2))





;; DATA DEFINITIONS ============================

(@HtDD Balloon)
;; Balloon is one of:
;; - Natural
;; - false
;; interp. false as popped balloon and Number as radius in pixels of circular balloon. 
(define rl 0)
(define r2 100)
(define r3 MAX-SIZE)
(define r4 false)


(@dd-template-rules one-of                    ; 2 cases
                    atomic-non-distinct       ; Natural
                    atomic-distinct)          ; false


#;
(define (fn-for-balloon r)
  (cond [(number? r) (... r)]
        [(false? r) (...)]))


                                                                     




;; FUNCTIONS ====================================

(@HtDF main)
(@signature Balloon -> Balloon)
;; starts the world program with (main 0)      
; no examples for main function

(@template htdw-main)

(define (main r)
  (big-bang r                  ; Balloon
            (on-tick tick)     ; Balloon -> Balloon
            (to-draw render))) ; Balloon -> Image


(@HtDF tick)
(@signature Balloon -> Balloon)
;; produce false if Balloon if (SPEED + r) >= MAX-SIZE. otherwise produce next Balloon by adding Balloon to SPEED 

(check-expect (tick 0) (+ 0 SPEED))
(check-expect (tick false) false)
(check-expect (tick MAX-SIZE) false)
(check-expect (tick 50) (+ 50 SPEED))       

;(define (tick r) 0) ;stub

(@template Balloon)
                                                          
(define (tick r)
  (cond [(number? r) (if (>= (+ SPEED r) MAX-SIZE)
                             false
                             (+ SPEED r))]
        [(false? r) false]))


(@HtDF render)
(@signature Balloon -> Image)
;; render growing balloon with radius r. otherwise render POP-IMAGE

(check-expect (render 0) (place-image (circle 0 "solid" BALLOON-COLOR) CTR-X CTR-Y MTS))                                  
(check-expect (render 50) (place-image (circle 50 "solid" BALLOON-COLOR) CTR-X CTR-Y MTS))
(check-expect (render false) (place-image POP-IMAGE CTR-X CTR-Y MTS))


;;(define (render r) MTS) ;stub

(@template Balloon)

(define (render r)
  (cond [(number? r) (place-image (circle r "solid" BALLOON-COLOR) CTR-X CTR-Y MTS)]
        [else (place-image POP-IMAGE CTR-X CTR-Y MTS)]))

 
