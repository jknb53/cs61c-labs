# ====================================================================
# Universal Makefile for CS61C RISC-V Drills (v2.4 - Robust Final)
#
# Handles non-zero exit codes gracefully and correctly reports them.
# ====================================================================

CC = riscv64-unknown-elf-gcc
CFLAGS = -nostdlib -march=rv64imafd -mabi=lp64d -Wl,--section-start=.text=0x10000 -Wl,--section-start=.data=0x20000
QEMU = qemu-riscv64

TARGET ?= # Must be provided from command line

SRC = $(TARGET).s
EXEC = $(TARGET)

.PHONY: all run clean

all: $(EXEC)

$(EXEC): $(SRC)
	@echo "Compiling $(SRC) -> $(EXEC)..."
	@$(CC) -o $(EXEC) $(SRC) $(CFLAGS)

run: $(EXEC)
	@echo "Running $(EXEC)..."
	# This shell magic runs qemu, saves its exit code, and then exits with 0
	# so that 'make' doesn't complain.
	@{ \
	    $(QEMU) $(EXEC); \
	    EXIT_CODE=$$?; \
	    echo "--- Program exited with code: $$EXIT_CODE ---"; \
	    exit 0; \
	}

clean:
	@echo "Cleaning compiled file for $(TARGET)..."
	@rm -f $(EXEC)