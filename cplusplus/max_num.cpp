#include <iostream>
#include <cstdio>
using namespace std;

int max_of_four(int a, int b, int c, int d) {
    int max_num = a;
    int numbers[3] = {b, c, d};
    for (int i = 0; i < sizeof(numbers) / 4; i++) {
        if (numbers[i] > max_num) {
            max_num= numbers[i];
        }
    }
    return max_num;
}

int main() {
    int a = 1, b = 2, c = 3, d = 4;
    int ans = max_of_four(a, b, c, d);
    cout << ans << endl;
    return 0;
}