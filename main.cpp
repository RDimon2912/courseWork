#include <iostream>
#include <cstdio>
#include <algorithm>

using namespace std;

int n, a[100500];

int main() {
	scanf ("%d", &n);
	for (int i = 1; i <= n; i ++)
		scanf ("%d", &a[i]);
	sort (a + 1, a + 1 + n);
	for (int i = 1; i <= n; i ++)
		prinf ("%d ", a[i]);
	return 0;	
}