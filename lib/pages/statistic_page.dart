import 'package:flutter/material.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});
  static const String id = "/statistic_page";

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(children: [Text("Halaman Statistik")])),
    );
  }
}

// import 'package:eco_green/api/reports_api.dart';
// import 'package:eco_green/constant/app_color.dart';
// import 'package:eco_green/constant/app_style.dart'; // Assuming you have AppStyle for fonts
// import 'package:eco_green/models/statistic_response.dart';
// import 'package:flutter/material.dart';

// class StatisticPage extends StatefulWidget {
//   const StatisticPage({super.key});
//   static const String id = "/statistic_page";

//   @override
//   State<StatisticPage> createState() => _StatisticPageState();
// }

// class _StatisticPageState extends State<StatisticPage> {
//   Future<StatistikLaporanResponse>? _futureStatistics;

//   @override
//   void initState() {
//     super.initState();
//     // _loadStatistics();
//   }

//   // void _loadStatistics() {
//   //   setState(() {
//   //     _futureStatistics = ReportService().getReportStatistics().catchError((
//   //       error,
//   //     ) {
//   //       debugPrint('Error fetching statistics: $error');
//   //       throw error; // Re-throw to propagate error to FutureBuilder
//   //     });
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Statistik Laporan',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         backgroundColor: AppColor.mygreen,
//         centerTitle: false,
//       ),
//       body: FutureBuilder<StatistikLaporanResponse>(
//         future: _futureStatistics,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(
//                       Icons.error_outline,
//                       color: Colors.red,
//                       size: 60,
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Gagal memuat statistik: ${snapshot.error}',
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(color: Colors.red, fontSize: 16),
//                     ),
//                     const SizedBox(height: 24),
//                     ElevatedButton.icon(
//                       onPressed:
//                       // _loadStatistics,
//                       icon: const Icon(Icons.refresh),
//                       label: const Text('Coba Lagi'),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: AppColor.mygreen,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 24,
//                           vertical: 12,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           } else if (!snapshot.hasData || snapshot.data?.data == null) {
//             return Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(
//                       Icons.info_outline,
//                       color: Colors.grey,
//                       size: 60,
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Tidak ada data statistik yang tersedia.',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 16, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           } else {
//             final stats = snapshot.data!.data!;
//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Ringkasan Laporan:',
//                     style: TextStyle(fontSize: 22, color: AppColor.mygreen),
//                   ),
//                   const SizedBox(height: 24),
//                   _buildStatCard(
//                     context,
//                     'Laporan Masuk',
//                     stats.masuk ?? 0,
//                     Icons.inbox,
//                     Colors.blue.shade700,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildStatCard(
//                     context,
//                     'Laporan Diproses',
//                     stats.proses ?? 0,
//                     Icons.settings,
//                     Colors.orange.shade700,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildStatCard(
//                     context,
//                     'Laporan Selesai',
//                     stats.selesai ?? 0,
//                     Icons.check_circle,
//                     Colors.green.shade700,
//                   ),
//                   const SizedBox(height: 32),
//                   Text(
//                     'Statistik ini menunjukkan jumlah laporan berdasarkan statusnya.',
//                     style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildStatCard(
//     BuildContext context,
//     String title,
//     int count,
//     IconData icon,
//     Color color,
//   ) {
//     return Card(
//       elevation: 6,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(icon, size: 36, color: color),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(fontSize: 18, color: Colors.black87),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     count.toString(),
//                     style: TextStyle(fontSize: 32, color: color),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
