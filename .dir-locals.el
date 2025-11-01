((org-mode . ((eval . (progn
			(setq org-latex-default-packages-alist nil)
			(setq org-latex-packages-alist nil)
			(setq org-latex-with-hyperref nil)
			(setq org-latex-title-command "")
			(setq org-latex-toc-command "")
			(setq org-latex-pdf-process '("cd %o && latexmk -pdfdvi %f"))
			(setq org-cite-export-processors '((latex bibtex "ipsjsort") 
							   (html csl ".csl-styles/digital-scholarship-in-the-humanities.csl") 
							   (t basic)))
                        (unless (assoc "ipsj" org-latex-classes)
                          (add-to-list 'org-latex-classes
                                       '("ipsj"
                                         "\\documentclass{ipsj}"
                                         ("\\section{%s}" . "\\section*{%s}")
                                         ("\\subsection{%s}" . "\\subsection*{%s}")
                                         ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))
			
			(defun my-html-filter-nobreaks (text backend info)
			  "Ensure \" \" are properly handled in html export."
			  (when (org-export-derived-backend-p backend 'html)
			    (replace-regexp-in-string "\n" "" text)))
			
			(unless (memq 'my-html-filter-nobreaks org-export-filter-plain-text-functions)
			  (add-to-list 'org-export-filter-plain-text-functions
				       'my-html-filter-nobreaks))

			(defun my-html-image-width (text backend info)
			  "Set all images to width 100% in HTML export."
			  (when (org-export-derived-backend-p backend 'html)
			    (replace-regexp-in-string 
			     "<img src=\"\\([^\"]+\\)\"" 
			     "<img style=\"width:100%\" src=\"\\1\"" 
			     text)))

			(unless (memq 'my-html-image-width org-export-filter-final-output-functions)
			  (add-to-list 'org-export-filter-final-output-functions
				       'my-html-image-width)))))))
