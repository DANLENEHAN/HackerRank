#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>
using namespace std;


int main() {

    // n variable length arrays    
    int n;
    // q queries to be run
    int q;
    cin >> n >> q;
    
    // An array of pointers to store the address of
    // the first element of each of the n arrays 
    int** arrays = new int*[n];

    // Storing each array address in arrays and populating
    // each nested array
    int arr_size;
    for (int p=0; p<n; p++) {
        cin >> arr_size;
        arrays[p] = new int[arr_size];
        for (int c=0; c<arr_size; c++) {
            cin >> arrays[p][c];
        }
    }
    
    // Looping through the queries and executing them
    int i, j;
    for (int query=0; query<q; query++) {
        cin >> i >> j;
        cout << arrays[i][j] << endl;
    }

    // Clearing up the memory after usage
    for (int p=0; p<n; p++) {
        delete arrays[p];
    }
    delete[] arrays;

    return 0;
}