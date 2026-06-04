#include "data.h"

string namaMataUang[15] = {
    "IDR", "USD", "EUR", "JPY", "KRW",
    "GBP", "CNY", "SGD", "MYR", "THB",
    "INR", "SAR", "AUD", "CHF", "CAD"
};

float kurs[15] = {
    1,      // IDR
    16000,  // USD
    17500,  // EUR
    110,    // JPY
    12,     // KRW
    20500,  // GBP
    2200,   // CNY
    11800,  // SGD
    3400,   // MYR
    450,    // THB
    190,    // INR
    4300,   // SAR
    10500,  // AUD
    18500,  // CHF
    11500   // CAD
};

// Waktu terakhir update kurs (kosong = belum pernah diupdate)
QString lastUpdateTime[15] = {
    "", "", "", "", "",
    "", "", "", "", "",
    "", "", "", "", ""
};
