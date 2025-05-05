import '../../models/announcement/update_announcement_model.dart';
import '../../models/result/api_result.dart';
import '../base/update_base_service.dart';

class UpdateAnnouncementService extends UpdateBaseService {
  static const String endPoint = 'Announcement/UpdateAnnouncement';

  Future<ApiResult> updateAnnouncement(UpdateAnnouncementModel updateModel, String authToken) async {
    return await postRequest(endPoint, updateModel.toJson(), authToken);
  }
}