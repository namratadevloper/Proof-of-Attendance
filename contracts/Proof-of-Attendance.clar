;; Proof-of-Attendance ZK Badge
;; Minimal implementation with badge issue and verify functions

;; Constants
(define-constant err-invalid-proof (err u100))
(define-constant err-already-issued (err u101))

;; Map to store badge ownership
(define-map badges principal bool)

;; Issue a badge (requires valid zero-knowledge proof hash)
(define-public (issue-badge (recipient principal) (zk-proof-hash (buff 32)))
  (begin
    ;; Normally we'd verify zk-proof-hash against an off-chain verifier
    (asserts! (not (default-to false (map-get? badges recipient))) err-already-issued)
    ;; For simplicity, we just store badge as issued = true
    (map-set badges recipient true)
    (ok true)
  )
)

;; Check if an address owns a badge
(define-read-only (verify-badge (account principal))
  (ok (default-to false (map-get? badges account)))
)
