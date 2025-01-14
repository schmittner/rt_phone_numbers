OBJS = build/Public.o build/ChainWalkContext.o build/ChainWalkSet.o build/CrackEngine.o build/HashAlgorithm.o build/HashSet.o build/HashRoutine.o build/MemoryPool.o build/RainbowCrack.o build/RainbowTableDump.o build/RainbowTableGenerate.o build/RainbowTableSort.o build/csv.o build/PrefixParser.o build/HashGenerator.o

all: rtgen rtdump rtsort rcrack hashgen

# Build hacks for DragonFlyBSD (run "pkg install openssl" first)
LDFLAGS += -L/usr/local/lib -I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib -lgmp -lomp
CXXFLAGS += -std=c++11 -Xpreprocessor -fopenmp

build/ChainWalkContext.o: src/ChainWalkContext.cpp
	$(CXX) $(CXXFLAGS) -c src/ChainWalkContext.cpp -I/usr/local/include -O3 -o build/ChainWalkContext.o

build/HashAlgorithm.o: src/HashAlgorithm.cpp
	$(CXX) $(CXXFLAGS) -c src/HashAlgorithm.cpp -I/usr/local/include -O3 -o build/HashAlgorithm.o

build/RainbowCrack.o: src/RainbowCrack.cpp
	$(CXX) $(CXXFLAGS) -c src/RainbowCrack.cpp -I/usr/local/include -O3 -o build/RainbowCrack.o

build/csv.o: src/csv.h
	$(CXX) $(CXXFLAGS) -c src/csv.h -I/usr/local/include -O3 -o build/csv.o -lpthread

build/PrefixParser.o: src/PrefixParser.cpp
	$(CXX) $(CXXFLAGS) -c src/PrefixParser.cpp -I/usr/local/include -O3 -o build/PrefixParser.o

build/Public.o: src/Public.cpp
	$(CXX) $(CXXFLAGS) -c src/Public.cpp -I/usr/local/include -O3 -o build/Public.o

build/ChainWalkSet.o: src/ChainWalkSet.cpp
	$(CXX) $(CXXFLAGS) -c src/ChainWalkSet.cpp -I/usr/local/include -O3 -o build/ChainWalkSet.o

build/CrackEngine.o: src/CrackEngine.cpp
	$(CXX) $(CXXFLAGS) -c src/CrackEngine.cpp -I/usr/local/include -O3 -o build/CrackEngine.o

build/HashSet.o: src/HashSet.cpp
	$(CXX) $(CXXFLAGS) -c src/HashSet.cpp -I/usr/local/include -O3 -o build/HashSet.o

build/HashRoutine.o: src/HashRoutine.cpp
	$(CXX) $(CXXFLAGS) -c src/HashRoutine.cpp -I/usr/local/include -O3 -o build/HashRoutine.o

build/MemoryPool.o: src/MemoryPool.cpp
	$(CXX) $(CXXFLAGS) -c src/MemoryPool.cpp -I/usr/local/include -O3 -o build/MemoryPool.o

build/RainbowTableDump.o: src/RainbowTableDump.cpp
	$(CXX) $(CXXFLAGS) -c src/RainbowTableDump.cpp -I/usr/local/include -O3 -o build/RainbowTableDump.o

build/RainbowTableGenerate.o: src/RainbowTableGenerate.cpp
	$(CXX) $(CXXFLAGS) -c src/RainbowTableGenerate.cpp -I/usr/local/include -O3 -o build/RainbowTableGenerate.o

build/RainbowTableSort.o: src/RainbowTableSort.cpp
	$(CXX) $(CXXFLAGS) -c src/RainbowTableSort.cpp -I/usr/local/include -O3 -o build/RainbowTableSort.o

build/HashGenerator.o: src/HashGenerator.cpp
	$(CXX) $(CXXFLAGS) -c src/HashGenerator.cpp -I/usr/local/include -O3 -o build/HashGenerator.o


rtgen: $(OBJS)
	$(CXX) $(CXXFLAGS) -O3 $(LDFLAGS) build/PrefixParser.o build/Public.o build/ChainWalkContext.o build/HashAlgorithm.o build/HashRoutine.o build/RainbowTableGenerate.o -lssl -lcrypto -lpthread -o bin/rtgen

rtdump: $(OBJS)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) build/PrefixParser.o build/Public.o build/ChainWalkContext.o build/HashAlgorithm.o build/HashRoutine.o build/RainbowTableDump.o -lssl -lcrypto -lpthread -o bin/rtdump

rtsort: $(OBJS)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) build/Public.o build/RainbowTableSort.o -o bin/rtsort

rcrack: $(OBJS)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) build/PrefixParser.o build/Public.o build/ChainWalkContext.o build/HashAlgorithm.o build/HashRoutine.o build/HashSet.o build/MemoryPool.o build/ChainWalkSet.o build/CrackEngine.o build/RainbowCrack.o -lssl -lcrypto -lpthread -o bin/rcrack

hashgen: $(OBJS)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) build/Public.o build/PrefixParser.o build/ChainWalkContext.o build/HashAlgorithm.o build/HashRoutine.o build/HashGenerator.o -lssl -lcrypto -lpthread -o bin/hashgen

clean:
	rm -f $(OBJS) bin/rtgen bin/rtdump bin/rtsort bin/rcrack bin/hashgen
