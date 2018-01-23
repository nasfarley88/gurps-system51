all: main.pdf system51-player-guide.pdf

%.pdf: *.tex
	latexmk -interaction=nonstopmode -lualatex -use-make $(basename $@).tex

clean:
	latexmk -CA
