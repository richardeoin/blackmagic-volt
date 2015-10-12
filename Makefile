all: Parts.md schematic board

Parts.md: parts
	ruby ./partslist/parts.rb

schematic: blackmagic_richardeoin.sch.pdf blackmagic_richardeoin.sch.png
board: blackmagic_richardeoin.brd.pdf blackmagic_richardeoin.brd.png

.PHONY: clean
clean:
	rm Parts.md
	rm blackmagic_richardeoin.sch.pdf
	rm blackmagic_richardeoin.sch.png
	rm blackmagic_richardeoin.brd.pdf
	rm blackmagic_richardeoin.brd.png

#
# PNG from .sch
#
%.sch.png: %.sch
	rm -f $@
	eagle -C "export image $@ 300; display all; quit" $<
#
# PDF from .sch
# 1 page lanscape
#
%.sch.pdf: %.sch
	rm -f $@
	eagle -C "print -1 landscape file $@; quit" $<
#
# PNG from .brd
# Ratsnest, maximum dpi
#
%.brd.png: %.brd
	rm -f $@
	eagle -C "ratsnest; export image $@ 1800; display all; quit" $<
#
# PDF from .brd
# -1 limits to one page
#
%.brd.pdf: %.brd
	rm -f $@
	eagle -C "ratsnest; print 100 -1 file $@; quit" $<
