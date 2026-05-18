#include <iostream>
#include "riwayat.h"

using namespace std;

vector<string> historyText;

void tambahRiwayat(string text) {
    historyText.push_back(text);
}

void riwayat() {
    cout << "\n=== RIWAYAT KONVERSI ===\n" << endl;

    if (historyText.empty()) {
        cout << "Belum ada riwayat." << endl;
        return;
    }

    for (int i = 0; i < historyText.size(); i++) {
        cout << i + 1 << ". " << historyText[i] << endl;
    }
}