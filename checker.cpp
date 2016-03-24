#include <iostream>
#include <fstream>

using namespace std;

ifstream fin1("in1.in");
ifstream fin2("in2.in");
ifstream info("info.in");

int n;

int main() {
	info >> n;
	for (int i = 1; i <= n; i ++) {
		int a1, a2;
		fin1 >> a1;
		fin2 >> a2;
		if (a1 != a2) {
			cout << "false";
			return 0;
		}
	}
	cout << "true";
	return 0;
}