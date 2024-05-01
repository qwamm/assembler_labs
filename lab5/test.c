#include <stdio.h>

extern unsigned char compute_pixel(int, int);

int main()
{
	printf("%d\n", compute_pixel(3,4));
}
