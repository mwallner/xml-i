CXX = g++
CXXFLAGS = -std=c++20 -O3 -Wall -Wextra -pedantic

XERCESC_INC = /usr/include/xercesc
XERCESC_LIB = /usr/lib

CPP_TARGET = bin/xml-i-cpp
DOTNET_TARGET = bin/xml-i-dotnet

CPP_SRCS = C++/src/main.cpp
CPP_OBJS = $(CPP_SRCS:.cpp=.o)

all: $(CPP_TARGET) $(DOTNET_TARGET)

$(CPP_TARGET): $(CPP_OBJS)
		$(CXX) $(CXXFLAGS) -I$(XERCESC_INC) -L$(XERCESC_LIB) -lxerces-c -o $@ $^

%.o: %.cpp
		$(CXX) $(CXXFLAGS) -I$(XERCESC_INC) -c $< -o $@

$(DOTNET_TARGET):
		dotnet publish NET/src -c Release -o bin/dotnet

clean:
		rm -f $(CPP_OBJS) $(CPP_TARGET)
		rm -rf bin/dotnet

.PHONY: all clean
