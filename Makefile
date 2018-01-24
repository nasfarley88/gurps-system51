all: main.pdf system51-player-guide.pdf

%.pdf: *.tex
	mkdir -p $(basename $@)_output
	latexmk -interaction=nonstopmode -output-directory=$(basename $@)_output -lualatex -use-make $(basename $@).tex
	cp $(basename $@)_output/$@ ./

clean:
	latexmk -CA
	rm -r *_output
