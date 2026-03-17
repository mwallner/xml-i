#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define BUF_SIZE 64 * 1024

unsigned long parse_xml(FILE *f, int argc, char **argv)
{
	char buf[BUF_SIZE];
	unsigned long l = 0;
	while (fgets(buf, sizeof(buf), f))
	{
		char *p = buf;
		l += (int)*p;
	}
	return l;
}

int main(int argc, char **argv)
{
	if (argc < 2)
	{
		printf("Usage: %s <file>\n", argv[0]);
		return 1;
	}
	FILE *f = fopen(argv[1], "r");
	if (!f)
	{
		perror("Error opening file");
		return 1;
	}
	unsigned long l = parse_xml(f, argc, argv);
	fclose(f);
	printf("sum of first chars: %lu\n", l);

	return 0;
}
