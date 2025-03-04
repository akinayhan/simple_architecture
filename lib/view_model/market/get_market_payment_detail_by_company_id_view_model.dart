import '../../../models/market/get_market_payment_detail_by_company_id_model.dart';
import '../../../services/market/get_market_payment_detail_by_company_id_service.dart';
import '../../models/market/get_market_payment_detail_by_company_id_request_model.dart';
import '../base/get_base_view_model.dart';

class GetMarketPaymentDetailByCompanyIdViewModel extends BaseViewModel<GetMarketPaymentDetailByCompanyIdModel> {
  Future<void> fetchMarketPaymentDetail(String token, GetMarketPaymentDetailByCompanyIdRequestModel requestModel) async {
    await fetchData(() => GetMarketPaymentDetailByCompanyIdService().fetchMarketPaymentDetail(token, requestModel));
  }
}