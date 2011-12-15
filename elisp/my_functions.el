
;; Print to PDF
(defun pdf-print-buffer ()
  "convert current buffer to a PDF file with faces."
  (interactive)
  (let* ((file-name (format "/tmp/%s/%s" (user-real-uid) (buffer-name)))
	 (ps-file-name (concat file-name ".ps"))
	 (pdf-file-name (concat file-name ".pdf")))
    (save-excursion
      (save-restriction
	(progn
	  (ps-print-buffer ps-file-name)
	  (shell-command (concat "ps2pdf " ps-file-name " " pdf-file-name))
	  (shell-command (concat "open " pdf-file-name)))))))

;; Word count

(defun count-words-region (beginning end)
  "Print number of words in the region.
Words are defined as at least one word-consituent
character followed by at least one character that
is not a word-constituent. The buffer's syntax
table determines which characters these are."
  (interactive "r")
  (message "Counting words in region ... ")

  ;;; 1. Set up appropriate conditions.
  (save-excursion
    (goto-char beginning)
    (let ((count 0))
      
  ;;; 2. Run the while loop.
      (while (< (point) end)
	(re-search-forward "\\w+\\W*")
	(setq count (1+ count)))
      
  ;;; 3. Send a message to the user.
      (cond ((zerop count)
	     (message
	      "The region does NOT have any words."))
	    ((= 1 count)
	     (message
	      "The region has 1 word."))
	    (t
	     (message
	      "The region has %d words." count))))))
