FILESTEM=slamschool
MOVIESFIGSDIR=/home/ajd

# Default target does "make quick" which generates slides without anti-aliasing
# "make html" does anti-aliasing

quick: $(FILESTEM).textalk/index.html

$(FILESTEM).textalk/index.html: $(FILESTEM).dvi
	textalk -r 1 $(FILESTEM)

$(FILESTEM).dvi: $(FILESTEM).tex Figsajd Moviesajd ns
	cp ~/Demo/ActiveSearchPoints/feature_info $(FILESTEM).textalk/dummy.activesearchpoints
	cp ~/Demo/ActiveSearchEdgesPoints/feature_info $(FILESTEM).textalk/dummy.activesearchedgespoints
	- textalk latex $(FILESTEM)

Moviesajd:
	ln -s $(MOVIESFIGSDIR)/$@ .
Figsajd:
	ln -s $(MOVIESFIGSDIR)/$@ .
ns:
	echo "firefox ./$(FILESTEM).textalk/index.html &" > ns
	chmod 755 ns


html: $(FILESTEM).dvi
	textalk $(FILESTEM)

clean: 
	rm -rf *~ *.aux *.log *.dvi $(FILESTEM).textalk $(FILESTEM).ps
	rm -f Figsajd Moviesajd ns
