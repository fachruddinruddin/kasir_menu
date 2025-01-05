import 'package:flutter/material.dart';
import 'package:uts_simulasi/menu.dart';
import 'package:uts_simulasi/pesan.dart';
import 'package:file_picker/file_picker.dart';

class Mainfoodmenu extends StatefulWidget {
  Mainfoodmenu({Key? key}) : super(key: key);

  @override
  _MainfoodmenuState createState() => _MainfoodmenuState();
}

class _MainfoodmenuState extends State<Mainfoodmenu> {
  final List<Menu> listmenu = [];
  final _namaController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _hargaController = TextEditingController();
  final _gambarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dummymenu();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _deskripsiController.dispose();
    _hargaController.dispose();
    _gambarController.dispose();
    super.dispose();
  }

  void dummymenu() {
    listmenu.addAll([
      Menu(
        nama: "Sate Ayam",
        deskripsi: "Sate daging ayam",
        harga: 25000,
        gambar: "sate.jpg",
      ),
      Menu(
        nama: "Ayam Goreng",
        deskripsi: "Ayam goreng dengan bumbu kuning",
        harga: 27000,
        gambar: "agor.jpg",
      ),
      Menu(
        nama: "Nasi Goreng",
        deskripsi: "Nasi goreng special",
        harga: 28000,
        gambar: "nasgor.jpg",
      ),
    ]);
  }

  void _tambahMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Menu'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(_namaController, 'Nama'),
                _buildTextField(_deskripsiController, 'Deskripsi'),
                _buildTextField(_hargaController, 'Harga', isNumber: true),
                _buildTextField(_gambarController, 'Gambar'),
                ElevatedButton(
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.image,
                    );
                    if (result != null) {
                      _gambarController.text = result.files.single.name;
                    }
                  },
                  child: Text('Upload Gambar'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final nama = _namaController.text;
                final deskripsi = _deskripsiController.text;
                final harga = int.tryParse(_hargaController.text) ?? 0;
                final gambar = _gambarController.text;

                if (nama.isNotEmpty &&
                    deskripsi.isNotEmpty &&
                    harga > 0 &&
                    gambar.isNotEmpty) {
                  setState(() {
                    listmenu.add(Menu(
                      nama: nama,
                      deskripsi: deskripsi,
                      harga: harga,
                      gambar: gambar,
                    ));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {bool isNumber = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pilihan Menu",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () => _tambahMenu(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listmenu.length,
                itemBuilder: (context, index) {
                  final menu = listmenu[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/${menu.gambar}',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        menu.nama,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text(menu.deskripsi),
                          SizedBox(height: 5),
                          Text(
                            "Rp ${menu.harga}",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PesanPage(
                                pesananMenu: menu,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Beli",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
