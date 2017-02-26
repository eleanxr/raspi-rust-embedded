CROSS_COMPILE=arm-none-eabi-

# TARGET_NAME=thumbv7m-none-eabi
# Raspberry Pi:
TARGET_NAME=arm-unknown-linux-gnueabihf

OBJCOPY=$(CROSS_COMPILE)objcopy
OBJDUMP=$(CROSS_COMPILE)objdump

BUILD_PREFIX=target/$(TARGET_NAME)
DEBUG_BUILD_PREFIX=$(BUILD_PREFIX)/debug

KERNEL_ELF=$(DEBUG_BUILD_PREFIX)/emmaos
KERNEL_IMG=$(DEBUG_BUILD_PREFIX)/kernel.img

all: $(KERNEL_IMG)

$(KERNEL_ELF): src/main.rs .cargo/config ld/raspi.ld
	xargo build --target $(TARGET_NAME)

$(KERNEL_IMG): $(KERNEL_ELF)
	$(OBJCOPY) -O binary $(KERNEL_ELF) $(KERNEL_IMG)

core:
	rustup target add $(TARGET_NAME)

qemu: $(KERNEL_IMG)
	qemu-system-arm -M raspi2 --nographic -bios $(KERNEL_IMG)

qemu-gdb: $(KERNEL_IMG)
	qemu-system-arm -M raspi2 --nographic -s -S -bios $(KERNEL_IMG)

kerneldump:
	$(OBJDUMP) -CD $(KERNEL_ELF)

clean:
	xargo clean
