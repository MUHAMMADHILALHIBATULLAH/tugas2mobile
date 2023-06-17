import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas/screens/profile_screen.dart';
import 'package:http/http.dart' as http;
import 'package:tugas/models/maroon.dart';
import 'package:tugas/services/maroon.dart';

class MaroonScreen extends StatefulWidget {
  const MaroonScreen({super.key});

  @override
  State<MaroonScreen> createState() => _MaroonScreenState();
}

class _MaroonScreenState extends State<MaroonScreen> {
  List<Maroon> _maroons = [];
  Future<void> _fetchMaroons() async {
    try {
      final maroons = await MaroonService.readMaroons();
      setState(() {
        _maroons = maroons;
      });
    } catch (e) {
      // print('Error fetching maroons: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Halaman Maroon',
          style: GoogleFonts.poppins(
              color: Color.fromARGB(255, 72, 72, 72),
              fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: Icon(Icons.arrow_back)),

        centerTitle: true, // biar ditengah title nya
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Color.fromARGB(255, 72, 72, 72),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Center(child: Text('Pengembang')),
                    content: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ListView(
                          children: [
                            ListTile(
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.person),
                                ],
                              ),
                              title: const Text("Andhika Bhayangkara"),
                              subtitle: const Text("065120033"),
                            ),
                            
                          ],
                        )),
                    actions: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Tutup'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }),
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: _maroons.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum ada data",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _maroons.length,
              itemBuilder: (context, index) {
                final maroon = _maroons[index];
                return ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.star),
                    ],
                  ),
                  title: Text(maroon.nama),
                  subtitle: Text('message: ${maroon.message}'),
                );
              },
            ),

    );
  }
}
