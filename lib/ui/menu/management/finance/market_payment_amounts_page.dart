import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import '../../../../utils/function/save_excel/conditional_imports.dart';
import '../../../../models/market/get_market_payment_request_model.dart';
import '../../../../utils/design/button_design/custom_material_button.dart';
import '../../../../utils/design/dialog_design/quick_alert_utils.dart';
import '../../../../utils/function/select_date.dart';
import '../../../../view_model/market/get_market_payment_by_company_id_view_model.dart';
import 'market_payment_details_page.dart';

class MarketPaymentAmountsPage extends StatefulWidget {
  final int companyId;
  final String token;

  const MarketPaymentAmountsPage({super.key, required this.companyId, required this.token});

  @override
  MarketPaymentAmountsPageState createState() => MarketPaymentAmountsPageState();
}

class MarketPaymentAmountsPageState extends State<MarketPaymentAmountsPage> {
  final GetMarketPaymentByCompanyIdViewModel getMarketPaymentByCompanyIdViewModel = GetMarketPaymentByCompanyIdViewModel();
  bool _isLoading = false;
  String? _startDate;
  String? _endDate;
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  Future<void> _loadData() async {
    if (_startDate == null || _endDate == null) {
      QuickAlertUtils.showError(context, 'Lütfen hem başlangıç hem de bitiş tarihlerini seçin.');
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      GetMarketPaymentRequestModel requestModel = GetMarketPaymentRequestModel(companyId: widget.companyId, startDate:  _startDate ?? '', endDate: _endDate ?? '',);
      await getMarketPaymentByCompanyIdViewModel.fetchMarketPaymentByCompanyId(widget.token, requestModel);
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
    if (!getMarketPaymentByCompanyIdViewModel.result.success) {
      String errorMessage = getMarketPaymentByCompanyIdViewModel.result.messages.isNotEmpty
          ? getMarketPaymentByCompanyIdViewModel.result.messages.join(", ")
          : 'Veriler listelenirken bir hata oluştu. Lütfen tekrar deneyin.';
      QuickAlertUtils.showError(context, errorMessage);
    }
  }

  double _getTotalPrice() {
    return getMarketPaymentByCompanyIdViewModel.result.data!
        .fold(0, (sum, item) => sum + item.price);
  }

  double _getTotalDiscount() {
    return getMarketPaymentByCompanyIdViewModel.result.data!
        .fold(0, (sum, item) => sum + item.discount);
  }

  double _getTotalAmount() {
    return getMarketPaymentByCompanyIdViewModel.result.data!
        .fold(0, (sum, item) => sum + item.amount);
  }

  Future<void> _generateAndSaveExcel() async {
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];

    final headers = [
      'Sorumlu',
      'Ödeme Yöntemi',
      'Fiyat',
      'Fark',
      'Tutar',
      'Açıklama',
      'Tarih',
    ];
    sheet.appendRow(headers.map((header) => TextCellValue(header)).toList());

    final resultData = getMarketPaymentByCompanyIdViewModel.result.data;
    if (resultData != null) {
      for (var payment in resultData) {
        final row = [
          TextCellValue(payment.employeeFullName),
          TextCellValue(payment.paymentMethodName),
          DoubleCellValue(payment.price),
          DoubleCellValue(payment.discount),
          DoubleCellValue(payment.amount),
          TextCellValue(payment.description ?? ''),
          TextCellValue(DateFormat('dd.MM.yyyy').format(payment.created)),
        ];
        sheet.appendRow(row);
      }
    }

    final summaryRow = [
      TextCellValue(''),
      TextCellValue('Toplam:'),
      DoubleCellValue(_getTotalPrice()),
      DoubleCellValue(_getTotalDiscount()),
      DoubleCellValue(_getTotalAmount()),
      TextCellValue(''),
      TextCellValue(''),
    ];
    sheet.appendRow(summaryRow);

    final fileBytes = excel.encode();
    if (fileBytes != null) {
      final uint8list = Uint8List.fromList(fileBytes);
      await saveAndShareExcel(uint8list, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Satış Gelirleri'),
        actions: [
          IconButton(
            icon: const Icon(Icons.local_print_shop_outlined),
            onPressed: _generateAndSaveExcel,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Form(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                onTap: () => selectDate(
                                  context: context,
                                  controller: startDateController,
                                  isStartDate: true,
                                  startDate: null,
                                  endDate: _endDate,
                                  onDateSelected: (selectedDate) {
                                    setState(() {
                                      _startDate = selectedDate;
                                    });
                                  },
                                ),
                                controller: startDateController,
                                decoration: const InputDecoration(
                                  labelText: 'Başlangıç',
                                ),
                                readOnly: true,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                onTap: () => selectDate(
                                  context: context,
                                  controller: endDateController,
                                  isStartDate: false,
                                  startDate: _startDate,
                                  endDate: null,
                                  onDateSelected: (selectedDate) {
                                    setState(() {
                                      _endDate = selectedDate;
                                    });
                                  },
                                ),
                                controller: endDateController,
                                decoration: const InputDecoration(
                                  labelText: 'Bitiş',
                                ),
                                readOnly: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomMaterialButton(
                      onPressed: _loadData,
                      label: 'Verileri Getir',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildExpensesTable(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpensesTable() {
    if (getMarketPaymentByCompanyIdViewModel.result.data == null ||
        getMarketPaymentByCompanyIdViewModel.result.data!.isEmpty) {
      return Center(
        child: Text(
          getMarketPaymentByCompanyIdViewModel.result.messages.isNotEmpty
              ? getMarketPaymentByCompanyIdViewModel.result.messages.join(", ")
              : 'Kayıtlı veri bulunamadı.',
        ),
      );
    }

    final List<DataRow> rows = getMarketPaymentByCompanyIdViewModel.result.data!.map((payment) {
      return DataRow(
        cells: [
          DataCell(
            Tooltip(
              message: payment.employeeFullName,
              child: Text(
                payment.employeeFullName.length > 20
                    ? '${payment.employeeFullName.substring(0, 20)}...'
                    : payment.employeeFullName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          DataCell(Text(payment.paymentMethodName)),
          DataCell(Text('${payment.price.toStringAsFixed(2)} ₺')),
          DataCell(Text('${payment.discount.toStringAsFixed(2)} ₺')),
          DataCell(Text('${payment.amount.toStringAsFixed(2)} ₺')),
          DataCell(
            Tooltip(
              message: payment.description!,
              child: Text(
                payment.description!.length > 20
                    ? '${payment.description!.substring(0, 20)}...'
                    : payment.description!,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          DataCell(Text(DateFormat('dd.MM.yyyy').format(payment.created))),
          DataCell(
            TextButton(
              onPressed: () => _navigateToDetailsPage(payment),
              child: const Text('Detaylar'),
            ),
          ),
        ],
      );
    }).toList();

    rows.add(
      DataRow(
        cells: [
          const DataCell(Text('')),
          const DataCell(Text('Toplam:', style: TextStyle(fontWeight: FontWeight.bold))),
          DataCell(Text('${_getTotalPrice().toStringAsFixed(2)} ₺', style: const TextStyle(fontWeight: FontWeight.bold))),
          DataCell(Text('${_getTotalDiscount().toStringAsFixed(2)} ₺', style: const TextStyle(fontWeight: FontWeight.bold))),
          DataCell(Text('${_getTotalAmount().toStringAsFixed(2)} ₺', style: const TextStyle(fontWeight: FontWeight.bold))),
          const DataCell(Text('')),
          const DataCell(Text('')),
          const DataCell(Text('')),
        ],
      ),
    );

    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 1200,
      columns: const [
        DataColumn(label: Text('Sorumlu')),
        DataColumn(label: Text('Ödeme Yöntemi')),
        DataColumn(label: Text('Fiyat')),
        DataColumn(label: Text('Fark')),
        DataColumn(label: Text('Tutar')),
        DataColumn(label: Text('Açıklama')),
        DataColumn(label: Text('Tarih')),
        DataColumn(label: Text('Detaylar')),
      ],
      rows: rows,
    );
  }

  void _navigateToDetailsPage(dynamic payment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MarketPaymentDetailsPage(
          marketPayment: payment,
          companyId: widget.companyId,
          token: widget.token,
        ),
      ),
    );
  }
}