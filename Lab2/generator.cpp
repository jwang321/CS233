// a code generator for the ALU chain in the 32-bit ALU
// look at example_generator.cpp for inspiration

// make generator
// ./generator

#include <cstdio>
using std::printf;

int
main() {
    int width = 32;
    for (int i = 0 ; i < width ; i ++) {
        printf("    dffe dffe%d(q[%d], d[%d], clk, enable, reset);\n", i, i, i);
    }
}