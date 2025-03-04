import '../../../models/market/update_market_product_model.dart';
import '../../../utils/result/api_result.dart';
import '../base/update_base_service.dart';

class UpdateMarketProductService extends UpdateBaseService {
  static const String endPoint = 'Market/UpdateMarketProduct';

  Future<ApiResult> updateMarketProduct(UpdateMarketProductModel updateModel, String authToken) async {
    return await postRequest(endPoint, updateModel.toJson(), authToken);
  }
}