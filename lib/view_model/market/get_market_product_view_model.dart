import '../../../models/market/get_market_product_model.dart';
import '../../../services/market/get_market_product_service.dart';
import '../../models/market/get_market_product_request_model.dart';
import '../base/get_base_view_model.dart';

class GetMarketProductsViewModel extends BaseViewModel<GetMarketProductModel> {
  Future<void> fetchMarketProduct(String token, GetMarketProductRequestModel requestModel) async {
    await fetchData(() => GetMarketProductService().fetchMarketProduct(token, requestModel));
  }
}