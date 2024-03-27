include MakefileBase

# top-level makefile to build all modules and produce kernel image

BUILD_DIR = build
MODULE_DIRS = $(wildcard ./*/)
MODULES = $(filter-out $(BUILD_DIR), $(patsubst ./%/,%,$(MODULE_DIRS)))
MODULE_OBJECT_LOCATION = $(addsuffix /$(BUILD_DIR)/$(notdir $(1)).o, $(1))
MODULES_OBJECTS = $(foreach module, $(MODULES), $(call MODULE_OBJECT_LOCATION,$(module)))

all: shale.elf

$(MODULES_OBJECTS):
	$(info "MAKE $@")
	$(MAKE) -C $(basename $(notdir $@))

shale.elf: $(MODULES_OBJECTS)
	$(info "BUILDING KERNEL...")
	$(LD) -T link.lds -o $@ $^

run: shale.elf
	qemu-system-riscv64 -m 128M -machine virt -nographic -kernel shale.elf -bios none -smp 4

run-for-debug: shale.elf
	qemu-system-riscv64 -m 128M -s -S -machine virt -nographic -kernel shale.elf -bios none

debug:
	riscv64-unknown-elf-gdb ./shale.elf -x debug.gdb

clean:
	@for module in $(MODULES); do\
		$(MAKE) -C $$module clean;\
	done

info:
	$(info module directories: "$(MODULE_DIRS)")
	$(info modules: "$(MODULES)")
	$(info module objects: "$(MODULES_OBJECTS)")