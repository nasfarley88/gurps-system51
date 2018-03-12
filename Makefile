PDFS=main.pdf system51-player-guide.pdf main-for-the-web.pdf
SHELL=/bin/bash

all: $(PDFS)

%.pdf: *.tex *.lua
	mkdir -p $(basename $@)_output
	ln -sf ${PWD}/images $(basename $@)_output/
	ln -sf ${PWD}/*.tex $(basename $@)_output/
	ln -sf ${PWD}/*.lua $(basename $@)_output/
	ln -sf ${PWD}/*.json $(basename $@)_output/
	cd $(basename $@)_output/ && \
		latexmk -interaction=nonstopmode -lualatex $(basename $@).tex
	cp $(basename $@)_output/$@ ./

clean:
  # Sometimes I compile in the root directory, this needs cleaning before git commtting
	latexmk -CA

  # Removing the usual things.
	rm -rf *_output
	rm -f $(PDFS)
