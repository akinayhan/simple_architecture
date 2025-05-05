import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../models/market/get_market_payment_by_company_id_model.dart';
import '../../../../../models/market/get_market_payment_detail_by_company_id_request_model.dart';
import '../../../../../view_model/market/get_market_payment_detail_by_company_id_view_model.dart';
import '../../../../widgets/dialog_design/quick_alert_utils.dart';

class MarketPaymentDetailsPage extends StatefulWidget {
  final int companyId;
  final String token;
  final GetMarketPaymentByCompanyIdModel marketPayment;

  const MarketPaymentDetailsPage({super.key, required this.marketPayment, required this.companyId, required this.token});

  @override
  MarketPaymentDetailsPageState createState() => MarketPaymentDetailsPageState();
}

class MarketPaymentDetailsPageState extends State<MarketPaymentDetailsPage> {
  final GetMarketPaymentDetailByCompanyIdViewModel getMarketPaymentDetailByCompanyIdViewModel = GetMarketPaymentDetailByCompanyIdViewModel();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      GetMarketPaymentDetailByCompanyIdRequestModel requestModel = GetMarketPaymentDetailByCompanyIdRequestModel(
          companyId: widget.companyId, marketPaymentId: widget.marketPayment.id);
      await getMarketPaymentDetailByCompanyIdViewModel.fetchMarketPaymentDetail(widget.token, requestModel);
      _handleApiResult();
    } catch (error) {
      _handleApiResult();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleApiResult() {
    if (!getMarketPaymentDetailByCompanyIdViewModel.result.success) {
      String errorMessage = getMarketPaymentDetailByCompanyIdViewModel.result.messages.isNotEmpty
          ? getMarketPaymentDetailByCompanyIdViewModel.result.messages.join(", ")
          : 'Veriler listelenirken bir hata oluştu. Lütfen tekrar deneyin.';
      QuickAlertUtils.showError(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Satış Detayları'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDetailRow(Icons.person, 'Sorumlu', widget.marketPayment.employeeFullName),
            Divider(),
            _buildDetailRow(Icons.payment, 'Ödeme Yöntemi', widget.marketPayment.paymentMethodName),
            Divider(),
            _buildDetailRow(Icons.monetization_on, 'Fiyat', '${widget.marketPayment.price.toStringAsFixed(2)} ₺'),
            Divider(),
            _buildDetailRow(Icons.percent, 'Fark', '${widget.marketPayment.discount.toStringAsFixed(2)} ₺'),
            Divider(),
            _buildDetailRow(Icons.attach_money, 'Tutar', '${widget.marketPayment.amount.toStringAsFixed(2)} ₺'),
            Divider(),
            _buildDetailRow(Icons.description, 'Açıklama', widget.marketPayment.description?.isEmpty ?? true ? 'Açıklama yok' : widget.marketPayment.description!),
            Divider(),
            _buildDetailRow(Icons.date_range, 'Tarih', DateFormat('dd.MM.yyyy').format(widget.marketPayment.created)),
            const SizedBox(height: 16),
            _buildExpensesTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          const SizedBox(width: 8),
          Text('$title: ', style: const TextStyle(fontSize: 16)),
          Expanded(
            child: Text(content, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildExpensesTable() {
    if (getMarketPaymentDetailByCompanyIdViewModel.result.data == null || getMarketPaymentDetailByCompanyIdViewModel.result.data!.isEmpty) {
      return Center(
        child: Text(
          getMarketPaymentDetailByCompanyIdViewModel.result.messages.isNotEmpty
              ? getMarketPaymentDetailByCompanyIdViewModel.result.messages.join(", ")
              : 'Kayıtlı veri bulunamadı.',
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Ürün Adı')),
          DataColumn(label: Text('Adet')),
          DataColumn(label: Text('Birim Fiyatı')),
        ],
        rows: getMarketPaymentDetailByCompanyIdViewModel.result.data!.map((paymentDetails) => _buildDataRow(paymentDetails)).toList(),
      ),
    );
  }

  DataRow _buildDataRow(dynamic paymentDetails) {
    return DataRow(
      cells: [
        DataCell(Row(
          children: [
            Icon(Icons.shopping_cart, color: Colors.blue),
            const SizedBox(width: 8),
            Text(paymentDetails.productName, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        )),
        DataCell(Text('${paymentDetails.piece.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text('${paymentDetails.unitPrice.toStringAsFixed(2)} ₺', style: const TextStyle(fontWeight: FontWeight.bold))),
      ],
    );
  }
}