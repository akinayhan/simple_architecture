import '../../models/market/get_market_product_model.dart';
import '../../models/market/get_market_product_request_model.dart';
import '../../utils/result/data_api_result.dart';
import '../base/get_base_service.dart';

class GetMarketProductService extends GetBaseService {
  static const String endPoint = 'Market/GetMarketProductByCompanyId';

  Future<DataApiResult<List<GetMarketProductModel>>> fetchMarketProduct(String token, GetMarketProductRequestModel requestModel) async {
    return await postRequest<GetMarketProductModel>(endPoint, token, requestModel.toJson(), (data) => GetMarketProductModel.fromJson(data));
  }
}