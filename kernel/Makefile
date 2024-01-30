.SUFFIXES:
CC=
AS=riscv64-unknown-elf-as
LD=riscv64-unknown-elf-ld

OBJDIR = build

programs: shale.elf

SOURCE_FILES = $(basename $(wildcard *.sb))
COMPILED_ASMS = $(SOURCE_FILES:%=%.S)
SHALE_OBJS = start.o $(SOURCE_FILES:%=%.o)

$(OBJDIR)/%.o : %.S
	@mkdir -p $(@D)
	$(AS) $< -r -o $@ 

$(OBJDIR)/%.o : $(OBJDIR)/%.S
	@mkdir -p $(@D)
	$(AS) $< -r -o $@ 

$(OBJDIR)/%.S : %.sb
	@mkdir -p $(@D)
	@sbcc -i $< -o $@

compileonly: $(addprefix $(OBJDIR)/,$(COMPILED_ASMS))


shale.elf: $(addprefix $(OBJDIR)/,$(SHALE_OBJS))
	$(LD) -T link.lds -o $@ $^

run: shale.elf
	qemu-system-riscv64 -m 128M -machine virt -nographic -kernel shale.elf -bios none

run-for-debug: shale.elf
	qemu-system-riscv64 -m 128M -s -S -machine virt -nographic -kernel shale.elf -bios none

debug:
	riscv64-unknown-elf-gdb ./shale.elf -x debug.gdb

clean:
	rm $(OBJDIR)/*
	rm -f shale.elf

info:
	$(info asm files: "$(ASM_FILES)")
	$(info substratum source files: "$(SOURCE_FILES)")
	$(info substratum asm files: "$(COMPILED_ASMS)")
	$(info object files: "$(SHALE_OBJS)")
	