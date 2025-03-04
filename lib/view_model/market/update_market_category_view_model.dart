import '../../../models/market/update_market_category_model.dart';
import '../../../services/market/update_market_category_service.dart';
import '../../../utils/result/api_result.dart';
import '../base/update_base_view_model.dart';

class UpdateMarketCategoryViewModel extends UpdateBaseViewModel<UpdateMarketCategoryService, UpdateMarketCategoryModel> {
  UpdateMarketCategoryViewModel() : super(UpdateMarketCategoryService());

  Future<ApiResult> updateMarketCategory(UpdateMarketCategoryModel categoryModel, String token) {
    return updateOperation(categoryModel, token, _updateOperation);
  }

  Future<ApiResult> _updateOperation(UpdateMarketCategoryModel model, String token) {
    return service.updateMarketCategory(model, token);
  }
}