import 'dart:io'; // Untuk File

import 'package:eco_green/api/reports_api.dart';
import 'package:eco_green/constant/app_color.dart';
import 'package:eco_green/models/laporan_response.dart';
import 'package:flutter/material.dart';

class AddReportPage extends StatefulWidget {
  const AddReportPage({super.key});

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  final _formKey = GlobalKey<FormState>(); // Kunci untuk validasi form
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();

  File? _imageFile; // Untuk menyimpan gambar yang dipilih
  // final ImagePicker _picker = ImagePicker(); // Instance ImagePicker

  bool _isLoading = false; // Untuk indikator loading saat submit

  // Daftar status yang mungkin (sesuaikan dengan API Anda)
  final List<String> _statusOptions = ['Masuk', 'Proses', 'Selesai'];
  String? _selectedStatus; // Status yang dipilih

  @override
  void initState() {
    super.initState();
    // Set status default jika diinginkan, misal 'Masuk'
    _selectedStatus = _statusOptions[0];
  }

  // Fungsi untuk memilih gambar dari galeri
  // Future<void> _pickImage(ImageSource source) async {
  //   final pickedFile = await _picker.pickImage(
  //     source: source,
  //     imageQuality: 70,
  //   ); // imageQuality untuk kompresi

  //   setState(() {
  //     if (pickedFile != null) {
  //       _imageFile = File(pickedFile.path);
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Tidak ada gambar yang dipilih.')),
  //       );
  //     }
  //   });
  // }

  // Dialog untuk memilih sumber gambar
  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Kamera'),
                  onTap: () {
                    Navigator.pop(context);
                    // _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Galeri'),
                  onTap: () {
                    Navigator.pop(context);
                    // _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
    );
  }

  // Fungsi untuk mengirim laporan
  Future<void> _submitReport() async {
    if (_formKey.currentState!.validate()) {
      if (_imageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Harap pilih gambar laporan.')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        final LaporanResponse response = await ReportService().postReport(
          judul: _judulController.text,
          isi: _isiController.text,
          status:
              _selectedStatus!, // Pastikan tidak null karena sudah ada default
          //  imageFile: _imageFile!,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Laporan berhasil ditambahkan: ${response.message}'),
          ),
        );
        Navigator.pop(
          context,
          true,
        ); // Kembali ke halaman sebelumnya dan beri tahu bahwa laporan berhasil ditambahkan
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambahkan laporan: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _isiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Laporan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: AppColor.mygreen,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: _judulController,
                        decoration: const InputDecoration(
                          labelText: 'Judul Laporan',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.title),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Judul tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _isiController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Isi Laporan',
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.description),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Isi laporan tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        value: _selectedStatus,
                        decoration: const InputDecoration(
                          labelText: 'Status Laporan',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.info_outline),
                        ),
                        items:
                            _statusOptions.map((String status) {
                              return DropdownMenuItem<String>(
                                value: status,
                                child: Text(status),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedStatus = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Status tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      // Bagian untuk pemilihan gambar
                      GestureDetector(
                        onTap: () => _showImageSourceActionSheet(context),
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child:
                              _imageFile != null
                                  ? Image.file(_imageFile!, fit: BoxFit.cover)
                                  : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey[700],
                                        size: 50,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Pilih Gambar Laporan',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _submitReport,
                          label: const Text(
                            'Kirim Laporan',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.mygreen,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
