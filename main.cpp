#include <iostream>
#include <cstdio>
#include <algorithm>

using namespace std;

int n, a[100500];
char s[1000];

int main() {
	gets(s);
	scanf ("%d", &n);
	for (int i = 1; i <= n; i ++)
		scanf ("%d", &a[i]);
	sort (a + 1, a + 1 + n);
	for (int i = 1; i <= n; i ++)
		printf ("%d ", a[i]);
	return 0;	
}