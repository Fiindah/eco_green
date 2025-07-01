import 'dart:io'; // Untuk File

import 'package:eco_green/api/reports_api.dart';
import 'package:eco_green/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Impor image_picker

class AddReportPage extends StatefulWidget {
  const AddReportPage({super.key});

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  final TextEditingController _judulController =
      TextEditingController(); // Controller untuk judul
  final TextEditingController _isiController =
      TextEditingController(); // Controller untuk isi
  final TextEditingController _lokasiController =
      TextEditingController(); // Controller untuk lokasi
  File? _imageFile; // Untuk menyimpan file gambar yang dipilih
  final ImagePicker _picker = ImagePicker(); // Instance ImagePicker

  final ReportService _reportService = ReportService();
  bool _isLoading = false;
  String? _message;
  bool _isSuccess = false;

  @override
  void dispose() {
    _judulController.dispose();
    _isiController.dispose();
    _lokasiController.dispose();
    super.dispose();
  }

  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _submitReport() async {
    setState(() {
      _isLoading = true;
      _message = null;
      _isSuccess = false;
    });

    // Validasi input
    if (_judulController.text.isEmpty ||
        _isiController.text.isEmpty ||
        _lokasiController.text.isEmpty) {
      setState(() {
        _message = 'Judul, Isi, dan Lokasi harus diisi.';
        _isSuccess = false;
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await _reportService.postReport(
        judul: _judulController.text,
        isi: _isiController.text,
        lokasi: _lokasiController.text,
        status: 'masuk', // Status default selalu 'masuk'
        // imageFile: _imageFile, // Meneruskan file gambar
      );

      setState(() {
        _isSuccess = true;
        _message = response.message ?? 'Laporan berhasil dikirim!';
      });
      // Kosongkan field setelah laporan berhasil
      _judulController.clear();
      _isiController.clear();
      _lokasiController.clear();
      setState(() {
        _imageFile = null; // Hapus gambar yang dipilih
      });

      // Kembali ke halaman sebelumnya dan berikan sinyal bahwa laporan berhasil ditambahkan
      Navigator.pop(context, true);
    } catch (e) {
      setState(() {
        _isSuccess = false;
        _message = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Laporan Sampah Baru'),
        centerTitle: true,
        backgroundColor: AppColor.mygreen,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _judulController,
              decoration: InputDecoration(
                labelText: 'Judul Laporan',
                hintText: 'Misal: Tumpukan Sampah di Jalan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.title),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lokasiController,
              decoration: InputDecoration(
                labelText: 'Lokasi Sampah',
                hintText: 'Misal: Jl. Merdeka No. 10',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _isiController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Isi Laporan',
                hintText:
                    'Jelaskan kondisi sampah (misal: Tumpukan sampah plastik dan organik)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.description),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),
            // Bagian untuk memilih dan menampilkan gambar
            _imageFile == null
                ? ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: const Text('Pilih Gambar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.mygreen.withOpacity(0.8),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )
                : Column(
                  children: [
                    Image.file(
                      _imageFile!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    TextButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.change_circle),
                      label: const Text('Ubah Gambar'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColor.mygreen,
                      ),
                    ),
                  ],
                ),
            const SizedBox(height: 24),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                  onPressed: _submitReport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.mygreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Kirim Laporan',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
            if (_message != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _message!,
                  style: TextStyle(
                    color: _isSuccess ? Colors.green : Colors.red,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
