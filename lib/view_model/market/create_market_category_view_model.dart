import '../../../models/market/create_market_category_model.dart';
import '../../../services/market/create_market_category_service.dart';
import '../../models/result/api_result.dart';import '../base/create_base_view_model.dart';

class CreateMarketCategoryViewModel extends CreateBaseViewModel<CreateMarketCategoryService, CreateMarketCategoryModel> {
  CreateMarketCategoryViewModel() : super(CreateMarketCategoryService());

  Future<ApiResult> createMarketCategory(CreateMarketCategoryModel createMarketCategoryModel, String token) {
    return createOperation(createMarketCategoryModel, token, _createOperation);
  }

  Future<ApiResult> _createOperation(CreateMarketCategoryModel model, String token) {
    return service.createMarketCategory(model, token);
  }
}