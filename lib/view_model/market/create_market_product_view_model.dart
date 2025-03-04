import '../../../models/market/create_market_product_model.dart';
import '../../../services/market/create_market_product_service.dart';
import '../../../utils/result/api_result.dart';
import '../base/create_base_view_model.dart';

class CreateMarketProductViewModel extends CreateBaseViewModel<CreateMarketProductService, CreateMarketProductModel> {
  CreateMarketProductViewModel() : super(CreateMarketProductService());

  Future<ApiResult> createMarketProduct(CreateMarketProductModel createMarketProductModel, String token) {
    return createOperation(createMarketProductModel, token, _createOperation);
  }

  Future<ApiResult> _createOperation(CreateMarketProductModel model, String token) {
    return service.createMarketProduct(model, token);
  }
}