CC := gcc
TARGET := razer-kbd-osx
SRC := src
OUT := build

SOURCES := $(wildcard $(SRC)/*.c)
LIBS := $(OUT)/librazer.a
OBJECTS := $(patsubst $(SRC)/%.c, $(OUT)/%.o, $(SOURCES))

all: $(TARGET) pyrazer

install: $(TARGET)
	cp $(TARGET) ~/bin/

clean:
	rm -rf $(OUT) $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) -framework CoreFoundation -framework IOKit -o $@ $^
 
$(OUT)/%.o: $(SRC)/%.c | $(OUT)
	$(CC) -I$(SRC) -c $< -o $@

$(OUT):
	mkdir -p $@

$(OUT)/librazer.a: $(OBJECTS)
	ar rcs $@ $^

pyrazer: setup.py $(SRC)/pyrazer.pyx $(OUT)/librazer.a
	python3 setup.py build_ext --inplace && rm -f $(SRC)/pyrazer.c || rm -f $(SRC)/pyrazer.c
