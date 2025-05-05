import '../../models/market/get_market_category_model.dart';
import '../../models/market/get_market_category_request_model.dart';
import '../../models/result/data_api_result.dart';import '../base/get_base_service.dart';

class GetMarketCategoryService extends GetBaseService {
  static const String endPoint = 'Market/GetMarketCategoryByCompanyId';

  Future<DataApiResult<List<GetMarketCategoryModel>>> fetchMarketCategory(String token, GetMarketCategoryRequestModel requestModel) async {
    return await postRequest<GetMarketCategoryModel>(endPoint, token, requestModel.toJson(), (data) => GetMarketCategoryModel.fromJson(data));
  }
}