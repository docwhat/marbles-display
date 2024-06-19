# Makefile for building a gallery for easy viewing.

GALLERY := gallery
SRCS := $(filter-out $(GALLERY)/%,$(wildcard *.scad))

# Target the gallery directory
SCADS   := $(addprefix $(GALLERY)/, $(notdir $(SRCS)))
STLS    := $(SCADS:.scad=.stl)
IMAGES  := $(SCADS:.scad=.png)
ICONS   := $(SCADS:.scad=.icon.png)
README  := $(GALLERY)/README.md

.PHONY : all
all : stls images icons readme

.PHONY : debug
debug :
	@printf -- "SRCS :   $(SRCS)\n"
	@printf -- "------------------------------\n"
	@printf -- "SCADS :  $(SCADS)\n"
	@printf -- "STLS :   $(STLS)\n"
	@printf -- "IMAGES : $(IMAGES)\n"
	@printf -- "ICONS :  $(ICONS)\n"

.PHONY : gallery
gallery : $(SCADS) $(STLS) $(IMAGES) $(ICONS) $(README)

.PHONY : stls
stls : $(STLS)

.PHONY : images
images : $(IMAGES)

.PHONY : icons
icons : $(ICONS)

.PHONY : readme
readme : $(GALLERY)/README.md

$(SCADS) $(STLS) $(IMAGES) $(ICONS) : $(GALLERY)/.gitignore

$(GALLERY)/.gitignore :
	mkdir -p $(GALLERY)
	touch $(GALLERY)/.gitignore

$(GALLERY)/%.scad : %.scad
	cp $< $@

$(GALLERY)/%.stl : $(GALLERY)/%.scad
	openscad $< -o $@

$(GALLERY)/%.unoptimized.png : $(GALLERY)/%.scad
	openscad $< --render --colorscheme=Tomorrow -o $@ 

$(GALLERY)/%.icon.unoptimized.png : $(GALLERY)/%.scad
	openscad $< --imgsize=256,256 --render --colorscheme=Tomorrow -o $@

$(GALLERY)/%.png : $(GALLERY)/%.unoptimized.png
	pngcrush -q -brute $< $@ || mv $< $@

$(README) : script/make-readme $(GALLERY)/.gitignore $(SRCS) $(STLS) $(IMAGES) $(ICONS)
	script/make-readme > $@

.PHONY : clean
clean :
	rm -f $(STLS) $(IMAGES) $(ICONS)

# EOF
