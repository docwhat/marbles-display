# Makefile for building a gallery for easy viewing.

GALLERY := gallery

# Target the gallery directory
SCADS   = 
STLS    = $(SCADS:.scad=.stl)
ICONS   = $(SCADS:.scad=.icon.gif)
README  = $(GALLERY)/README.md
DEPENDENCY_FILE := .dependency.mk

.PHONY : all
all : deps scads stls icons readme

-include $(DEPENDENCY_FILE)

.PHONY : debug
debug :
	@printf -- "SCADS :  $(SCADS)\n"
	@printf -- "STLS :   $(STLS)\n"
	@printf -- "ICONS :  $(ICONS)\n"

.PHONY : deps
deps: $(DEPENDENCY_FILE)

.PHONY : gallery
gallery : $(SCADS) $(STLS) $(ICONS) $(README)

.PHONY: scads
scads : $(SCADS)

.PHONY : stls
stls : $(STLS)

.PHONY : icons
icons : $(ICONS)

.PHONY : readme
readme : $(GALLERY)/README.md

$(DEPENDENCY_FILE) : data.yaml Makefile script/make-deps
	script/make-deps > $@

$(SCADS) $(STLS) $(ICONS) : $(GALLERY)/.gitignore $(DEPENDENCY_FILE)

$(GALLERY)/.gitignore :
	mkdir -p $(GALLERY)
	touch $(GALLERY)/.gitignore

$(GALLERY)/%.stl : $(GALLERY)/%.scad
	openscad $< -o $@

$(GALLERY)/%.icon.gif : $(GALLERY)/%.scad
	script/openscad-animate $<

$(README) : script/make-readme $(GALLERY)/.gitignore $(SCADS) $(STLS) $(ICONS) $(DEPENDENCY_FILE)
	script/make-readme > $@

.PHONY : clean
clean :
	rm -f $(SCADS) $(STLS) $(ICONS) $(DEPENDENCY_FILE) $(README)

# EOF
