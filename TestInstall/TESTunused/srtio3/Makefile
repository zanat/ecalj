include ../Makefile.define

TARGET=srtio3

out1=out.lmf.$(TARGET)

all: help

help:
	@echo "Do not call this Makefile alone."

###########################################################
#----- subroutine test1.exec
define test1.exec
	#-------------------------------------------
	# Case srtio3: an oxide with local orbitals.
	#-------------------------------------------
	#
	# --- Test 1.  Basic check of programs lmfa,lmf ---
	#
	@cat message.test1.$(TARGET)
	$(bindir)/lmfa -vfrz=f -vtiz=.00 -veloc=0 srtio3 > $1 2>&1
	$(bindir)/lmf  -vfrz=f -vtiz=.00 -veloc=0 srtio3 >> $1 2>&1
	rm mixm.srtio3
	$(bindir)/lmf  -vfrz=f -vtiz=.01 -veloc=0 srtio3 --rs=11,1,1 >> $1 2>&1
	rm mixm.srtio3
	$(bindir)/lmf  -vfrz=f -vtiz=.01 -veloc=0 srtio3 --rs=11,0,1 \
		-vpwmode=1 >> $1 2>&1
	rm mixm.srtio3
	$(bindir)/lmf  -vfrz=f -vtiz=.01 -veloc=1 srtio3 --rs=11,1,1,1,1 >> $1 2>&1
endef

###########################################################
# exec default case for $(TARGET).
$(TARGET).exec:
	$(call test1.exec,$(out1))
	$(call test1.check,$(REFDIR)/$(out1),$(out1))

# check default case for $(TARGET).
$(TARGET).check:
	$(call test1.check,$(REFDIR)/$(out1),$(out1))

# exec case1 for $(TARGET).
$(TARGET).case1.exec:
	@echo "nothing to exec for $@"

# check case1 for $(TARGET).
$(TARGET).case1.check:
	@echo "nothing to check for $@"
