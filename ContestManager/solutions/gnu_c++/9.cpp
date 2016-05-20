#include <iostream>
#include <cstdio>
#include <algorithm>
#include <ctime>
#include <cstdlib>
#include <set>
#include <map>
#include <cmath>
#include <vector>
#include <queue>
#include <stack>
#include <functional>
#include <cstring>
#include <fstream>
#include <memory.h>
#include <iomanip>
#include <omp.h>
#include <string>

using namespace std;

#define right asfdsg
#define left asfdsvs
#define MAXN 1000100

typedef long long ll;
typedef unsigned long long ull;
typedef long double ld;

int n, a[100500];

int main() {
    scanf ("%d", &n);
    for (int i = 1; i <= n; i ++)
        scanf ("%d", &a[i]);
    sort (a + 1, a + 1 + n);
    for (int i= 1; i <= n; i ++)
        printf ("%d ", a[i]);
    return 0;
}
