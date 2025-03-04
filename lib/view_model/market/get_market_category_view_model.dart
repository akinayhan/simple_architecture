import '../../../models/market/get_market_category_model.dart';
import '../../../services/market/get_market_category_service.dart';
import '../../models/market/get_market_category_request_model.dart';
import '../base/get_base_view_model.dart';

class GetMarketCategoriesViewModel extends BaseViewModel<GetMarketCategoryModel> {
  Future<void> fetchMarketCategory(String token, GetMarketCategoryRequestModel requestModel) async {
    await fetchData(() => GetMarketCategoryService().fetchMarketCategory(token, requestModel));
  }
}