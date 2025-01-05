import 'package:flutter/material.dart';
import 'package:uts_simulasi/menu.dart';
import 'package:uts_simulasi/page.dart';

class PesanPage extends StatefulWidget {
  final Menu pesananMenu;

  PesanPage({super.key, required this.pesananMenu});

  @override
  State<PesanPage> createState() => _PesanPageState();
}

class _PesanPageState extends State<PesanPage> {
  late Menu pesananMenu;
  int total = 0;
  int jumlah = 0;
  TextEditingController jmlhCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    pesananMenu = widget.pesananMenu;
    jmlhCtrl.text = '0';
  }

  void changeJml(String op) {
    setState(() {
      if (op == '+') {
        jumlah++;
      } else if (op == '-' && jumlah > 0) {
        jumlah--;
      }
      total = jumlah * pesananMenu.harga;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesanan Anda", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  'assets/images/${pesananMenu.gambar}',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              pesananMenu.nama,
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 15),
            Text(
              pesananMenu.deskripsi,
              style: TextStyle(
                  fontSize: 16, color: const Color.fromARGB(255, 0, 0, 0)),
            ),
            SizedBox(height: 15),
            Text(
              "Rp. ${pesananMenu.harga}",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove, color: Colors.black),
                  onPressed: () {
                    changeJml('-');
                  },
                ),
                Text(
                  jumlah.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                IconButton(
                  icon: Icon(Icons.add,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                  onPressed: () {
                    changeJml('+');
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                "Total: Rp. $total",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotaPage(
                        pesananMenu: pesananMenu,
                        jumlah: jumlah,
                      ),
                    ),
                  );
                },
                child: const Text("Pesan Sekarang",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
