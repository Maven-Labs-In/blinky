#==== Main Options =============================================================

MCU = atmega328p
F_CPU = 16000000
TARGET = blinky


#==== Compile Options ==========================================================

CFLAGS = -mmcu=$(MCU) -I.
CFLAGS += -DF_CPU=$(F_CPU)UL
CFLAGS += -Os
#CFLAGS += -mint8
#CFLAGS += -mshort-calls
CFLAGS += -funsigned-char
CFLAGS += -funsigned-bitfields
CFLAGS += -fpack-struct
CFLAGS += -fshort-enums
#CFLAGS += -fno-unit-at-a-time
CFLAGS += -Wall
CFLAGS += -Wstrict-prototypes
CFLAGS += -Wundef
#CFLAGS += -Wunreachable-code
#CFLAGS += -Wsign-compare
CFLAGS += -std=gnu99

#==== Programming Options (avrdude) ============================================

AVRDUDE_PROGRAMMER = arduino
AVRDUDE_PORT = /dev/ttyUSB0
AVRDUDE_BAUD = 9600
AVRDUDE_FLAGS = -p $(MCU) -c $(AVRDUDE_PROGRAMMER) -P $(AVRDUDE_PORT)

#===============================================================================
#==== Targets ==================================================================

AVR_GCC_PATH = /usr/bin
CC = $(AVR_GCC_PATH)/avr-gcc
OBJCOPY = $(AVR_GCC_PATH)/avr-objcopy
SIZE = $(AVR_GCC_PATH)/avr-size
NM = $(AVR_GCC_PATH)/avr-nm
AVRDUDE = avrdude
REMOVE = rm -f

all: build

build:
	$(CC) -c $(CFLAGS) $(TARGET).c -o $(TARGET).o
	$(CC) $(CFLAGS) $(TARGET).o --output $(TARGET).elf
	$(OBJCOPY) -O ihex -j .text -j .data $(TARGET).elf $(TARGET).hex
	$(SIZE) -C --mcu=$(MCU) $(TARGET).elf
	#$(NM) $(TARGET).elf

program:
	$(AVRDUDE) $(AVRDUDE_FLAGS) $(AVRDUDE_WRITE_FLASH) -U flash:w:$(TARGET).hex

clean:
	$(REMOVE) "$(TARGET).hex"
	$(REMOVE) "$(TARGET).elf"
	$(REMOVE) "$(TARGET).o"
