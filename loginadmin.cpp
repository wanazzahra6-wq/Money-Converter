#include <iostream>
#include <string>

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

        // nanti di sini bisa dipanggil updatekurs();

    }
    else {

        cout << "\nUsername atau password salah!" << endl;
    }
}