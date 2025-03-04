import '../../../utils/result/api_result.dart';
import '../../models/login/change_password_model.dart';
import '../../services/login/change_password_service.dart';
import '../base/update_base_view_model.dart';

class ChangePasswordViewModel extends UpdateBaseViewModel<ChangePasswordService, ChangePasswordModel> {
  ChangePasswordViewModel() : super(ChangePasswordService());

  Future<ApiResult> changePassword(ChangePasswordModel changePasswordModel, String token) {
    return updateOperation(changePasswordModel, token, _updateOperation);
  }

  Future<ApiResult> _updateOperation(ChangePasswordModel model, String token) {
    return service.changePassword(model, token);
  }
}