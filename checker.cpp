#include <iostream>
#include <fstream>

using namespace std;

ifstream fin1("outCheck.txt");
ifstream fin2("output.txt");

int n;

int main() {
	while ( true ) {
		int x1, x2;
		bool ok1 = fin1 >> x1;
		bool ok2 = fin2 >> x2;
		if (!ok1 && !ok2) break;
		if (ok1 && ok2) {
			if (x1 != x2) {
				cout << "false";
				return 0;
			}
			continue;
		}
		cout << "false";
		return 0;
	}
	cout << "true";
	return 0;
}