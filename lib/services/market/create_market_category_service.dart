import '../../../models/market/create_market_category_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/result/api_result.dart';
import '../base/create_base_service.dart';

class CreateMarketCategoryService extends CreateBaseService {
  CreateMarketCategoryService() : super(ApiConstants.apiUrl);

  Future<ApiResult> createMarketCategory(CreateMarketCategoryModel createMarketCategoryModel, String authToken) {
    return post('Market/CreateMarketCategory', createMarketCategoryModel, authToken);
  }
}
