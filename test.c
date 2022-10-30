#include <stdio.h>
#include <stdbool.h>
#include "Graph.h"
typedef int Vertex;
#define NODES 4;
void warshall() {
   int i, s, t;
   for (s = 0; s < NODES; s++)
      for (t = 0; t < NODES; t++)
	 tc[s][t] = digraph[s][t];

   for (i = 0; i < NODES; i++)
      for (s = 0; s < NODES; s++)
	 for (t = 0; t < NODES; t++)
	    if (tc[s][i] && tc[i][t])
	       tc[s][t] = 1;
}