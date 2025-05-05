import '../../../models/market/create_market_payment_model.dart';
import '../../../services/market/create_market_payment_service.dart';
import '../../models/result/api_result.dart';import '../base/create_base_view_model.dart';

class CreateMarketPaymentViewModel extends CreateBaseViewModel<CreateMarketPaymentService, CreateMarketPaymentModel> {
  CreateMarketPaymentViewModel() : super(CreateMarketPaymentService());

  Future<ApiResult> createMarketPayment(CreateMarketPaymentModel createMarketPaymentModel, String token) {
    return createOperation(createMarketPaymentModel, token, _createOperation);
  }

  Future<ApiResult> _createOperation(CreateMarketPaymentModel model, String token) {
    return service.createMarketPayment(model, token);
  }
}