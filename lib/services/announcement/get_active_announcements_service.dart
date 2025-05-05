import '../../models/announcement/get_active_announcement_model.dart';
import '../../models/announcement/get_announcement_request_model.dart';
import '../../models/result/data_api_result.dart';
import '../base/get_base_service.dart';

class GetActiveAnnouncementsService extends GetBaseService {
  static const String endPoint = 'Announcement/GetActiveAnnouncements';

  Future<DataApiResult<List<GetActiveAnnouncementModel>>> fetchActiveAnnouncements(String token, GetAnnouncementRequestModel requestModel) async {
    return await postRequest<GetActiveAnnouncementModel>(endPoint, token, requestModel.toJson(), (data) => GetActiveAnnouncementModel.fromJson(data));
  }
}