#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QString>
#include <QStringList>
#include <QVariantList>
#include "data.h"
#include "riwayat.h"

class Backend : public QObject {
    Q_OBJECT

public:
    explicit Backend(QObject *parent = nullptr);

    Q_INVOKABLE QStringList getMataUang();
    Q_INVOKABLE double konversi(int asal, int tujuan, double jumlah);
    Q_INVOKABLE QStringList getRiwayat();
    Q_INVOKABLE bool loginAdmin(QString username, QString password);
    Q_INVOKABLE bool updateKurs(int index, double kursBaru);
    Q_INVOKABLE double getKurs(int index);
    Q_INVOKABLE QVariantList getSemuaKurs();  // Untuk tabel di halaman Updates

    void simpanKurs();   // Simpan kurs ke file
    void muatKurs();     // Muat kurs dari file saat startup
};

#endif
