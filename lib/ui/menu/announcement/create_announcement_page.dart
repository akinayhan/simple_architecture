import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/announcement/create_announcement_model.dart';
import '../../../models/announcement/filter_announcement_role_model.dart';
import '../../../models/other/status_model.dart';
import '../../../utils/design/build_dropdown/build_status_dropdown_items.dart';
import '../../../utils/design/form_fields/generic_field.dart';
import '../../../utils/function/select_datetime.dart';
import '../../../view_model/announcement/create_announcement_view_model.dart';
import '../../../../utils/design/button_design/create_material_button.dart';
import '../../../../utils/design/dialog_design/quick_alert_utils.dart';
import '../../../../utils/result/api_result.dart';
import 'build_announcement_role_dropdown_items.dart';

class CreateAnnouncementPage extends StatefulWidget {
  final String token;
  final bool isAdminRole;

  const CreateAnnouncementPage({super.key, required this.token, required this.isAdminRole});

  @override
  CreateAnnouncementPageState createState() => CreateAnnouncementPageState();
}

class CreateAnnouncementPageState extends State<CreateAnnouncementPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  DateTime? _endDate;
  bool _status = true;
  int? _visibilityRole;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final createAnnouncementViewModel = Provider.of<
        CreateAnnouncementViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Duyuru Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: screenHeight * 0.02),
              GenericTextField(controller: _titleController, label: 'Duyuru Başlığı'),
              SizedBox(height: screenHeight * 0.02),
              GenericTextField(controller: _descriptionController, label: 'Duyuru İçeriği'),
              SizedBox(height: screenHeight * 0.02),
              TextFormField(
                onTap: () =>
                    selectDateTime(
                      context: context,
                      controller: _startDateController,
                      isStartDate: true,
                      startDate: null,
                      endDate: _endDate,
                      onDateSelected: (selectedDate) {
                        setState(() {
                          _startDate = selectedDate;
                        });
                      },
                    ),
                controller: _startDateController,
                decoration: const InputDecoration(
                  labelText: 'Başlangıç',
                ),
                readOnly: true,
              ),
              SizedBox(height: screenHeight * 0.02),
              TextFormField(
                onTap: () =>
                    selectDateTime(
                      context: context,
                      controller: _endDateController,
                      isStartDate: false,
                      startDate: _startDate,
                      endDate: null,
                      onDateSelected: (selectedDate) {
                        setState(() {
                          _endDate = selectedDate;
                        });
                      },
                    ),
                controller: _endDateController,
                decoration: const InputDecoration(
                  labelText: 'Bitiş',
                ),
                readOnly: true,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildStatusDropdownButtonFormField(),
              SizedBox(height: screenHeight * 0.02),
              _buildFilterAnnouncementRoleDropdownButtonFormField(),
              SizedBox(height: screenHeight * 0.02),
              CreateMaterialButton(
                onPressed: () =>
                    _onPressedCreateUser(createAnnouncementViewModel),
                label: 'Duyuru Ekle',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedCreateUser(
      CreateAnnouncementViewModel createAnnouncementViewModel) async {
    if (_formKey.currentState!.validate()) {
      CreateAnnouncementModel newAnnouncement = CreateAnnouncementModel(
        title: _titleController.text,
        description: _descriptionController.text,
        visibilityRole: 1,
        status: _status,
        deleted: false,
        startDate: _startDate!,
        endDate: _endDate!,
      );

      ApiResult result = await createAnnouncementViewModel.createAnnouncement(newAnnouncement, widget.token);
      _handleApiResult(result);
    }
  }

  void _handleApiResult(ApiResult result) {
    if (result.success) {
      Navigator.pop(context, true);
      QuickAlertUtils.showSuccess(context, result.messages.join('\n'));
    } else {
      QuickAlertUtils.showError(context, result.messages.join('\n'));
    }
  }

  Widget _buildStatusDropdownButtonFormField() {
    return DropdownButtonFormField<bool>(
      value: _status,
      items: buildStatusDropdownItems(getStatusList()),
      onChanged: (value) {
        setState(() {
          _status = value!;
        });
      },
      decoration: const InputDecoration(labelText: 'Durum Seçin'),
      validator: (value) {
        if (value == null) {
          return 'Lütfen bir durum seçin!';
        }
        return null;
      },
    );
  }

  Widget _buildFilterAnnouncementRoleDropdownButtonFormField() {
    return DropdownButtonFormField<int>(
      value: _visibilityRole,
      items: buildAnnouncementRoleDropdownItems(getAnnouncementRoleList()),
      onChanged: (value) {
        setState(() {
          _visibilityRole = value!;
        });
      },
      decoration: const InputDecoration(labelText: 'Hedef Kitle Seçin'),
      validator: (value) {
        if (value == null) {
          return 'Lütfen bir hedef kitle seçin!';
        }
        return null;
      },
    );
  }
}