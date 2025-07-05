;; Marketplace Contract - Handles NFT listings and sales

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-already-listed (err u102))
(define-constant err-not-listed (err u103))
(define-constant err-insufficient-funds (err u104))
(define-constant err-unauthorized (err u105))
(define-constant commission-rate u250) ;; 2.5%

;; Data Variables
(define-data-var commission-recipient principal contract-owner)

;; Data Maps
(define-map listings uint {
  seller: principal,
  price: uint,
  active: bool
})

(define-map tokens uint {owner: principal, token-uri: (optional (string-utf8 256))})
(define-map royalties uint {recipient: principal, royalty-percent: uint})

;; Internal token functions
(define-read-only (get-token-owner (token-id uint))
  (get owner (map-get? tokens token-id))
)

(define-public (transfer-token (token-id uint) (sender principal) (recipient principal))
  (let ((token (unwrap! (map-get? tokens token-id) err-not-found)))
    (asserts! (is-eq tx-sender sender) err-unauthorized)
    (asserts! (is-eq sender (get owner token)) err-unauthorized)
    (map-set tokens token-id (merge token {owner: recipient}))
    (ok true)
  )
)

;; Listing Functions
(define-public (list-nft (token-id uint) (price uint))
  (let ((token-owner (unwrap! (get-token-owner token-id) err-not-found)))
    (asserts! (is-eq tx-sender token-owner) err-unauthorized)
    (asserts! (> price u0) (err u107))
    (asserts! (is-none (map-get? listings token-id)) err-already-listed)

    (map-set listings token-id {
      seller: tx-sender,
      price: price,
      active: true
    })
    (print {type: "nft_listed", token-id: token-id, seller: tx-sender, price: price})
    (ok true)
  )
)

(define-public (buy-nft (token-id uint))
  (let (
    (listing (unwrap! (map-get? listings token-id) err-not-listed))
    (price (get price listing))
    (seller (get seller listing))
    (commission (/ (* price commission-rate) u10000))
    (seller-amount (- price commission))
  )
    (asserts! (get active listing) err-not-listed)
    (asserts! (>= (stx-get-balance tx-sender) price) err-insufficient-funds)

    ;; Transfer STX payments
    (try! (stx-transfer? commission tx-sender (var-get commission-recipient)))
    (try! (stx-transfer? seller-amount tx-sender seller))

    ;; Transfer NFT
    (try! (transfer-token token-id seller tx-sender))

    ;; Remove listing
    (map-delete listings token-id)

    (print {type: "nft_sold", token-id: token-id, seller: seller, buyer: tx-sender, price: price})
    (ok true)
  )
)

(define-read-only (get-listing (token-id uint))
  (map-get? listings token-id)
)
