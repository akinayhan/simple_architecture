import '../../../models/market/create_market_payment_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/result/api_result.dart';
import '../base/create_base_service.dart';

class CreateMarketPaymentService extends CreateBaseService {
  CreateMarketPaymentService() : super(ApiConstants.apiUrl);

  Future<ApiResult> createMarketPayment(CreateMarketPaymentModel createMarketPaymentModel, String authToken) {
    return post('Market/CreateMarketPayment', createMarketPaymentModel, authToken);
  }
}
