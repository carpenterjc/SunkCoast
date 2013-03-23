UNAME := $(shell uname)

LIB_INCLUDE_PATH = 
LIB_BIN_PATH =
GL_LIBS =

ifeq ($(UNAME), MINGW32_NT-5.1)
	DEVIL_PATH=input/devil
	GLFW_PATH=input/glfw
	LIB_INCLUDE_PATH = -I$(DEVIL_PATH)/include -I$(GLFW_PATH)/include
	LIB_BIN_PATH = -L$(DEVIL_PATH)/lib -L$(GLFW_PATH)/lib-mingw
	GL_LIBS = -lglfw -lglu32 -lopengl32 -lDevIL
endif
ifeq ($(UNAME), Linux)
	GL_LIBS = -lGL -lGLU -lIL -lglfw
endif
ifeq ($(UNAME), Darwin)
	GL_LIBS = -framework OpenGL -lIL -lglfw -headerpad_max_install_names
endif

CC = gcc

CFLAGS = -Isrc $(LIB_INCLUDE_PATH) -Wall -Wextra -Werror -g
LIB_DEPS = $(LIB_BIN_PATH) $(GL_LIBS)

BUILD_DIR = build
OBJ_DIR = build/obj
OUT_DIR=$(BUILD_DIR)/out
DATA_OUT=$(OUT_DIR)/data
DATA=$(DATA_OUT)/font.png

EXE = $(OUT_DIR)/sunkcoast
CORE_SRC = 
GAME_SRC = 
GAME_HEADERS =
EDITOR_SRC =
EDITOR_HEADERS =

OSXAPP_DIR = $(OUT_DIR)/SunkCoast.app
OSX_DATA_OUT = $(OSXAPP_DIR)/Contents/MacOS/data

OSXBUNDLEITEMS = $(OSXAPP_DIR)/Contents/MacOS/launch.sh
OSXBUNDLEITEMS += $(OSXAPP_DIR)/Contents/Info.plist
OSXBUNDLEITEMS += $(OSXAPP_DIR)/Contents/MacOS/sunkcoast
OSXBUNDLEITEMS += $(OSXAPP_DIR)/Contents/MacOS/libIL.1.dylib
OSXBUNDLEITEMS += $(OSXAPP_DIR)/Contents/MacOS/libglfw.dylib
OSXBUNDLEITEMS += $(OSX_DATA_OUT)/font.png


osxbundle: $(OUT_DIR)/readme.txt $(OSXBUNDLEITEMS)

all: $(EXE) $(DATA) $(OUT_DIR)/readme.txt

SRC += datatypes.c
SRC += main.c
SRC += game/game.c
SRC += game/item.c
SRC += game/spawn.c
SRC += input/libastar/astar.c
SRC += input/libastar/astar_heap.c
SRC += input/libfov/fov.c
SRC += sys/file.c
SRC += sys/logging.c
SRC += sys/sys.c
SRC += world/feature.c
SRC += world/tilemap.c

HEADERS := $(patsubst %.c,src/%.h,$(SRC)) src/sys/logging.h
OBJ := $(patsubst %.c,$(OBJ_DIR)/%.o,$(SRC))

$(OBJ_DIR)/%.o: src/%.c $(HEADERS)
	mkdir -p $(dir $@)
	$(CC) -c $(CFLAGS) $< -o $@

clean:
	rm -rf $(BUILD_DIR)

$(EXE): $(OBJ)
	mkdir -p $(dir $@)
	$(CC) $(OBJ) $(LIB_DEPS) -o $@

$(DATA_OUT)/%: data/%
	mkdir -p $(dir $@)
	cp $< $@

$(OUT_DIR)/readme.txt: README
	mkdir -p $(dir $@)
	cp $< $@

$(OSXAPP_DIR)/Contents/Info.plist: package/Info.plist
	mkdir -p $(dir $@)
	cp $< $@

$(OSXAPP_DIR)/Contents/MacOS/launch.sh: package/launch.sh
	mkdir -p $(dir $@)
	cp $< $@
	chmod 711 $@

$(OSXAPP_DIR)/Contents/MacOS/sunkcoast: $(EXE)
	mkdir -p $(dir $@)
	cp $< $@
	install_name_tool -change /usr/local/opt/devil/lib/libIL.1.dylib @executable_path/libIL.1.dylib $@
	install_name_tool -change /usr/local/opt/glfw/lib/libglfw.dylib @executable_path/libglfw.dylib $@

$(OSXAPP_DIR)/Contents/MacOS/libIL.1.dylib: /usr/local/opt/devil/lib/libIL.1.dylib
	mkdir -p $(dir $@)
	cp $< $@

$(OSXAPP_DIR)/Contents/MacOS/libglfw.dylib: /usr/local/opt/glfw/lib/libglfw.dylib
	mkdir -p $(dir $@)
	cp $< $@

$(OSX_DATA_OUT)/%: data/%
	mkdir -p $(dir $@)
	cp $< $@

