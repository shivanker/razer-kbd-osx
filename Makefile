CC := gcc
TARGET := razer-kbd-osx
SRC := src
OUT := build

SOURCES := $(filter-out $(SRC)/pyrazer.c, $(wildcard $(SRC)/*.c))
LIBS := $(OUT)/librazer.a
OBJECTS := $(patsubst $(SRC)/%.c, $(OUT)/%.o, $(SOURCES))

all: $(TARGET) pyrazer

install: $(TARGET) pyrazer
	mkdir -p ~/bin
	cp $(TARGET) ~/bin/
	python3 setup.py install && rm -f $(SRC)/pyrazer.c || rm -f $(SRC)/pyrazer.c

clean:
	python3 setup.py clean
	rm -rf $(OUT) $(TARGET) $(SRC)/pyrazer.c pyrazer.cpython-*

$(TARGET): $(OBJECTS)
	$(CC) -framework CoreFoundation -framework IOKit -o $@ $^
 
$(OUT)/%.o: $(SRC)/%.c | $(OUT)
	$(CC) -I$(SRC) -c $< -o $@

$(OUT):
	mkdir -p $@

$(OUT)/librazer.a: $(OBJECTS)
	ar rcs $@ $^

pyrazer: setup.py $(SRC)/pyrazer.pyx $(OUT)/librazer.a
	python3 setup.py build_ext --inplace > $(OUT)/cython.log && rm -f $(SRC)/pyrazer.c || rm -f $(SRC)/pyrazer.c
