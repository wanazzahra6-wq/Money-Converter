import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: rootWindow
    width: 360
    height: 640
    visible: true
    title: "Cuan Converter"

    // Warna utama
    readonly property color colorPrimary:   "#5B21B6"
    readonly property color colorPrimaryDark: "#4C1D95"
    readonly property color colorBg:        "#FFFFFF"
    readonly property color colorCardBg:    "#F3E8FF"
    readonly property color colorFieldBg:   "#F5F0FF"
    readonly property color colorTextPurple:"#5B21B6"
    readonly property color colorTextGray:  "#888888"
    readonly property color colorTextDark:  "#333333"

    // 0=splash, 1=home, 2=konversi, 3=riwayat, 4=admin login, 5=updates
    property int currentPage: 0
    property bool adminLoggedIn: false

    // ===== SPLASH SCREEN =====
    Rectangle {
        anchors.fill: parent
        color: colorPrimary
        visible: currentPage === 0

        Column {
            anchors.centerIn: parent
            spacing: 20

            Rectangle {
                width: 100
                height: 100
                radius: 50
                color: "#ffffff30"
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    anchors.centerIn: parent
                    text: "💰"
                    font.pixelSize: 48
                }
            }

            Text {
                text: "Money Converter"
                font.pixelSize: 28
                font.bold: true
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Your Currency Companion!"
                font.pixelSize: 14
                color: "#D8B4FE"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Timer {
            interval: 2000
            running: true
            onTriggered: currentPage = 1
        }
    }

    // ===== HOME PAGE =====
    Rectangle {
        anchors.fill: parent
        color: colorBg
        visible: currentPage === 1

        // Header ungu atas
        Rectangle {
            id: homeHeader
            anchors.top: parent.top
            width: parent.width
            height: 110
            color: colorPrimary
            radius: 24
            // Tutup sudut atas yang ikut melengkung
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.width
                height: 24
                color: colorPrimary
            }

            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.right: parent.right
                anchors.rightMargin: 20

                Column {
                    spacing: 2
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        text: "Hi! Welcome 👋"
                        font.pixelSize: 18
                        font.bold: true
                        color: "white"
                    }
                    Text {
                        text: "To Money Converter"
                        font.pixelSize: 18
                        font.bold: true
                        color: "white"
                    }
                }

                Item { width: parent.width - 220; height: 1 }

                Rectangle {
                    width: 56
                    height: 56
                    radius: 28
                    color: "#ffffff30"
                    anchors.verticalCenter: parent.verticalCenter
                    Text { anchors.centerIn: parent; text: "💵"; font.pixelSize: 28 }
                }
            }
        }

        Column {
            anchors.top: homeHeader.bottom
            anchors.topMargin: 24
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20
            width: parent.width - 40

            Text {
                text: "OUR FEATURES"
                font.pixelSize: 13
                font.bold: true
                color: colorTextGray
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Grid {
                columns: 2
                spacing: 16
                anchors.horizontalCenter: parent.horizontalCenter

                // Convert
                Rectangle {
                    width: 140
                    height: 120
                    radius: 16
                    color: colorPrimary
                    Column {
                        anchors.centerIn: parent
                        spacing: 10
                        Text { anchors.horizontalCenter: parent.horizontalCenter; text: "🔄"; font.pixelSize: 32 }
                        Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Convert"; color: "white"; font.pixelSize: 14; font.bold: true }
                    }
                    MouseArea { anchors.fill: parent; onClicked: currentPage = 2 }
                }

                // History
                Rectangle {
                    width: 140
                    height: 120
                    radius: 16
                    color: colorPrimary
                    Column {
                        anchors.centerIn: parent
                        spacing: 10
                        Text { anchors.horizontalCenter: parent.horizontalCenter; text: "🕐"; font.pixelSize: 32 }
                        Text { anchors.horizontalCenter: parent.horizontalCenter; text: "History"; color: "white"; font.pixelSize: 14; font.bold: true }
                    }
                    MouseArea { anchors.fill: parent; onClicked: currentPage = 3 }
                }

                // Admin
                Rectangle {
                    width: 140
                    height: 120
                    radius: 16
                    color: colorPrimary
                    Column {
                        anchors.centerIn: parent
                        spacing: 10
                        Text { anchors.horizontalCenter: parent.horizontalCenter; text: "⚙️"; font.pixelSize: 32 }
                        Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Admin"; color: "white"; font.pixelSize: 14; font.bold: true }
                    }
                    MouseArea { anchors.fill: parent; onClicked: currentPage = 4 }
                }
            }
        }

        BottomNav { }
    }

    // ===== KONVERSI =====
    Rectangle {
        id: konversiPage
        anchors.fill: parent
        color: colorBg
        visible: currentPage === 2

        property int asalIndex: 0
        property int tujuanIndex: 1
        property string hasilText: ""
        property string namaAsal: ""
        property string namaTujuan: ""
        property double jumlahAsal: 0

        // Header ungu atas
        Rectangle {
            id: konversiHeader
            anchors.top: parent.top
            width: parent.width
            height: 56
            color: colorPrimary
            radius: 20
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.width
                height: 20
                color: colorPrimary
            }

            Text {
                anchors.centerIn: parent
                text: "Currency Converter"
                color: "white"
                font.pixelSize: 16
                font.bold: true
            }
        }

        Column {
            anchors.top: konversiHeader.bottom
            anchors.topMargin: 24
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 40
            spacing: 14

            Text { text: "From"; color: colorTextGray; font.pixelSize: 12 }
            ComboBox {
                id: comboAsal
                width: parent.width
                model: backend.getMataUang()
                onCurrentIndexChanged: konversiPage.asalIndex = currentIndex
                contentItem: Text {
                    leftPadding: 12
                    text: comboAsal.displayText
                    color: colorTextDark
                    font.pixelSize: 13
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    radius: 8
                    color: colorFieldBg
                    border.color: colorPrimary
                    border.width: 1
                }
            }

            Text { text: "To"; color: colorTextGray; font.pixelSize: 12 }
            ComboBox {
                id: comboTujuan
                width: parent.width
                model: backend.getMataUang()
                currentIndex: 1
                onCurrentIndexChanged: konversiPage.tujuanIndex = currentIndex
                contentItem: Text {
                    leftPadding: 12
                    text: comboTujuan.displayText
                    color: colorTextDark
                    font.pixelSize: 13
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    radius: 8
                    color: colorFieldBg
                    border.color: colorPrimary
                    border.width: 1
                }
            }

            Text { text: "Amount"; color: colorTextGray; font.pixelSize: 12 }
            TextField {
                id: inputJumlah
                width: parent.width
                color: colorTextDark
                placeholderText: "Enter amount"
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                background: Rectangle {
                    radius: 8
                    color: colorFieldBg
                    border.color: colorPrimary
                    border.width: 1
                }
            }

            Rectangle {
                width: parent.width
                height: 48
                radius: 10
                color: colorPrimary

                Text {
                    anchors.centerIn: parent
                    text: "Convert"
                    color: "white"
                    font.pixelSize: 15
                    font.bold: true
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        var jumlah = parseFloat(inputJumlah.text)
                        if (!isNaN(jumlah) && jumlah > 0) {
                            var r = backend.konversi(konversiPage.asalIndex, konversiPage.tujuanIndex, jumlah)
                            var mataUang = backend.getMataUang()
                            konversiPage.namaAsal = mataUang[konversiPage.asalIndex]
                            konversiPage.namaTujuan = mataUang[konversiPage.tujuanIndex]
                            konversiPage.jumlahAsal = jumlah
                            konversiPage.hasilText = r.toFixed(2)
                        }
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 72
                radius: 12
                color: colorCardBg
                visible: konversiPage.hasilText !== ""

                Column {
                    anchors.centerIn: parent
                    spacing: 6
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: konversiPage.namaAsal + " → " + konversiPage.namaTujuan
                        font.pixelSize: 13
                        color: colorTextPurple
                        font.bold: true
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: konversiPage.jumlahAsal + " " + konversiPage.namaAsal + " = " + konversiPage.hasilText + " " + konversiPage.namaTujuan
                        font.pixelSize: 14
                        color: colorTextDark
                    }
                }
            }
        }

        BottomNav { }
    }

    // ===== RIWAYAT =====
    Rectangle {
        anchors.fill: parent
        color: colorBg
        visible: currentPage === 3

        onVisibleChanged: {
            if (visible) riwayatList.model = backend.getRiwayat()
        }

        // Header ungu atas
        Rectangle {
            id: riwayatHeader
            anchors.top: parent.top
            width: parent.width
            height: 56
            color: colorPrimary
            radius: 20
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.width
                height: 20
                color: colorPrimary
            }

            Text {
                anchors.centerIn: parent
                text: "History"
                color: "white"
                font.pixelSize: 16
                font.bold: true
            }
        }

        ListView {
            id: riwayatList
            anchors.top: riwayatHeader.bottom
            anchors.topMargin: 16
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 70
            model: backend.getRiwayat()
            clip: true
            spacing: 10

            delegate: Rectangle {
                width: riwayatList.width
                height: 72
                radius: 12
                color: colorCardBg

                property var parts: modelData.split(": ")
                property string baris1: parts.length > 0 ? parts[0] : modelData
                property string baris2: parts.length > 1 ? parts[1] : ""

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    spacing: 4

                    Text {
                        text: baris1
                        color: colorTextPurple
                        font.pixelSize: 13
                        font.bold: true
                    }
                    Text {
                        text: baris2
                        color: colorTextGray
                        font.pixelSize: 12
                    }
                }
            }

            Text {
                anchors.centerIn: parent
                text: "Belum ada riwayat konversi"
                color: colorTextGray
                font.pixelSize: 14
                visible: riwayatList.count === 0
            }
        }

        BottomNav { }
    }

    // ===== ADMIN LOGIN =====
    Rectangle {
        anchors.fill: parent
        color: colorBg
        visible: currentPage === 4

        property string pesanAdmin: ""

        onVisibleChanged: {
            if (visible && !rootWindow.adminLoggedIn) pesanAdmin = ""
        }

        // Header ungu atas
        Rectangle {
            id: adminHeader
            anchors.top: parent.top
            width: parent.width
            height: 56
            color: colorPrimary
            radius: 20
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.width
                height: 20
                color: colorPrimary
            }

            Text {
                anchors.centerIn: parent
                text: "Admin"
                color: "white"
                font.pixelSize: 16
                font.bold: true
            }
        }

        Column {
            anchors.top: adminHeader.bottom
            anchors.topMargin: 60
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 40
            spacing: 16

            Text {
                text: "Admin Login"
                font.pixelSize: 22
                font.bold: true
                color: colorTextPurple
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Item { height: 8; width: 1 }

            Text { text: "Username :"; color: colorTextGray; font.pixelSize: 13 }
            TextField {
                id: usernameField
                width: parent.width
                color: colorTextDark
                placeholderText: "Username"
                background: Rectangle {
                    radius: 8
                    color: colorFieldBg
                    border.color: colorPrimary
                    border.width: 1
                }
            }

            Text { text: "Password :"; color: colorTextGray; font.pixelSize: 13 }
            TextField {
                id: passwordField
                width: parent.width
                color: colorTextDark
                placeholderText: "Password"
                echoMode: TextInput.Password
                background: Rectangle {
                    radius: 8
                    color: colorFieldBg
                    border.color: colorPrimary
                    border.width: 1
                }
            }

            Text {
                text: parent.parent.pesanAdmin
                color: "red"
                font.pixelSize: 12
                visible: parent.parent.pesanAdmin !== ""
            }

            Rectangle {
                width: parent.width
                height: 48
                radius: 10
                color: colorPrimary
                Text { anchors.centerIn: parent; text: "Login"; color: "white"; font.bold: true; font.pixelSize: 15 }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (backend.loginAdmin(usernameField.text, passwordField.text)) {
                            rootWindow.adminLoggedIn = true
                            currentPage = 5
                        } else {
                            parent.parent.parent.pesanAdmin = "Username atau password salah!"
                        }
                    }
                }
            }
        }

        BottomNav { }
    }

    // ===== UPDATE KURS =====
    Rectangle {
        anchors.fill: parent
        color: colorBg
        visible: currentPage === 5

        property string pesanUpdate: ""

        onVisibleChanged: {
            if (visible) kursListView.model = backend.getSemuaKurs()
        }

        Rectangle {
            id: updateHeader
            anchors.top: parent.top
            width: parent.width
            height: 56
            color: colorPrimary
            radius: 20
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.width
                height: 20
                color: colorPrimary
            }

            Text {
                anchors.centerIn: parent
                text: "Update Kurs"
                color: "white"
                font.pixelSize: 16
                font.bold: true
            }

            Rectangle {
                anchors.right: parent.right
                anchors.rightMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                width: 76
                height: 32
                radius: 8
                color: "white"

                Text {
                    anchors.centerIn: parent
                    text: "Log Out"
                    color: colorPrimary
                    font.pixelSize: 12
                    font.bold: true
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        rootWindow.adminLoggedIn = false
                        usernameField.text = ""
                        passwordField.text = ""
                        currentPage = 4
                    }
                }
            }
        }

        Rectangle {
            id: tableHeader
            anchors.top: updateHeader.bottom
            width: parent.width
            height: 36
            color: colorCardBg

            Text {
                anchors.centerIn: parent
                text: "Currency Exchange Rates"
                color: colorTextPurple
                font.pixelSize: 13
                font.bold: true
            }
        }

        Row {
            id: colHeader
            anchors.top: tableHeader.bottom
            width: parent.width
            height: 28

            Repeater {
                model: ["Currency", "Rate", "Change", "Last Update"]
                delegate: Rectangle {
                    width: index === 0 ? 80 : index === 3 ? 100 : 70
                    height: 28
                    color: "#EDE9FE"
                    Text {
                        anchors.centerIn: parent
                        text: modelData
                        font.pixelSize: 10
                        font.bold: true
                        color: colorTextPurple
                    }
                }
            }
        }

        ListView {
            id: kursListView
            anchors.top: colHeader.bottom
            anchors.bottom: updateFooter.top
            width: parent.width
            clip: true
            model: backend.getSemuaKurs()

            delegate: Rectangle {
                width: kursListView.width
                height: 38
                color: index % 2 === 0 ? "white" : "#FAF5FF"

                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width

                    Text {
                        width: 80
                        text: modelData.nama
                        font.pixelSize: 12
                        font.bold: true
                        color: colorTextDark
                        leftPadding: 12
                    }
                    Text {
                        width: 70
                        text: modelData.kurs.toLocaleString()
                        font.pixelSize: 11
                        color: colorTextGray
                        horizontalAlignment: Text.AlignHCenter
                    }
                    TextField {
                        id: changeField
                        width: 70
                        height: 28
                        color: colorTextDark
                        placeholderText: "New"
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        font.pixelSize: 11
                        background: Rectangle {
                            radius: 4
                            color: colorFieldBg
                            border.color: "#C4B5FD"
                            border.width: 1
                        }
                    }
                    Text {
                        width: 100
                        text: modelData.lastUpdate
                        font.pixelSize: 10
                        color: colorTextGray
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                property int rowIndex: index
                property alias newKursText: changeField.text
            }
        }

        Text {
            anchors.bottom: updateFooter.top
            anchors.bottomMargin: 4
            anchors.horizontalCenter: parent.horizontalCenter
            text: parent.pesanUpdate
            color: parent.pesanUpdate.includes("berhasil") ? "green" : "red"
            font.pixelSize: 12
            visible: parent.pesanUpdate !== ""
        }

        Rectangle {
            id: updateFooter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 62
            width: parent.width
            height: 52
            color: "white"

            Rectangle {
                anchors.centerIn: parent
                width: parent.width - 40
                height: 44
                radius: 10
                color: colorPrimary

                Text {
                    anchors.centerIn: parent
                    text: "Updates Rates"
                    color: "white"
                    font.pixelSize: 14
                    font.bold: true
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        var updated = 0
                        for (var i = 0; i < kursListView.count; i++) {
                            var item = kursListView.itemAtIndex(i)
                            if (item && item.newKursText !== "") {
                                var k = parseFloat(item.newKursText)
                                if (!isNaN(k) && k > 0) {
                                    backend.updateKurs(i, k)
                                    updated++
                                }
                            }
                        }
                        kursListView.model = null
                        kursListView.model = backend.getSemuaKurs()
                        if (updated > 0) {
                            parent.parent.pesanUpdate = updated + " kurs berhasil diupdate!"
                        } else {
                            parent.parent.pesanUpdate = "Tidak ada kurs yang diubah."
                        }
                    }
                }
            }
        }

        BottomNav { }
    }

    // ===== BOTTOM NAV COMPONENT =====
    component BottomNav: Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 60
        color: colorPrimary
        radius: 20
        // Tutup sudut bawah yang ikut melengkung
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: parent.width
            height: 20
            color: colorPrimary
        }

        Row {
            anchors.fill: parent

            Repeater {
                model: [
                    { label: "Home",    icon: "🏠", page: 1 },
                    { label: "Convert", icon: "🔄", page: 2 },
                    { label: "History", icon: "🕐", page: 3 },
                    { label: "Admin",   icon: "⚙️", page: 4 },
                    { label: "Updates", icon: "📋", page: 5 }
                ]

                delegate: Rectangle {
                    width: parent.width / 5
                    height: 60
                    // Tab aktif: sedikit lebih terang (ungu muda transparan)
                    color: rootWindow.currentPage === modelData.page ? "#ffffff25" : "transparent"

                    // Garis indikator bawah tab aktif
                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width - 10
                        height: 3
                        radius: 2
                        color: "white"
                        visible: rootWindow.currentPage === modelData.page
                    }

                    Column {
                        anchors.centerIn: parent
                        spacing: 2

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData.icon
                            font.pixelSize: 18
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData.label
                            color: "white"
                            font.pixelSize: 9
                            font.bold: rootWindow.currentPage === modelData.page
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (modelData.page === 5 && !rootWindow.adminLoggedIn) {
                                rootWindow.currentPage = 4
                            } else {
                                rootWindow.currentPage = modelData.page
                            }
                        }
                    }
                }
            }
        }
    }
}
