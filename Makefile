all: main.pdf

main.pdf: *.tex
	latexmk -interaction=nonstopmode -lualatex -use-make main.tex

clean:
	latexmk -CA
