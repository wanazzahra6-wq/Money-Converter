#include "backend.h"
#include "konversi.h"
#include "data.h"
#include "riwayat.h"

#include <QFile>
#include <QTextStream>
#include <QStandardPaths>
#include <QDir>
#include <QDateTime>
#include <QVariantMap>

Backend::Backend(QObject *parent) : QObject(parent) {
    muatKurs();  // Load kurs dari file saat app dibuka
}

QStringList Backend::getMataUang() {
    QStringList list;
    for (int i = 0; i < 15; i++) {
        list.append(QString::fromStdString(namaMataUang[i]));
    }
    return list;
}

double Backend::konversi(int asal, int tujuan, double jumlah) {
    double idr = jumlah * kurs[asal];
    double hasil = idr / kurs[tujuan];

    std::string text = namaMataUang[asal] + " -> " +
                       namaMataUang[tujuan] + ": " +
                       std::to_string(jumlah) + " = " +
                       std::to_string(hasil);
    tambahRiwayat(text);

    return hasil;
}

QStringList Backend::getRiwayat() {
    QStringList list;
    for (const std::string& s : historyText) {
        list.append(QString::fromStdString(s));
    }
    return list;
}

bool Backend::loginAdmin(QString username, QString password) {
    return username == "cuanadmin" && password == "12345";
}

bool Backend::updateKurs(int index, double kursBaru) {
    if (index < 0 || index >= 15) return false;
    kurs[index] = kursBaru;
    lastUpdateTime[index] = QDateTime::currentDateTime().toString("dd/MM/yy hh:mm");
    simpanKurs();
    return true;
}

double Backend::getKurs(int index) {
    if (index < 0 || index >= 15) return 0;
    return kurs[index];
}

// Kembalikan list semua kurs untuk ditampilkan di tabel
QVariantList Backend::getSemuaKurs() {
    QVariantList list;
    for (int i = 0; i < 15; i++) {
        QVariantMap item;
        item["nama"] = QString::fromStdString(namaMataUang[i]);
        item["kurs"] = (double)kurs[i];
        item["lastUpdate"] = lastUpdateTime[i].isEmpty() ? "-" : lastUpdateTime[i];
        list.append(item);
    }
    return list;
}

// Simpan kurs ke file teks di folder AppData/Documents
void Backend::simpanKurs() {
    QString path = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/kurs.txt";

    // Pastikan folder ada
    QDir dir(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation));
    if (!dir.exists()) dir.mkpath(".");

    QFile file(path);
    if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        QTextStream out(&file);
        QString waktu = QDateTime::currentDateTime().toString("dd/MM/yy hh:mm");
        for (int i = 0; i < 15; i++) {
            out << QString::fromStdString(namaMataUang[i])
                << "," << kurs[i]
                << "," << (lastUpdateTime[i].isEmpty() ? waktu : lastUpdateTime[i])
                << "\n";
        }
        file.close();
    }
}

// Muat kurs dari file saat startup
void Backend::muatKurs() {
    QString path = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/kurs.txt";
    QFile file(path);

    if (!file.exists()) return;  // Kalau belum ada file, pakai kurs default dari data.cpp

    if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(&file);
        int i = 0;
        while (!in.atEnd() && i < 15) {
            QString line = in.readLine();
            QStringList parts = line.split(",");
            if (parts.size() >= 2) {
                kurs[i] = parts[1].toFloat();
                if (parts.size() >= 3) {
                    lastUpdateTime[i] = parts[2];
                }
            }
            i++;
        }
        file.close();
    }
}
