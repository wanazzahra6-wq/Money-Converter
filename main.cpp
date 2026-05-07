#include <iostream>
using namespace std;

void homepage();
void konversi();
void updatekurs();
void loginadmin();
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
        cout << "[3] Admin Login" << endl;
        cout << "[4] Recent Conversion" << endl;
        cout << "[5] Exit" << endl;
        cout << endl;
        cout << "Pilih menu : ";
        cin >> pilih;

        switch(pilih) {

            case 1:
                konversi();
                break;

            case 2:
                updatekurs();
                break;

            case 3:
                loginadmin();
                break;

            case 4:
                riwayat();
                break;

            case 5:
                cout << "\nProgram selesai..." << endl;
                break;

            default:
                cout << "\nMenu tidak valid!" << endl;
            }
    system("pause");
        } while(pilih != 5);
}
void konversi() {
    cout << "\n=== konfersi kurs ===" << endl;
}

void updatekurs() {
    cout << "\n=== Update kurs ===" << endl;
}

void loginadmin() {
    cout << "\n=== Admin Login ===" << endl;
}

void riwayat() {
    cout << "\n=== Riwayat konversi ===" << endl;
}


