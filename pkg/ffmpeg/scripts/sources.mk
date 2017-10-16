VARS := $(file < vars.txt)

DIRS :=\
	libavcodec\
	libavdevice\
	libavfilter\
	libavformat\
	libavutil\
	libswresample\
	libswscale

ARCHS :=\
	x86

define printsrcs
	@echo $(1) $(foreach dir,$(DIRS),\
		$(OBJS-$(1)/$(dir):%.o=$(dir)/%.c)\
		$(MMX-OBJS-$(1)/$(dir):%.o=$(dir)/%.c)\
		$(X86ASM-OBJS-$(1)/$(dir):%.o=$(dir)/%.asm)\
	)

endef

.PHONY: all
all: vars.txt
	$(foreach var,$(VARS),$(call printsrcs,$(var)))

define subdir
	$(foreach var,$(VARS),$(eval $(var):=$(var)/$(1)))
	include ../src/$(1)/Makefile
	$(foreach arch,$(ARCHS),
		-include ../src/$(1)/$(arch)/Makefile
	)
endef

$(foreach dir,$(DIRS),$(eval $(call subdir,$(dir))))
