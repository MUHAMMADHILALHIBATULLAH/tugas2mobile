// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tugas/screens/profile_screen.dart';
// import 'package:http/http.dart' as http;
// import 'package:tugas/models/maroon.dart';
// import 'package:tugas/services/maroon.dart';

// class MaroonScreen extends StatefulWidget {
//   const MaroonScreen({super.key});

//   @override
//   State<MaroonScreen> createState() => _MaroonScreenState();
// }

// class _MaroonScreenState extends State<MaroonScreen> {
//   List<Maroon> _maroons = [];
//   Future<void> _fetchMaroons() async {
//     try {
//       final maroons = await MaroonService.readMaroons();
//       setState(() {
//         _maroons = maroons;
//       });
//     } catch (e) {
//       // print('Error fetching maroons: $e');
//     }
//   }

//   Future<void> _addMaroon(Maroon maroon) async {
//     try {
//       await MaroonService.createMaroon(maroon);
//       await _fetchMaroons();
//     } catch (e) {
//       // print('Error creating maroon: $e');
//     }
//   }

//   Future<void> _updateMaroon(Maroon maroon) async {
//     try {
//       await MaroonService.updateMaroon(maroon.id, maroon.nama, maroon.message);
//       await _fetchMaroons();
//     } catch (e) {
//       // print('Error creating maroon: $e');
//     }
//   }

//   Future<void> _deleteMaroon(Maroon maroon) async {
//     try {
//       await MaroonService.deleteMaroon(maroon.id);
//       setState(() {
//         _maroons.remove(maroon);
//       });
//     } catch (e) {
//       // print('Error deleting maroon: $e');
//     }
//   }

//   Future<void> _showDialog(BuildContext context, Maroon? maroon,
//       {bool delete = false}) {
//     final namaController =
//         TextEditingController(text: maroon != null ? maroon.nama : "");

//     final messageController = TextEditingController(
//         text: maroon != null ? maroon.message.toString() : "0");

//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return delete
//             ? AlertDialog(
//                 title: const Text("Hapus data"),
//                 content: const Text(
//                     'Data ini akan terhapus baik dari aplikasi maupun web service API. Yakin ingin menghapus?'),
//                 actions: <Widget>[
//                   TextButton(
//                     style: TextButton.styleFrom(
//                       textStyle: Theme.of(context).textTheme.labelLarge,
//                     ),
//                     child: const Text('Batal'),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   TextButton(
//                     style: TextButton.styleFrom(
//                       textStyle: Theme.of(context).textTheme.labelLarge,
//                     ),
//                     child: const Text('Hapus'),
//                     onPressed: () {
//                       _deleteMaroon(maroon!);
//                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                       Future.delayed(const Duration(milliseconds: 500),
//                           () => Navigator.of(context).pop());
//                     },
//                   ),
//                 ],
//               )
//             : AlertDialog(
//                 title: maroon != null
//                     ? const Text('Ubah data')
//                     : const Text('Tambah data'),
//                 content: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: namaController,
//                         decoration: const InputDecoration(
//                           labelText: 'Nama',
//                         ),
//                       ),
//                       TextField(
//                         controller: messageController,
//                         decoration: const InputDecoration(
//                           labelText: 'message',
//                         ),
//                         keyboardType: TextInputType.number,
//                       ),
//                     ],
//                   ),
//                 ),
//                 actions: <Widget>[
//                   TextButton(
//                     style: TextButton.styleFrom(
//                       textStyle: Theme.of(context).textTheme.labelLarge,
//                     ),
//                     child: const Text('Batal'),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   TextButton(
//                     style: TextButton.styleFrom(
//                       textStyle: Theme.of(context).textTheme.labelLarge,
//                     ),
//                     child: const Text('Simpan'),
//                     onPressed: () {
//                       final nama = namaController.text;
//                       final message = messageController.text;

//                       maroon != null
//                           ? _updateMaroon(Maroon(
//                               id: maroon.id, nama: nama, message: message))
//                           : _addMaroon(
//                               Maroon(id: 1, nama: nama, message: message));

//                       namaController.clear();
//                       messageController.clear();

//                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                       Future.delayed(const Duration(milliseconds: 500),
//                           () => Navigator.of(context).pop());
//                     },
//                   ),
//                 ],
//               );
//       },
//     );
//   }

//   final snackBar = const SnackBar(
//     content: Text('Yay! Berhasil~'),
//   );

//   @override
//   void initState() {
//     super.initState();
//     _fetchMaroons();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: Text(
//           'Halaman Maroon',
//           style: GoogleFonts.poppins(
//               color: Color.fromARGB(255, 72, 72, 72),
//               fontWeight: FontWeight.w500),
//         ),
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pushNamed(context, '/');
//             },
//             icon: Icon(Icons.arrow_back)),

//         centerTitle: true, // biar ditengah title nya
//         backgroundColor: Color.fromARGB(255, 255, 255, 255),
//         foregroundColor: Color.fromARGB(255, 72, 72, 72),
//         elevation: 0.0,
//         actions: [
//           IconButton(
//             onPressed: () => showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: const Center(child: Text('Pengembang')),
//                     content: SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.2,
//                         width: MediaQuery.of(context).size.width * 0.8,
//                         child: ListView(
//                           children: [
//                             ListTile(
//                               leading: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: const [
//                                   Icon(Icons.person),
//                                 ],
//                               ),
//                               title: const Text("Adam Najmi Zidan"),
//                               subtitle: const Text("Developer"),
//                             ),
//                             ListTile(
//                               leading: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: const [
//                                   Icon(Icons.person),
//                                 ],
//                               ),
//                               title: const Text("Prayoga Anom R."),
//                               subtitle: const Text("Developer"),
//                             )
//                           ],
//                         )),
//                     actions: <Widget>[
//                       TextButton(
//                         style: TextButton.styleFrom(
//                           textStyle: Theme.of(context).textTheme.labelLarge,
//                         ),
//                         child: const Text('Tutup'),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                     ],
//                   );
//                 }),
//             icon: const Icon(Icons.more_vert),
//           )
//         ],
//       ),
//       body: _maroons.isEmpty
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Belum ada data",
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                 ],
//               ),
//             )
//           : ListView.builder(
//               itemCount: _maroons.length,
//               itemBuilder: (context, index) {
//                 final maroon = _maroons[index];
//                 return ListTile(
//                   leading: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Icon(Icons.star),
//                     ],
//                   ),
//                   title: Text(maroon.nama),
//                   subtitle: Text('message: ${maroon.message}'),
//                   onLongPress: () => _showDialog(context, maroon, delete: true),
//                   onTap: () => _showDialog(context, maroon),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => _showDialog(context, null),
//         tooltip: 'Tambah Maroon',
//         label: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Icon(Icons.add),
//             Text("Tambah"),
//           ],
//         ),
//       ),
      
//     );
//   }
// }
