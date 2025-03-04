import 'package:flutter/material.dart';
import '../../../../models/other/status_model.dart';
import '../../../../utils/design/build_dropdown/build_status_dropdown_items.dart';
import '../../../../utils/design/dialog_design/quick_alert_utils.dart';
import '../../../models/announcement/get_active_announcement_model.dart';
import '../../../models/announcement/get_announcement_request_model.dart';
import '../../../view_model/announcement/get_active_announcement_view_model.dart';
import 'create_announcement_page.dart';
import 'list_announcement_card.dart';
import 'update_announcement_page.dart';

class GetAnnouncementPage extends StatefulWidget {
  final String token;
  final bool isAdminRole;
  final bool isCustomerRole;
  final bool isSubCustomerRole;
  final bool isEndUserRole;

  const GetAnnouncementPage({super.key, required this.token, required this.isAdminRole, required this.isCustomerRole, required this.isEndUserRole, required this.isSubCustomerRole});

  @override
  GetAnnouncementPageState createState() => GetAnnouncementPageState();
}

class GetAnnouncementPageState extends State<GetAnnouncementPage> {
  final GetActiveAnnouncementsViewModel _viewModel = GetActiveAnnouncementsViewModel();
  bool _isLoading = true;
  bool status = true;
  bool deleted = false;
  List<GetActiveAnnouncementModel> allAnnouncements = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    try {
      List<int> visibilityRoles = _getVisibilityRolesBasedOnRole();
      List<GetActiveAnnouncementModel> tempAnnouncements = [];

      for (var role in visibilityRoles) {
        GetAnnouncementRequestModel requestModel = GetAnnouncementRequestModel(
          status: status,
          deleted: deleted,
          visibilityRole: role,
        );

        await _viewModel.fetchActiveAnnouncements(widget.token, requestModel);

        if (_viewModel.result.success) {
          tempAnnouncements.addAll(_viewModel.result.data ?? []);
        } else {
          _handleApiResult();
        }
      }

      setState(() {
        allAnnouncements = tempAnnouncements;
        _isLoading = false;
      });
    } catch (error) {
      _handleApiResult();
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<int> _getVisibilityRolesBasedOnRole() {
    if (widget.isAdminRole) {
      return [1, 2, 3];
    } else if (widget.isCustomerRole || widget.isSubCustomerRole) {
      return [1, 2];
    } else if (widget.isEndUserRole) {
      return [1, 3];
    }
    return [1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Duyurular'),
        actions: [
          if (widget.isAdminRole)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _navigateToCreateAnnouncementPage(context);
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if(widget.isAdminRole)
            _buildDropdownButtonFormField(),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildEmployeesList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeesList() {
    if (allAnnouncements.isEmpty) {
      return Center(
        child: Text('Kayıtlı veri bulunamadı.'),
      );
    }

    return ListView.builder(
      itemCount: allAnnouncements.length,
      itemBuilder: (context, index) {
        var announcement = allAnnouncements[index];
        return ListAnnouncementCard.buildAnnouncementCard(
          title: announcement.title,
          description: announcement.description,
          startDate: announcement.startDate,
          endDate: announcement.endDate,
          onTap: () {
            if (widget.isAdminRole) {
              _navigateToUpdateAnnouncementPage(announcement);
            }
          },
        );
      },
    );
  }

  void _navigateToCreateAnnouncementPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateAnnouncementPage(token: widget.token, isAdminRole: widget.isAdminRole),
      ),
    );
    if (result == true) {
      _loadData();
    }
  }

  void _navigateToUpdateAnnouncementPage(GetActiveAnnouncementModel announcementModel) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateAnnouncementPage(announcementModel: announcementModel, token: widget.token),
      ),
    );
    if (result == true) {
      _loadData();
    }
  }

  Widget _buildDropdownButtonFormField() {
    return DropdownButtonFormField<bool>(
      value: status,
      items: buildStatusDropdownItems(getStatusList()),
      onChanged: (value) {
        setState(() {
          status = value!;
          _loadData();
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

  void _handleApiResult() {
    if (!_viewModel.result.success) {
      if (_viewModel.result.messages.isNotEmpty) {
        QuickAlertUtils.showError(context, _viewModel.result.messages.join(", "));
      } else {
        QuickAlertUtils.showError(context, 'Oturum Sonlanmıştır. Tekrar giriş yapın.');
      }
    }
  }
}