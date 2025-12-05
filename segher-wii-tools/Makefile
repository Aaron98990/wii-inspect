PROGS = twintig zestig zeventig tachtig negentig
PROGS += tpl2ppm dol2elf tmd-dump zelda-cksum lego-cksum
COMMON = tools.o bn.o ec.o
DEFINES = -DLARGE_FILES -D_FILE_OFFSET_BITS=64
LIBS = -lcrypto

# Auto-detect OpenSSL path based on system and available tools
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
    # macOS - check for Homebrew OpenSSL
    OPENSSL_PREFIX := $(shell brew --prefix openssl 2>/dev/null || echo /usr/local)
else
    # Linux and other Unix-like systems - use pkg-config or standard paths
    OPENSSL_PREFIX := $(shell pkg-config --variable=prefix openssl 2>/dev/null || echo /usr/local)
endif

# OPENSSL_PREFIX = <REPLACE WITH YOUR CUSTOM PATH IF NEEDED>

CC = gcc
CFLAGS = -Wall -W -Os -I$(OPENSSL_PREFIX)/include
LDFLAGS = -L$(OPENSSL_PREFIX)/lib -lcrypto


OBJS = $(patsubst %,%.o,$(PROGS)) $(COMMON)

all: $(PROGS)

$(PROGS): %: %.o $(COMMON) Makefile
	$(CC) $(CFLAGS) $(LDFLAGS) $< $(COMMON) $(LIBS) -o $@

$(OBJS): %.o: %.c tools.h Makefile
	$(CC) $(CFLAGS) $(DEFINES) -c $< -o $@

clean:
	-rm -f $(OBJS) $(PROGS)
