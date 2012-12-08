
DC = dmd
LIB = loggd
SRCDIR = src/loggd
INCDIR = include/loggd
DFLAGS = -lib -of$(LIB) -Isrc/ -H -Hd$(INCDIR)
FILES = $(shell echo $(SRCDIR)/*.d)
#FILES = $(addprefix $(SRCDIR), $(modules))

.PHONY : clean samples

all: $(INCDIR) release samples

$(INCDIR):
	mkdir -p $(INCDIR)

release:
	$(DC) $(DFLAGS) -release -O $(FILES) 

debug:
	$(DC) $(DFLAGS) -unittest -debug $(FILES) 

samples:
	cd samples && $(DC) test.d ../loggd.a -I../include/

clean:
	- rm $(LIB).a $(INCDIR)/*.di
	- rm -f samples/*.o
	- rm -f samples/test

