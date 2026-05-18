#include <iostream>
#include <string>
#include "data.h"

using namespace std;

void loginadmin() {

    string username, password;

    string adminUser = "cuanadmin";
    string adminPass = "12345";

    cout << "\n========================================" << endl;
    cout << "              ADMIN LOGIN               " << endl;
    cout << "========================================" << endl;

    cout << "\nUsername : ";
    cin >> username;

    cout << "Password : ";
    cin >> password;

    if(username == adminUser && password == adminPass) {

        cout << "\nLogin berhasil!" << endl;

    int pilih;
    float kursBaru;

    cout << "\n=== UPDATE KURS ===\n" << endl;

    for(int i = 0; i < 15; i++) {
        cout << i + 1 << ". " << namaMataUang[i] << endl;
    }

    cout << "\nPilih mata uang : ";
    cin >> pilih;

    cout << "Masukkan kurs baru : ";
    cin >> kursBaru;

    kurs[pilih - 1] = kursBaru;

    cout << "\nKurs berhasil diupdate!\n";
    }   
    
    else {

        cout << "\nUsername atau password salah!" << endl;
    }
}