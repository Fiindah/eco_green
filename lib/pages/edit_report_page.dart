// import 'package:flutter/material.dart';
// import 'package:eco_green/api/reports_api.dart';
// import 'package:eco_green/constant/app_color.dart';
// import 'package:eco_green/models/list_laporan_response.dart'; // Impor model Data

// class EditReportPage extends StatefulWidget {
//   final Data report; // Laporan yang akan diedit

//   const EditReportPage({super.key, required this.report});

//   @override
//   State<EditReportPage> createState() => _EditReportPageState();
// }

// class _EditReportPageState extends State<EditReportPage> {
//   final TextEditingController _judulController = TextEditingController();
//   final TextEditingController _isiController = TextEditingController();
//   final TextEditingController _lokasiController = TextEditingController();
//   // String? _selectedStatus; // Dihapus karena status tidak bisa diedit di sini
//   final ReportService _reportService = ReportService();
//   bool _isLoading = false;
//   String? _message;
//   bool _isSuccess = false;

//   // final List<String> _statusOptions = [ // Dihapus
//   //   'masuk',
//   //   'proses',
//   //   'selesai',
//   // ];

//   @override
//   void initState() {
//     super.initState();
//     // Isi controller dengan data laporan yang ada
//     _judulController.text = widget.report.judul ?? '';
//     _isiController.text = widget.report.isi ?? '';
//     _lokasiController.text = widget.report.lokasi ?? '';
//     // _selectedStatus = widget.report.status?.toLowerCase(); // Dihapus
//   }

//   @override
//   void dispose() {
//     _judulController.dispose();
//     _isiController.dispose();
//     _lokasiController.dispose();
//     super.dispose();
//   }

//   void _updateReport() async {
//     setState(() {
//       _isLoading = true;
//       _message = null;
//       _isSuccess = false;
//     });

//     // Validasi input
//     if (_judulController.text.isEmpty ||
//         _isiController.text.isEmpty ||
//         _lokasiController.text.isEmpty) {
//       // Tidak perlu validasi _selectedStatus
//       setState(() {
//         _message = 'Judul, Isi, dan Lokasi harus diisi.';
//         _isSuccess = false;
//         _isLoading = false;
//       });
//       return;
//     }

//     try {
//       final response = await _reportService.updateReport(
//         reportId: widget.report.id!, // ID laporan yang akan diperbarui
//         judul: _judulController.text,
//         isi: _isiController.text,
//         lokasi: _lokasiController.text,
//         status:
//             widget.report.status!, // Menggunakan status yang ada, tidak diubah
//         imageUrl: widget.report.imageUrl, // Pertahankan URL gambar yang ada
//       );

//       setState(() {
//         _isSuccess = true;
//         _message = response.message ?? 'Laporan berhasil diperbarui!';
//       });
//       // Kembali ke halaman sebelumnya dan berikan sinyal bahwa laporan berhasil diperbarui
//       Navigator.pop(context, true);
//     } catch (e) {
//       setState(() {
//         _isSuccess = false;
//         _message = e.toString().replaceFirst('Exception: ', '');
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Laporan Sampah'),
//         centerTitle: true,
//         backgroundColor: AppColor.mygreen,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _judulController,
//               decoration: InputDecoration(
//                 labelText: 'Judul Laporan',
//                 hintText: 'Misal: Tumpukan Sampah di Jalan',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 prefixIcon: const Icon(Icons.title),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _lokasiController,
//               decoration: InputDecoration(
//                 labelText: 'Lokasi Sampah',
//                 hintText: 'Misal: Jl. Merdeka No. 10',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 prefixIcon: const Icon(Icons.location_on),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _isiController,
//               maxLines: 5,
//               decoration: InputDecoration(
//                 labelText: 'Isi Laporan',
//                 hintText:
//                     'Jelaskan kondisi sampah (misal: Tumpukan sampah plastik dan organik)',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 prefixIcon: const Icon(Icons.description),
//                 alignLabelWithHint: true,
//               ),
//             ),
//             // DropdownButtonFormField untuk status dihapus dari sini
//             const SizedBox(height: 24),
//             _isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : ElevatedButton(
//                   onPressed: _updateReport,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColor.mygreen,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 40,
//                       vertical: 15,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     'Perbarui Laporan',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ),
//             if (_message != null)
//               Padding(
//                 padding: const EdgeInsets.only(top: 16.0),
//                 child: Text(
//                   _message!,
//                   style: TextStyle(
//                     color: _isSuccess ? Colors.green : Colors.red,
//                     fontSize: 14,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
