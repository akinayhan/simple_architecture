import '../../models/announcement/create_announcement_model.dart';
import '../../models/result/api_result.dart';
import '../../services/announcement/create_announcement_service.dart';
import '../base/create_base_view_model.dart';

class CreateAnnouncementViewModel extends CreateBaseViewModel<CreateAnnouncementService, CreateAnnouncementModel> {
  CreateAnnouncementViewModel() : super(CreateAnnouncementService());

  Future<ApiResult> createAnnouncement(CreateAnnouncementModel createModel, String token) {
    return createOperation(createModel, token, _createOperation);
  }

  Future<ApiResult> _createOperation(CreateAnnouncementModel model, String token) {
    return service.createAnnouncement(model, token);
  }
}