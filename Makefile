CROSS_COMPILE=arm-none-eabi-
OBJCOPY=$(CROSS_COMPILE)objcopy

TARGET_NAME=thumbv7m-none-eabi
# Raspberry Pi:
#TARGET_NAME=arm-unknown-linux-gnueabihf

BUILD_PREFIX=target/$(TARGET_NAME)
DEBUG_BUILD_PREFIX=$(BUILD_PREFIX)/debug

KERNEL_ELF=$(DEBUG_BUILD_PREFIX)/emmaos
KERNEL_IMG=$(DEBUG_BUILD_PREFIX)/kernel.img

all: $(KERNEL_IMG)

$(KERNEL_ELF): src/main.rs
	xargo build --target $(TARGET_NAME)

$(KERNEL_IMG): $(KERNEL_ELF)
	$(OBJCOPY) -O binary $(KERNEL_ELF) $(KERNEL_IMG)

core:
	rustup target add $(TARGET_NAME)

clean:
	xargo clean
