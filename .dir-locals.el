((org-mode . ((eval . (progn
                        (add-to-list 'org-latex-classes
                                     '("ipsj"
                                       "\\documentclass{ipsj}"
                                       ("\\section{%s}" . "\\section*{%s}")
                                       ("\\subsection{%s}" . "\\subsection*{%s}")
                                       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
                        (setq org-latex-pdf-process
                              '("latexmk -output-directory=%o %f")))))))
