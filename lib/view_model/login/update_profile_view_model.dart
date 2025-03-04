import '../../../../utils/result/api_result.dart';
import '../../models/login/profile_model.dart';
import '../../services/login/update_profile_service.dart';
import '../base/update_base_view_model.dart';

class UpdateProfileViewModel extends UpdateBaseViewModel<UpdateProfileService, ProfileModel> {
  UpdateProfileViewModel() : super(UpdateProfileService());

  Future<ApiResult> updateProfile(ProfileModel profileModel, String token) {
    return updateOperation(profileModel, token, _updateOperation);
  }

  Future<ApiResult> _updateOperation(ProfileModel model, String token) {
    return service.updateProfile(model, token);
  }
}