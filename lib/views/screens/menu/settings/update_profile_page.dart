import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/login/profile_model.dart';
import '../../../../models/result/api_result.dart';
import '../../../../utils/function/delete_shared_preferences.dart';
import '../../../../view_model/login/update_profile_view_model.dart';
import '../../../navigate/navigate_to_login.dart';
import '../../../widgets/button_design/update_material_button.dart';
import '../../../widgets/dialog_design/quick_alert_utils.dart';
import '../../../widgets/form_fields/email_field.dart';
import '../../../widgets/form_fields/generic_field.dart';
import '../../../widgets/form_fields/phone_field.dart';

class UpdateProfilePage extends StatefulWidget {
  final String? token;
  final String? userName;
  final String? fullName;
  final String? phoneNumber;
  final String? email;

  const UpdateProfilePage({
    super.key,
    this.token,
    this.userName,
    this.fullName,
    this.phoneNumber,
    this.email,
  });

  @override
  UpdateProfilePageState createState() => UpdateProfilePageState();
}

class UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _fullNameController;
  late TextEditingController _userNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.fullName ?? '');
    _userNameController = TextEditingController(text: widget.userName ?? '');
    _emailController = TextEditingController(text: widget.email ?? '');
    _phoneController = TextEditingController(text: widget.phoneNumber ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final updateProfileViewModel = Provider.of<UpdateProfileViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Güncelleme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GenericTextField(controller: _fullNameController, label: 'İsim Soyisim'),
              const SizedBox(height: 20),
              GenericTextField(controller: _userNameController, label: 'Kullanıcı Adı'),
              const SizedBox(height: 20),
              EmailField(controller: _emailController),
              const SizedBox(height: 20),
              PhoneField(controller: _phoneController),
              const SizedBox(height: 40),
              UpdateMaterialButton(
                label: 'Güncelle',
                onPressed: () => _onPressedUpdateProfile(updateProfileViewModel),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedUpdateProfile(UpdateProfileViewModel updateProfileViewModel) async {
    if (_formKey.currentState!.validate()) {
      ProfileModel updateProfile = ProfileModel(
        fullName: _fullNameController.text,
        userName: _userNameController.text,
        email: _emailController.text,
        phoneNumber: _phoneController.text,
      );

      ApiResult result = await updateProfileViewModel.updateProfile(updateProfile, widget.token!);
      _handleApiResult(result);
    }
  }

  void _handleApiResult(ApiResult result) {
    if (result.success) {
      navigateToLoginPage();
      clearAllSharedPreferences();
      QuickAlertUtils.showSuccess(context, result.messages.join('\n'));
    } else {
      if(result.messages.isEmpty){
        QuickAlertUtils.showError(context, 'Oturum Sonlanmıştır. Tekrar giriş yapın.');
      }else{
        QuickAlertUtils.showError(context, result.messages.join('\n'));
      }
    }
  }
}