#include <iostream>
#include <limits>
#include "konversi.h"
#include "data.h"

using namespace std;

void konversi() {

    int asal, tujuan;
    float jumlah, hasil, idr;

    cout << "\n=== KONVERSI MATA UANG ===\n" << endl;

    for(int i = 0; i < 15; i++) {
        cout << i + 1 << ". " << namaMataUang[i] << endl;
    }

    do {
        cout << "\nPilih mata uang asal : ";
        cin >> asal;

        if(cin.fail()) {
            cin.clear();
            cin.ignore(numeric_limits<streamsize>::max(), '\n');

            cout << "Input harus angka!\n";
            asal = 0;
        }

        else if(asal < 1 || asal > 15) {
            cout << "Pilihan tidak valid!\n";
        }

    } while(asal < 1 || asal > 15);

    do {
        cout << "Pilih mata uang tujuan : ";
        cin >> tujuan;

        if(cin.fail()) {
            cin.clear();
            cin.ignore(numeric_limits<streamsize>::max(), '\n');

            cout << "Input harus angka!\n";
            tujuan = 0;
        }

        else if(tujuan < 1 || tujuan > 15) {
            cout << "Pilihan tidak valid!\n";
        }

    } while(tujuan < 1 || tujuan > 15);

    cout << "Masukkan jumlah uang : ";
    cin >> jumlah;

    idr = jumlah * kurs[asal - 1];

    hasil = idr / kurs[tujuan - 1];

    cout << "\nHasil konversi : "
         << hasil << " "
         << namaMataUang[tujuan - 1]
         << endl;
}