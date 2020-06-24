Rmd_src := $(wildcard *.Rmd)
tex_src := main.tex
bib_src := ref.bib

Rmd_out := $(patsubst %.Rmd,%.tex,$(Rmd_src))
tex_out := $(patsubst %.tex,%.pdf,$(tex_src))

all: $(tex_out) 

$(Rmd_out): $(Rmd_src) 
	for f in $+; do \
		Rscript -e "rmarkdown::render('$$f')"; \
	done

$(tex_out): $(tex_src) $(Rmd_out)
	@latexmk -halt-on-error -pdf $<
	@latexmk -c

clean:
	@$(RM) -rf $(tex_out) $(Rmd_out) *~ .*~ .\#* \
	.Rhistory *.aux *.bbl *.blg *.dvi *.out *.log \
	*.toc *.fff *.fdb_latexmk *.fls *.ttt *diff* *oldtmp* \
	.blb *.synctex.gz

cleanCache:
	@$(RM) -rf $(patsubst %.Rmd,%_cache,$(Rmd_src)) \
		$(patsubst %.Rmd,%_files,$(Rmd_src))
