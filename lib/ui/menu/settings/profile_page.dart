import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/function/delete_shared_preferences.dart';
import '../../../../utils/design/dialog_design/quick_alert_utils.dart';
import '../../../utils/navigate/navigate_to_login.dart';
import '../../../utils/result/api_result.dart';
import '../../login/change_password_page.dart';
import 'option_card.dart';
import '../../../utils/theme/theme_utils.dart';
import '../../../view_model/login/log_out_view_model.dart';
import 'update_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  String? _token;
  String? _userName;
  String? _fullName;
  String? _phoneNumber;
  String? _email;

  @override
  void initState() {
    super.initState();
    _getTokenFromSharedPreferences();
  }

  Future<void> _getTokenFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('TOKEN') ?? '';
      _userName = prefs.getString('USER_NAME');
      _fullName = prefs.getString('FULL_NAME');
      _phoneNumber = prefs.getString('PHONE_NUMBER');
      _email = prefs.getString('EMAIL');
    });
  }

  @override
  Widget build(BuildContext context) {
    final logOutViewModel = Provider.of<LogOutViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          Consumer<ThemeNotifier>(
            builder: (context, themeNotifier, child) {
              return IconButton(
                icon: Icon(
                  themeNotifier.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () {
                  themeNotifier.toggleTheme();
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileInfoSection(context),
            const SizedBox(height: 20.0),
            OptionCard(
              icon: Icons.key_outlined,
              title: 'Parola Değiştir',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePasswordPage(
                      token: _token!,
                    ),
                  ),
                );
              },
            ),
            OptionCard(
              icon: Icons.exit_to_app,
              title: 'Oturumu Kapat',
              onPressed: () {
                _onPressedLogOut(logOutViewModel);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfoSection(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                width: 140,
                height: 140,
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.person_outline,
                    size: 100.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _fullName ?? 'Ad Soyad Bilgisi Yok',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildInfoItem(Icons.email, _email ?? 'Email Bilgisi Yok'),
              _buildInfoItem(Icons.phone, _phoneNumber ?? 'Telefon Bilgisi Yok'),
            ],
          ),
        ),
        Positioned(
          top: 10.0,
          right: 10.0,
          child: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateProfilePage(
                    token: _token ?? '',
                    userName: _userName,
                    fullName: _fullName,
                    phoneNumber: _phoneNumber,
                    email: _email,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  void _onPressedLogOut(LogOutViewModel logOutViewModel) async {
    ApiResult result = await logOutViewModel.logOut(_token!);
    _handleApiResult(result);
  }

  void _handleApiResult(ApiResult result) {
    if (result.success) {
      navigateToLoginPage();
      clearAllSharedPreferences();
      QuickAlertUtils.showSuccess(context, result.messages.join('\n'));
    } else {
      if (result.messages.isEmpty) {
        navigateToLoginPage();
        QuickAlertUtils.showError(context, 'Oturum Sonlanmıştır. Tekrar giriş yapın.');
      } else {
        QuickAlertUtils.showError(context, result.messages.join('\n'));
      }
    }
  }
}
