import 'package:eco_green/constant/app_color.dart';
import 'package:eco_green/helper/preference.dart';
import 'package:eco_green/welcome_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const String id = "/profile_page";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName = "Memuat...";
  String _userEmail = "Memuat...";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  /// Loads user name and email from SharedPreferences.
  Future<void> _loadUserInfo() async {
    final name = await SharePref.getUserName();
    final email = await SharePref.getUserEmail();
    setState(() {
      _userName = name ?? "Nama Tidak Tersedia";
      _userEmail = email ?? "Email Tidak Tersedia";
    });
  }

  /// Handles user logout.
  Future<void> _logout() async {
    bool confirmLogout =
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text('Konfirmasi Logout'),
              content: const Text('Anda yakin ingin keluar dari akun?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text(
                    'Batal',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.mygreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Logout'),
                ),
              ],
            );
          },
        ) ??
        false;

    if (confirmLogout) {
      await SharePref.clearAll(); // Clear all saved preferences
      // Navigate to WelcomePage and remove all previous routes
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
        (Route<dynamic> route) => false,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Berhasil logout!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Profil Pengguna',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: AppColor.mygreen,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            // User Avatar/Icon
            CircleAvatar(
              radius: 60,
              backgroundColor: AppColor.mygreen.withOpacity(0.2),
              child: Icon(Icons.person, size: 80, color: AppColor.mygreen),
            ),
            const SizedBox(height: 24),
            // User Name
            Text(
              _userName,
              style: TextStyle(fontSize: 28, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // User Email
            Text(
              _userEmail,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            // Divider for separation
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[300],
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(height: 32),

            // Logout Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _logout,
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Red for logout action
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // You can add more profile-related information or actions here
            // For example: Edit Profile button, Change Password button, etc.
          ],
        ),
      ),
    );
  }
}
