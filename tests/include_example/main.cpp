#include "include_example/square.h"

#include <stdio.h>

int main() {
    float vin[10];
	float vout[10];
	
    for (int i = 0; i < 10; ++i) {
        vin[i] = i;
	}
       
    ispc::square(vin, vout, 10);

    for (int i = 0; i < 10; ++i) {
		printf("%d: simple(%f) = %f\n", i, vin[i], vout[i]);
	}
}
