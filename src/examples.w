\def\title{HPAPL: Runtime Examples}
\def\topofcontents{\null\vfill
  \centerline{\titlefont Examples of using the HPAPL Runtime}
  \vskip 15pt
  \centerline{(Version 1.0)}
  \vfill}
\def\botofcontents{\vfill
\noindent
Copyright $\copyright$ 2012 Aaron W. Hsu $\.{arcfide@@sacrideo.us}$
\smallskip\noindent
Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.
\smallskip\noindent
THE SOFTWARE IS PROVIDED ``AS IS'' AND THE AUTHOR DISCLAIMS ALL
WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
}
\def\idxbox{\mathrel{\lower0.3em\vbox{
  \hrule
  \hbox{\strut\vrule\thinspace\vrule}
  \hrule
}}}
\def\eachop{\mathrel{\ddot{ }}}

@* Introduction.
This document gives some examples of using the HPAPL runtime by hand. 
Normally this is a bad idea, but it will let you get an understanding 
of what an HPAPL compiler's output should look like. We progress from 
simple programs to those that become progressively more complex.
Each example can be run by executing the function with a single 
argument that is ``ex$n$'' where $n$ is the number of the example without 
any leading zeros.

\medskip{\parindent=0.3in
\item{1.}{\it Scalar addition.} A simple demonstration of scalar addition.
By computing $5+5$.
\par}\medskip

@p
#include <stdio.h>
#include <string.h>
@#
#include "hpapl.h"
@#
@<Ex 1. Compute $5+5$@>@;
@<Ex 2. ...@>@;
@<Ex 3. ...@>@;
@<Ex 4. ...@>@;
@<Ex 5. ...@>@;

int main(int argc, char *argv[])
{
	void (*example)(void);
	char *msg;
	
	if (argc != 2) { 
		printf("%s: ex<n>\nRun the <n>th example.\n\n", argv[0]);
		return 1;
	}@#
	
	@<Dispatch example based on |argv[1]|@>@;
	else {
		printf("Unknown example, please enter a valid example.\n");
		return 2;
	}@#
	
	printf("Running %s\n\n", msg);
	example();
	printf("\nFinished running the example, goodbye!\n\n");@#
	
	return 0;
}

@* Example 1. This example computes the sum of $5$ and $5$. It is the 
simplest sort of example that shows the basic setup necessary for such 
things. We do not take advantage of any of the more complicated elements
such as printing out array values, either. Instead, we will just print 
the field results.

@<Ex 1. Compute $5+5$@>=
void ex1(void) 
{
	AplArray z, x;
	init_array(&z);
	init_array(&x);
	alloc_array(&z, INT);
	alloc_array(&x, INT);
	x.data->intv = 5;
	plus(&z, &x, &x, NULL);
	printf("%d\n", z.data->intv);
	printf("Size: %lu\tRank: %d\t\tAllocated: %lu\n", 
	    size(&z), rank(&z), z.size);
	free_data(&z);
	free_data(&x);
}

@ @<Dispatch example based on |argv[1]|@>=
if (!strcmp(argv[1], "ex1")) {
	msg = "Ex 1: Computing 5 + 5";
	example = ex1;
}

@* Example 2. This example demonstrates the use of the iota index 
generation function. It should produce a set of numbers between $[0,10)$.

@<Ex 2. Compute $\iota 10$@>=
void ex2(void)
{
	short i;
	AplArray z, x;
	init_array(&z);
	init_array(&x);
	alloc_array(&x, INT);
	x.data->intv = 10;
	index_gen(&z, &x, NULL);
	for (i = 0; i < 10; i++)
		printf("%d ", z.data[i].intv);
	printf("\n");
	printf("Size: %lu\tRank: %d\t\tAllocated: %lu\n", 
	    size(&z), rank(&z), z.size);
	free_data(&x);
	free_data(&z);
}

@ @<Dispatch example based on |argv[1]|@>=
else if (!strcmp(argv[1], "ex2")) {
	msg = "Ex 2: Computing iota 10";
	example = ex2;	
} 

@* Example 3. In this example, we will combine the first two examples to 
show how we can share data structures. In other words, we will only 
double a single array to compute $(\iota 10)+\iota 10$. 

@<Ex 3. Compute $(\iota 10)+\iota 10$@>=
void ex3() 
{
	short i;
	AplArray z;
	init_array(&z);
	alloc_array(&z, INT);
	z.data->intv = 10;
	index_gen(&z, &z, NULL);
	plus(&z, &z, &z, NULL);
	for (i = 0; i < 10; i++)
		printf("%d ", z.data[i].intv);
	printf("\n");
	printf("Size: %lu\tRank: %d\t\tAllocated: %lu\n", 
	    size(&z), rank(&z), z.size);
	free_data(&z);
}

@ @<Dispatch example based on |argv[1]|@>=
else if (!strcmp(argv[1], "ex3")) {
	msg = "Ex 3: Computing (iota 10) + iota 10";
	example = ex3;
} 

@* Example 4. Let's show how we might use a reduction operator. This one 
uses the reduction operator $/$. We will compute $+/\iota 10$ which is 
the sum of the integers on the range $[0,10)$. 

@<Ex 4. Compute $+/\iota 10$@>=
void ex4()
{
	AplArray z;
	AplFunction add;
	AplFunction red;
	init_array(&z);
	alloc_array(&z, INT);
	z.data->intv = 10;
	index_gen(&z, &z, NULL);
	init_function(&add, NULL, plus, 0, NULL, NULL, NULL);
	init_function(&red, reduce, NULL, 0, &add, NULL, NULL);
	applymonadic(&red, &z, &z);
	printf("%d\n", z.data->intv);
	printf("Size: %lu\tRank: %d\tAllocated: %lu\n", 
	    size(&z), rank(&z), z.size);
	free_data(&z);
}

@ @<Dispatch example based on |argv[1]|@>=
else if (!strcmp(argv[1], "ex4")) {
	msg = "Ex 4: Computing + / iota 10";
	example = ex4;
} 

@* Example 5. Let's try making use of the each operator together with 
some functions to get some interesting results. We will 
compute $\{+/\iota\omega\}\eachop\ \iota 100$.

@<Ex 5. Compute $+/\{+/\iota\omega\}\eachop\ \iota 10000$@>=
void ex5_help(AplArray *res, AplArray *rgt, AplFunction *fun)
{
	AplFunction add;
	AplFunction red;
	init_function(&add, NULL, plus, 0, NULL, NULL, NULL);
	init_function(&red, reduce, NULL, 0, &add, NULL, NULL);
	index_gen(res, rgt, NULL);
	applymonadic(&red, res, res);
}

void ex5()
{
	AplFunction eac, fun, red, add;
	AplArray x;
	init_array(&x);
	alloc_array(&x, INT);
	x.data->intv = 100;
	index_gen(&x, &x, NULL);
	init_function(&fun, ex5_help, NULL, 0, NULL, NULL, NULL);
	init_function(&eac, eachm, eachd, 0, &fun, NULL, NULL);
	applymonadic(&eac, &x, &x);
	init_function(&add, NULL, plus, 0, NULL, NULL, NULL);
	init_function(&red, reduce, NULL, 0, &add, NULL, NULL);
	applymonadic(&red, &x, &x);
	printf("%d\n", x.data->intv);
	printf("Size: %lu\tRank: %d\tAllocated: %lu\n", 
	    size(&x), rank(&x), x.size);
}

@ @<Dispatch example based on |argv[1]|@>=
else if (!strcmp(argv[1], "ex5")) {
	msg = "Ex 5: Computing + / {+ / iota omega} each iota 100";
	example = ex5;
} 

@* Index.
