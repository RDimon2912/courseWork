#include <iostream>
#include <cstdio>
#include <algorithm>
#include <set>

using namespace std;

int n, a;
multiset < int > s;

int main() {
	scanf ("%d", &n);
	for (int i = 1; i <= n; i ++)
		scanf ("%d", &a), s.insert (a);
	for (auto it : s)
		printf ("%d ", it);
	return 0;
}