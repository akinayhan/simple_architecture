import '../../../models/market/get_market_payment_by_company_id_model.dart';
import '../../../services/market/get_market_payment_by_company_id_service.dart';
import '../../models/market/get_market_payment_request_model.dart';
import '../base/get_base_view_model.dart';

class GetMarketPaymentByCompanyIdViewModel extends BaseViewModel<GetMarketPaymentByCompanyIdModel> {
  Future<void> fetchMarketPaymentByCompanyId(String token, GetMarketPaymentRequestModel requestModel) async {
    await fetchData(() => GetMarketPaymentByCompanyIdService().fetchMarketPaymentByCompanyId(token, requestModel));
  }
}