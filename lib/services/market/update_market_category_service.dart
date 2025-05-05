import '../../../models/market/update_market_category_model.dart';
import '../../models/result/api_result.dart';import '../base/update_base_service.dart';

class UpdateMarketCategoryService extends UpdateBaseService {
  static const String endPoint = 'Market/UpdateMarketCategory';

  Future<ApiResult> updateMarketCategory(UpdateMarketCategoryModel updateModel, String authToken) async {
    return await postRequest(endPoint, updateModel.toJson(), authToken);
  }
}