PDFS=main.pdf system51-player-guide.pdf main-for-the-web.pdf
GCS_FILES=$(wildcard character_sheets/*.gcs)
GCX_FILES=$(patsubst character_sheets/%.gcs,%.gcx,$(GCS_FILES))
SHELL=/bin/bash

GCS_TEMPLATE=$(shell kpsewhich gurps-gcs-template.gcx)

.PRECIOUS: %.gcx

all: $(PDFS)

%.pdf: *.tex *.lua *.sty $(GCX_FILES)
	mkdir -p $(basename $@)_output
	ln -sf ${PWD}/latexmkrc $(basename $@)_output/
	ln -sf ${PWD}/character_sheets $(basename $@)_output/
	ln -sf ${PWD}/images $(basename $@)_output/
	ln -sf ${PWD}/*.tex $(basename $@)_output/
	ln -sf ${PWD}/*.gcx $(basename $@)_output/
	ln -sf ${PWD}/*.png $(basename $@)_output/
	ln -sf ${PWD}/*.sty $(basename $@)_output/
	ln -sf ${PWD}/*.lua $(basename $@)_output/
	ln -sf ${PWD}/*.json $(basename $@)_output/
	cd $(basename $@)_output/ && \
		latexmk -lualatex $(basename $@).tex -interaction=nonstopmode > /dev/null 2>&1
	cp $(basename $@)_output/$@ ./

%.gcx: character_sheets/%.gcs
	gcs $(abspath $<) -text -text_template=$(GCS_TEMPLATE)
	mv character_sheets/$@ ./
	test -f character_sheets/$(basename $@).png &&  mv character_sheets/$(basename $@).png ./
# Replace % with \% inside gcx files
	sed -i 's/%/\\%/g' $@
	sed -i 's/+0/0/g' $@
	sed -i 's/&quot;/"/g' $@

clean:
# Sometimes I compile in the root directory, this needs cleaning before git commtting
	latexmk -CA

  # Removing the usual things.
	rm -rf *_output
	rm -f *.gcx
	rm -f *.png
	rm -f $(PDFS)

cleantex:
	rm -rf *_output
	rm -f $(PDFS)
