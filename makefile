# You can use variables in Makefiles in order to make all of the repetitive
# typing much easier. Here, we include the C++11 version flag as well as
# additional warning flags to make compilation stricter (and, thus, our programs
# safer).
#
CXXFLAGS := -Wall -Wextra -pedantic -std=c++11

SRC_DIR := ./src
OBJ_DIR := ./obj
INCLUDE_DIRS := -I./dep/ -I./include/

# Here, we are calling functions available in GNU Make in order to get all of
# the .o and .cpp files in ./src so we can use them in our rules later.
SRC_FILES := $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SRC_FILES))

all: ./bin/test-FiveLetterWordScramble_Mode.out

# This build each of the .cpp in the src dir into a .o
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	g++ $(INCLUDE_DIRS) $(CPPFLAGS) $(CXXFLAGS) -c -o  $@ $<

./bin/test-FiveLetterWordScramble_Mode.out: $(OBJ_FILES) ./tst/test-FiveLetterWordScramble_Mode.cpp ./include/*.hpp
	g++ $(CPPFLAGS) $(CXXFLAGS) $(INCLUDE_DIRS) \
		-o ./bin/test-FiveLetterWordScramble_Mode.out \
		./tst/test-FiveLetterWordScramble_Mode.cpp $(OBJ_FILES)
	./bin/test-FiveLetterWordScramble_Mode.out

# Convenience rules for the command line to quickly test a class

FiveLetterWordScramble_Mode: ./bin/test-FiveLetterWordScramble_Mode.out

clean:
	rm ./src/*.o
	rm ./bin/*.out
