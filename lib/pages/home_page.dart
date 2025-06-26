import 'package:cached_network_image/cached_network_image.dart';
import 'package:eco_green/api/reports_api.dart';
import 'package:eco_green/constant/app_color.dart';
import 'package:eco_green/models/list_laporan_response.dart';
import 'package:eco_green/pages/add_report_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String id = "/home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<ListLaporanResponse>
  _futureReports; // Ubah ke ListLaporanResponse

  @override
  void initState() {
    super.initState();
    _futureReports = ReportService().getReports(); // Panggil service Anda
  }

  // Fungsi untuk refresh data (opsional, tapi sangat direkomendasikan)
  Future<void> _refreshReports() async {
    setState(() {
      _futureReports = ReportService().getReports();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EcoGreen',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColor.mygreen,
        centerTitle: false,
      ),
      body: RefreshIndicator(
        // Menambahkan fitur pull-to-refresh
        onRefresh: _refreshReports,
        child: FutureBuilder<ListLaporanResponse>(
          future: _futureReports,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 50,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Error memuat laporan: ${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _refreshReports,
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                ),
              );
            } else if (!snapshot.hasData ||
                snapshot.data!.data == null ||
                snapshot.data!.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Colors.grey,
                      size: 50,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Belum ada laporan sampah saat ini.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _refreshReports,
                      child: const Text('Refresh'),
                    ),
                  ],
                ),
              );
            } else {
              // Data berhasil dimuat, tampilkan daftar laporan
              final List<Data> reports = snapshot.data!.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  final Data report = reports[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 4.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: InkWell(
                      // Tambahkan InkWell agar card bisa diklik
                      onTap: () {
                        // TODO: Navigasi ke halaman detail laporan jika ada
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Detail Laporan: ${report.judul ?? ''}',
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Judul Laporan
                            Text(
                              report.judul ?? 'Judul Tidak Tersedia',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColor.mygreen,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Status Laporan dengan badge
                            Align(
                              alignment: Alignment.centerRight,
                              child: Chip(
                                label: Text(
                                  report.status?.toUpperCase() ??
                                      'STATUS TIDAK DIKETAHUI',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: _getStatusColor(report.status),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Gambar Laporan (jika ada)
                            if (report.imageUrl != null &&
                                report.imageUrl!.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                  imageUrl: report.imageUrl!,
                                  placeholder:
                                      (context, url) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  errorWidget:
                                      (context, url, error) => const Icon(
                                        Icons.image_not_supported,
                                        size: 60,
                                        color: Colors.grey,
                                      ),
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            if (report.imageUrl != null &&
                                report.imageUrl!.isNotEmpty)
                              const SizedBox(height: 12),

                            // Isi Laporan
                            Text(
                              report.isi ?? 'Isi laporan tidak tersedia.',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Informasi Pengguna (jika ada)
                            if (report.user != null &&
                                report.user!.name != null)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Pelapor: ${report.user!.name}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 4),

                            // Tanggal Dibuat dan Diperbarui
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Dibuat: ${report.createdAt != null ? DateFormat('dd MMM yyyy HH:mm').format(report.createdAt!.toLocal()) : 'N/A'}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  'Diperbarui: ${report.updatedAt != null ? DateFormat('dd MMM yyyy HH:mm').format(report.updatedAt!.toLocal()) : 'N/A'}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bool? result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddReportPage()),
          );
          if (result == true) {
            _refreshReports();
          }
        },
        tooltip: 'Tambah Laporan',
        child: Icon(Icons.add),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'masuk':
        return Colors.blue;
      case 'proses':
        return Colors.orange;
      case 'selesai':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
