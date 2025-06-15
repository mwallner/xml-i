#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_NODES 256
#define MAX_NAME 128
#define BUF_SIZE 4096

typedef struct
{
	char name[MAX_NAME];
	int count;
} NodeCount;

NodeCount node_counts[MAX_NODES];
int node_count_len = 0;

int filter_match(const char *name, int argc, char **argv)
{
	if (argc <= 2)
		return 1; // no filter
	for (int i = 2; i < argc; ++i)
	{
		if (strcmp(name, argv[i]) == 0)
			return 1;
	}
	return 0;
}

void add_node(const char *name, int argc, char **argv)
{
	if (!filter_match(name, argc, argv))
		return;
	for (int i = 0; i < node_count_len; ++i)
	{
		if (strcmp(node_counts[i].name, name) == 0)
		{
			node_counts[i].count += 1;
			return;
		}
	}
	if (node_count_len < MAX_NODES)
	{
		strncpy(node_counts[node_count_len].name, name, MAX_NAME - 1);
		node_counts[node_count_len].name[MAX_NAME - 1] = '\0';
		node_counts[node_count_len].count = 1;
		node_count_len++;
	}
}

void parse_xml(FILE *f, int argc, char **argv)
{
	char buf[BUF_SIZE];
	while (fgets(buf, sizeof(buf), f))
	{
		char *p = buf;
		while ((p = strchr(p, '<')))
		{
			p++; // skip '<'
			if (*p == '/' || *p == '?' || *p == '!')
			{
				p++;
				continue;
			}
			char name[MAX_NAME] = {0};
			int i = 0;
			while (*p && !isspace(*p) && *p != '>' && *p != '/' && i < MAX_NAME - 1)
			{
				name[i++] = *p++;
			}
			name[i] = '\0';
			if (i > 0)
				add_node(name, argc, argv);
		}
	}
}

int main(int argc, char **argv)
{
	if (argc < 2)
	{
		printf("Usage: %s <xml_file> [node1 node2 ...]\n", argv[0]);
		return 1;
	}
	FILE *f = fopen(argv[1], "r");
	if (!f)
	{
		perror("Error opening file");
		return 1;
	}
	parse_xml(f, argc, argv);
	fclose(f);

	printf("Node counts:\n");
	for (int i = 0; i < node_count_len; ++i)
	{
		printf("%s: %d\n", node_counts[i].name, node_counts[i].count);
	}
	return 0;
}
