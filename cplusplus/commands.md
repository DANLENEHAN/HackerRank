### Complie a C++ file
```bash
clang++ -std=c++17 -o hello hello.cpp
```
### Run a C++ file
```bash
./hello
```

C++ Memory graphic
```bash
+------------------+
|   Code Segment   |  (Executable instructions)
+------------------+
|   Data Segment   |  (Initialized global/static variables)
+------------------+
|   BSS Segment    |  (Uninitialized global/static variables)
+------------------+
|      Heap        |  (Dynamically allocated memory)
|                  |  
|                  |
+------------------+
|      Stack       |  (Local variables, function call frames)
+------------------+
```
