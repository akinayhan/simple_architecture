import '../../../models/market/create_market_product_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/result/api_result.dart';
import '../base/create_base_service.dart';

class CreateMarketProductService extends CreateBaseService {
  CreateMarketProductService() : super(ApiConstants.apiUrl);

  Future<ApiResult> createMarketProduct(CreateMarketProductModel createMarketProductModel, String authToken) {
    return post('Market/CreateMarketProduct', createMarketProductModel, authToken);
  }
}
