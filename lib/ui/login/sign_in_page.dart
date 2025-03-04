import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' as services;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/login/login_response_model.dart';
import '../../models/login/sign_in_model.dart';
import '../../utils/design/background_design/background_gradient.dart';
import '../../utils/design/button_design/sign_up_material_button.dart';
import '../../utils/design/button_design/whatsapp_url_button.dart';
import '../../utils/function/app_exit_helper.dart';
import '../../utils/function/save_token_data.dart';
import '../../utils/design/dialog_design/quick_alert_utils.dart';
import '../../utils/design/form_fields/login_password_field.dart';
import '../../utils/design/form_fields/login_username_field.dart';
import '../../utils/navigate/navigate_to_forgot_password.dart';
import '../../utils/navigate/navigate_to_menu_page.dart';
import '../../utils/navigate/navigate_to_sign_up.dart';
import '../../utils/result/data_api_result.dart';
import '../../utils/theme/colors.dart';
import '../../view_model/login/sign_in_view_model.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberCredentials = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadRememberCredentials();
  }

  @override
  Widget build(BuildContext context) {
    bool isWeb = MediaQuery.of(context).size.width > 600;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if(didPop) {
          return;
        }
        AppExitHelper.onWillPop(context);
      },
      child: Scaffold(
        body: Stack(
          children: [
            BackgroundGradient(),
            ChangeNotifierProvider(
              create: (_) => SignInViewModel(),
              child: Consumer<SignInViewModel>(
                builder: (context, viewModel, _) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : Form(
                        key: _formKey,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            if (isWeb)
                              Center(
                                child: Container(
                                  width: 400,
                                  padding: EdgeInsets.all(32.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: _buildLoginForm(context),
                                ),
                              )
                            else
                              _buildLoginForm(context),
                          ],
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

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          alignment: Alignment.center,
          child: Image.asset('assets/icons/icon.png'),
        ),
        LoginUserNameField(controller: _userNameController),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        LoginPasswordField(controller: _passwordController),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        buildCheckboxListTile(),
        SignUpMaterialButton(label: 'Giriş Yap', onPressed: _performSignIn),
        TextButton(
          onPressed: () => goToForgotPasswordScreen(context),
          child: Text(
            'Şifremi Unuttum !',
            style: TextStyle(
              color: Colors.red.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hesabınız yok mu ?',
              style: TextStyle(
                color: CorporateColors.myWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => goToSignUpPage(context),
              child: Text(
                'Kayıt Olun.',
                style: TextStyle(
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const Divider(),
        whatsappUrlButton(context),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        FutureBuilder<String>(
          future: fetchLatestVersion(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Yükleniyor...", style: TextStyle(fontSize: 12)));
            }
            if (snapshot.hasError) {
              return Center(child: Text("Hata: ${snapshot.error}", style: TextStyle(fontSize: 12)));
            }
            return Center(child: Text(snapshot.data ?? "Versiyon bulunamadı", style: TextStyle(fontSize: 12)));
          },
        ),
      ],
    );
  }

  Future<String> fetchLatestVersion() async {
    final String response = await services.rootBundle.loadString('assets/update_version_notes.json');
    final data = jsonDecode(response);
    return data['versions'][0]['version'];
  }

  CheckboxListTile buildCheckboxListTile() {
    return CheckboxListTile(
      title: const Text('Beni Hatırla', style: TextStyle(color: CorporateColors.myWhite)),
      value: _rememberCredentials,
      onChanged: (value) {
        setState(() {
          _rememberCredentials = value!;
        });
      },
    );
  }

  void _performSignIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      final signInModel = SignInModel(userName: _userNameController.text, password: _passwordController.text);

      final viewModel = Provider.of<SignInViewModel>(context, listen: false);

      final result = await viewModel.signInWithUserAndPassword(signInModel);

      _handleApiResult(result);

      setState(() {
        isLoading = false;
      });
    }
  }

  void _handleApiResult(DataApiResult<LoginResponseModel> result) async {
    if (result.success) {
      final loginResponse = result.data;
      if (loginResponse != null) {
        await saveTokenData(loginResponse.token);
        await _saveCredentials(_userNameController.text, _passwordController.text);
        navigateToMenuPage(context);
      }
    } else {
      QuickAlertUtils.showError(context, result.messages.join('\n'));
    }
  }

  Future<void> _saveCredentials(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('REMEMBER_CREDENTIALS', _rememberCredentials);

    if (_rememberCredentials) {
      await prefs.setString('USER_NAME', username);
      await prefs.setString('PASSWORD', password);
    } else {
      await prefs.remove('USER_NAME');
      await prefs.remove('PASSWORD');
    }
  }

  void _loadRememberCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberCredentials = prefs.getBool('REMEMBER_CREDENTIALS') ?? false;
      if (_rememberCredentials) {
        _userNameController.text = prefs.getString('USER_NAME') ?? '';
        _passwordController.text = prefs.getString('PASSWORD') ?? '';
      }
    });
  }
}