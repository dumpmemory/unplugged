# force build:
force-cn:
	latexmk -cd -xelatex unplugged-zh-cn.tex
force-en:
	latexmk -cd -xelatex unplugged-en.tex

all: cn en

BOOK-CN := $(wildcard *-zh-cn.tex)
BOOK-EN := $(wildcard *-en.tex)

cn: $(BOOK-CN:.tex=.pdf)
en: $(BOOK-EN:.tex=.pdf)

%.pdf: %.tex; latexmk -cd -xelatex $<

CHAPTERS-CN := $(shell egrep -l documentclass $$(find . -name '*-zh-cn.tex' -a \! -name 'unplugged-*.tex'))
CHAPTERS-EN := $(shell egrep -l documentclass $$(find . -name '*-en.tex' -a \! -name 'unplugged-*.tex'))

chapters: chapters-cn chapters-en
chapters-cn: $(CHAPTERS-CN:.tex=.pdf)
chapters-en: $(CHAPTERS-EN:.tex=.pdf)

# clean:
#	git clean -fdx

.PHONY: all cn en chapters chapters-cn chapters-en
