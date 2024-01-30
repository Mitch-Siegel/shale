CC=sbcc
AS=riscv64-unknown-elf-as
LD=riscv64-unknown-elf-ld

OBJDIR = build

programs: shale.elf

ASM_FILES = $(basename $(wildcard *.S))
SOURCE_FILES = $(basename $(wildcard *.sb))
COMPILED_ASMS = $(SOURCE_FILES:%=%.S)
SHALE_OBJS = $(SOURCE_FILES:%=%.o)$(ASM_FILES:%=%.o)

$(OBJDIR)/%.o : %.S
	@mkdir -p $(@D)
	$(AS) $< -r -o $@ 

shale.elf: $(addprefix $(OBJDIR)/,$(SHALE_OBJS))
	$(LD) -T link.lds -o $@ $^

run: shale.elf
	qemu-system-riscv64 -machine virt -nographic -kernel shale.elf -bios none

run-for-debug: shale.elf
	qemu-system-riscv64 -s -S -machine virt -nographic -kernel shale.elf -bios none

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
	