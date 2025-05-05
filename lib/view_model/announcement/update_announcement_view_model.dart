import '../../models/announcement/update_announcement_model.dart';
import '../../models/result/api_result.dart';
import '../../services/announcement/update_announcement_service.dart';
import '../base/update_base_view_model.dart';

class UpdateAnnouncementViewModel extends UpdateBaseViewModel<UpdateAnnouncementService, UpdateAnnouncementModel> {
  UpdateAnnouncementViewModel() : super(UpdateAnnouncementService());

  Future<ApiResult> updateAnnouncement(UpdateAnnouncementModel updateModel, String token) {
    return updateOperation(updateModel, token, _updateOperation);
  }

  Future<ApiResult> _updateOperation(UpdateAnnouncementModel model, String token) {
    return service.updateAnnouncement(model, token);
  }
}
