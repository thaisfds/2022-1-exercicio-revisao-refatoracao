#Directories
MAIN_SRCDIR = ./src
SECONDARY_SRCDIR = $(MAIN_SRCDIR)/objects
OBJDIR = ./build
INCDIR = ./include

#Compiler
CC = g++

#Executable name
EXEC = L02E05

#Prepare output names (change .cpp to .o)
SRC = $(wildcard $(SECONDARY_SRCDIR)/*.cpp $(MAIN_SRCDIR)/*.cpp)
OBJ = $(addprefix $(OBJDIR)/,$(notdir $(SRC:.cpp=.o)))

#Compiler flags
CFLAGS = -I $(INCDIR) -Wall -pedantic -std=c++11

#(.PHONY prevents Make from running a system command called "compile" for some reason)
#Compile from source
.PHONY : compile
compile: $(OBJ)

$(OBJDIR)/%.o: $(SECONDARY_SRCDIR)/%.cpp
	$(CC) -c $(CFLAGS) $< -o $@

$(OBJDIR)/%.o: $(MAIN_SRCDIR)/%.cpp
	$(CC) -c $(CFLAGS) $< -o $@

#Link everything into an executable
.PHONY : link
link: compile
	@printf "\033[36mLinking build files:\033[0m\n"
	$(CC) -o $(EXEC) $(OBJDIR)/*.o

#Run the executable
.PHONY : run
run:
	@printf "\033[36mRunning executable file:\033[0m\n"
	./$(EXEC)

#Clean build and executable files
.PHONY : clean
clean:
	@printf "\033[36mDeleting executable and build files:\033[0m\n"
	rm -f $(EXEC)
	rm -f $(EXEC).exe
	rm -f $(OBJDIR)/*.o