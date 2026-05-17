#include <iostream>
#include "loginadmin.h"
#include "data.h"
#include "konversi.h"
using namespace std;

void homepage();
void riwayat();

int main() {
    homepage();
    return 0;
}
void homepage() {

    int pilih;

    do{
        system("cls");

        cout << "========================================" << endl;
        cout << "           CUAN CONVERTER               " << endl;
        cout << "========================================" << endl;
        cout << endl;

        cout << "[1] Currency Converter" << endl;
        cout << "[2] Update Exchange Rate" << endl;
        cout << "[3] Recent Conversion" << endl;
        cout << "[4] Exit" << endl;
        cout << endl;
        cout << "Pilih menu : ";
        cin >> pilih;

        switch(pilih) {

            case 1:
                konversi();
                break;

            case 2:
                loginadmin();
                break;

            case 3:
                riwayat();
                break;

            case 4:
                cout << "\nProgram selesai..." << endl;
                break;

            default:
                cout << "\nMenu tidak valid!" << endl;
            }
    system("pause");
        } while(pilih != 4);
}
void riwayat() {
    cout << "\n=== Riwayat konversi ===" << endl;
}