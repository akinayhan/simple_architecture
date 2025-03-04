import '../../../models/market/update_market_product_model.dart';
import '../../../services/market/update_market_product_service.dart';
import '../../../utils/result/api_result.dart';
import '../base/update_base_view_model.dart';

class UpdateMarketProductViewModel extends UpdateBaseViewModel<UpdateMarketProductService, UpdateMarketProductModel> {
  UpdateMarketProductViewModel() : super(UpdateMarketProductService());

  Future<ApiResult> updateMarketProduct(UpdateMarketProductModel productModel, String token) {
    return updateOperation(productModel, token, _updateOperation);
  }

  Future<ApiResult> _updateOperation(UpdateMarketProductModel model, String token) {
    return service.updateMarketProduct(model, token);
  }
}