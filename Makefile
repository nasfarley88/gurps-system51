PDFS=main.pdf system51-player-guide.pdf
SHELL=/bin/bash

all: $(PDFS)

%.pdf: *.tex
	mkdir -p $(basename $@)_output
	ln -sf ${PWD}/images $(basename $@)_output/
	ln -sf ${PWD}/*.tex $(basename $@)_output/
	ln -sf ${PWD}/*.lua $(basename $@)_output/
	cd $(basename $@)_output/ && \
		latexmk -interaction=nonstopmode -lualatex $(basename $@).tex
	cp $(basename $@)_output/$@ ./

clean:
	latexmk -CA
	rm -r *_output
	rm $(PDFS)
