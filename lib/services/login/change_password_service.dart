import '../../../utils/result/api_result.dart';
import '../../models/login/change_password_model.dart';
import '../base/update_base_service.dart';

class ChangePasswordService extends UpdateBaseService {
  static const String endPoint = 'Account/ChangePassword';

  Future<ApiResult> changePassword(ChangePasswordModel updateModel, String authToken) async {
    return await postRequest(endPoint, updateModel.toJson(), authToken);
  }
}

