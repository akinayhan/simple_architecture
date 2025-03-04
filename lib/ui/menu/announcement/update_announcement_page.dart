import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../utils/design/dialog_design/quick_alert_utils.dart';
import '../../../../utils/result/api_result.dart';
import '../../../../utils/design/button_design/update_material_button.dart';
import '../../../../utils/design/form_fields/generic_field.dart';
import '../../../models/announcement/filter_announcement_role_model.dart';
import '../../../models/announcement/get_active_announcement_model.dart';
import '../../../models/announcement/update_announcement_model.dart';
import '../../../models/other/status_model.dart';
import '../../../utils/design/build_dropdown/build_status_dropdown_items.dart';
import '../../../utils/design/button_design/delete_material_button.dart';
import '../../../utils/function/select_datetime.dart';
import '../../../view_model/announcement/update_announcement_view_model.dart';
import 'build_announcement_role_dropdown_items.dart';

class UpdateAnnouncementPage extends StatefulWidget {
  final GetActiveAnnouncementModel announcementModel;
  final String token;

  const UpdateAnnouncementPage({super.key, required this.announcementModel, required this.token});

  @override
  UpdateAnnouncementPageState createState() => UpdateAnnouncementPageState();
}

class UpdateAnnouncementPageState extends State<UpdateAnnouncementPage> {
  final _formKey = GlobalKey<FormState>();
  bool _status = true;
  bool _deleted = false;
  int? _visibilityRole;
  DateTime? _startDate;
  DateTime? _endDate;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final dateFormatter = DateFormat('yyyy-MM-dd');
    setState(() {
      _titleController.text = widget.announcementModel.title;
      _descriptionController.text = widget.announcementModel.description;
      _startDate = widget.announcementModel.startDate;
      _endDate = widget.announcementModel.endDate;
      _startDateController.text = _startDate != null ? dateFormatter.format(_startDate!) : '';
      _endDateController.text = _endDate != null ? dateFormatter.format(_endDate!) : '';
      _status = widget.announcementModel.status;
      _deleted = widget.announcementModel.deleted;
      _visibilityRole = widget.announcementModel.visibilityRole;
    });
  }



  @override
  Widget build(BuildContext context) {
    final updateAnnouncementViewModel = Provider.of<UpdateAnnouncementViewModel>(context);
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanıcıyı Düzenle'),
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
              UpdateMaterialButton(
                onPressed: () => _onPressedUpdateAnnouncement(updateAnnouncementViewModel),
                label: 'Düzenle',
              ),
              DeleteMaterialButton(
                onPressed: () => _onPressedDeleteAnnouncement(updateAnnouncementViewModel),
                label: 'Sil',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedUpdateAnnouncement(UpdateAnnouncementViewModel updateAnnouncementViewModel) async {
    if (_formKey.currentState!.validate()) {
      UpdateAnnouncementModel newEmployee = UpdateAnnouncementModel(
        id: widget.announcementModel.id,
        title: _titleController.text,
        description: _descriptionController.text,
        visibilityRole: _visibilityRole!,
        status: _status,
        deleted: _deleted,
        startDate: _startDate!,
        endDate: _endDate!
      );

      ApiResult result = await updateAnnouncementViewModel.updateAnnouncement(newEmployee, widget.token);
      _handleApiResult(result);
    }
  }

  void _onPressedDeleteAnnouncement(UpdateAnnouncementViewModel updateAnnouncementViewModel) async {
    if (_formKey.currentState!.validate()) {
      UpdateAnnouncementModel newEmployee = UpdateAnnouncementModel(
        id: widget.announcementModel.id,
        title: widget.announcementModel.title,
        description: widget.announcementModel.description,
        visibilityRole: widget.announcementModel.visibilityRole,
        status: widget.announcementModel.status,
        deleted: true,
        startDate: widget.announcementModel.startDate,
        endDate: widget.announcementModel.endDate,
      );

      ApiResult result = await updateAnnouncementViewModel.updateAnnouncement(newEmployee, widget.token);
      _handleApiResult(result);
    }
  }

  void _handleApiResult(ApiResult result) {
    if (result.success) {
      Navigator.pop(context, true);
      QuickAlertUtils.showSuccess(context, result.messages.join('\n'));
    } else {
      if(result.messages.isEmpty){
        QuickAlertUtils.showError(context, 'Oturum Sonlanmıştır. Tekrar giriş yapın.');
      }else{
        QuickAlertUtils.showError(context, result.messages.join('\n'));
      }
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