import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/login/sign_up_model.dart';
import '../../utils/constants/user_agreement.dart';
import '../../utils/design/dialog_design/quick_alert_utils.dart';
import '../../view_model/login/sign_up_view_model.dart';
import '../../view_model/other/city_view_model.dart';
import '../../view_model/other/district_view_model.dart';
import '../../../utils/result/api_result.dart';
import '../../utils/design/build_dropdown/build_city_dropdown_items.dart';
import '../../utils/design/build_dropdown/build_district_dropdown_items.dart';
import '../../utils/design/button_design/create_material_button.dart';
import '../../utils/design/form_fields/confirm_password_field.dart';
import '../../utils/design/form_fields/email_field.dart';
import '../../utils/design/form_fields/generic_field.dart';
import '../../utils/design/form_fields/password_field.dart';
import '../../utils/design/form_fields/phone_field.dart';

class SignUpPage extends StatefulWidget {

  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  late CityViewModel cityViewModel;
  late DistrictViewModel districtViewModel;
  int? _selectedCityId;
  int? _selectedDistrictId;
  bool _dataLoaded = false;
  bool _isAgreementChecked = false;
  bool _isLoading = false;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressDetailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    cityViewModel = Provider.of<CityViewModel>(context, listen: false);
    await cityViewModel.fetchCities();
    setState(() {
      _dataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    districtViewModel = Provider.of<DistrictViewModel>(context);
    final signUpViewModel = Provider.of<SignUpViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt Ol'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 12.0),
                  GenericTextField(controller: _fullNameController, label: 'İsim - Soyisim'),
                  const SizedBox(height: 12.0),
                  GenericTextField(controller: _userNameController, label: 'Kullanıcı Adı'),
                  const SizedBox(height: 12.0),
                  EmailField(controller: _emailController),
                  const SizedBox(height: 12.0),
                  PasswordField(controller: _passwordController, label: 'Parola'),
                  const SizedBox(height: 12.0),
                  ConfirmPasswordField(passwordController: _passwordController, confirmController: _confirmPasswordController, label: 'Parola Tekrarı'),
                  const SizedBox(height: 12.0),
                  PhoneField(controller: _phoneNumberController),
                  const SizedBox(height: 12.0),
                  GenericTextField(controller: _addressDetailController, label: 'Adres Detayı'),
                  const SizedBox(height: 12.0),
                  DropdownButtonFormField<int>(
                    value: _selectedCityId,
                    items: _dataLoaded ? buildCityDropdownItems(cityViewModel.cities) : null,
                    onChanged: (int? value) {
                      _onCityChanged(value);
                    },
                    decoration: const InputDecoration(labelText: 'Şehir Seçin'),
                    validator: (value) {
                      if (value == null) {
                        return 'Lütfen bir şehir seçin!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<int>(
                    value: _selectedDistrictId,
                    items: _dataLoaded ? buildDistrictDropdownItems(districtViewModel.districts, _selectedCityId ?? 0) : null,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedDistrictId = value;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'İlçe Seçin'),
                    validator: (value) {
                      if (value == null) {
                        return 'Lütfen bir ilçe seçin!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    children: [
                      Checkbox(
                        value: _isAgreementChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isAgreementChecked = value ?? false;
                          });
                        },
                      ),
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Kullanıcı sözleşmesini ',
                                style: const TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()..onTap = _showAgreementDialog,
                              ),
                              const TextSpan(
                                text: 'okudum, onaylıyorum',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  CreateMaterialButton(
                    onPressed: () => _onPressedSignUp(signUpViewModel),
                    label: 'Kayıt Ol',
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  void _onCityChanged(int? value) {
    setState(() {
      _selectedCityId = value;
      _selectedDistrictId = null;
      districtViewModel.clearDistricts();
      if (_selectedCityId != null) {
        districtViewModel.fetchDistricts(_selectedCityId!);
      }
    });
  }

  void _onPressedSignUp(SignUpViewModel signUpViewModel) async {
    if (!_isAgreementChecked) {
      QuickAlertUtils.showError(context, 'Kullanıcı sözleşmesini onaylamanız gerekiyor.');
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      SignUpModel newSignUp = SignUpModel(
        fullName: _fullNameController.text,
        userName: _userNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        phoneNumber: _phoneNumberController.text,
        cityId: _selectedCityId!,
        districtId: _selectedDistrictId!,
        roleName: 'EndUser',
        addressDetail: _addressDetailController.text,
      );

      ApiResult result = await signUpViewModel.signUpOperation(newSignUp);
      setState(() {
        _isLoading = false;
      });
      _handleApiResult(result);
    }
  }

  void _handleApiResult(ApiResult result) {
    if (result.success) {
      Navigator.pop(context, true);
      QuickAlertUtils.showSuccess(context, result.messages.join('\n'));
    } else {
      QuickAlertUtils.showError(context, result.messages.isEmpty
          ? 'Oturum Sonlanmıştır. Tekrar giriş yapın.'
          : result.messages.join('\n'));
    }
  }

  void _showAgreementDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kullanıcı Sözleşmesi'),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userAgreementText),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _isAgreementChecked = true;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Okudum, Onaylıyorum'),
            ),
          ],
        );
      },
    );
  }
}