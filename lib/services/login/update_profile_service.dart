import '../../../utils/result/api_result.dart';
import '../../models/login/profile_model.dart';
import '../base/update_base_service.dart';

class UpdateProfileService extends UpdateBaseService {
  static const String endPoint = 'Account/UpdatedAuthorizedUser';

  Future<ApiResult> updateProfile(ProfileModel updateModel, String authToken) async {
    return await postRequest(endPoint, updateModel.toJson(), authToken);
  }
}