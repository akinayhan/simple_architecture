import '../../../utils/constants/api_constants.dart';
import '../../../utils/result/api_result.dart';
import '../../models/announcement/create_announcement_model.dart';
import '../base/create_base_service.dart';

class CreateAnnouncementService extends CreateBaseService {
  CreateAnnouncementService() : super(ApiConstants.apiUrl);

  Future<ApiResult> createAnnouncement(CreateAnnouncementModel createModel, String authToken) {
    return post('Announcement/CreateAnnouncement', createModel, authToken);
  }
}