import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/market/cart_item.dart';
import '../../../../models/market/create_market_payment_model.dart';
import '../../../../models/market/get_market_category_request_model.dart';
import '../../../../models/market/get_market_product_request_model.dart';
import '../../../../models/other/get_payment_methods_request_model.dart';
import '../../../../models/result/api_result.dart';
import '../../../../view_model/market/create_market_payment_view_model.dart';
import '../../../../view_model/market/get_market_category_view_model.dart';
import '../../../../view_model/market/get_market_product_view_model.dart';
import '../../../../view_model/other/list_payment_methods_view_model.dart';
import '../../../widgets/build_dropdown/build_market_category_dropdown_items.dart';
import '../../../widgets/build_dropdown/build_market_product_dropdown_items.dart';
import '../../../widgets/build_dropdown/build_payment_method_dropdown_items.dart';
import '../../../widgets/button_design/create_material_button.dart';
import '../../../widgets/dialog_design/quick_alert_utils.dart';
import '../../../widgets/form_fields/nullable_text_field.dart';
import '../../../widgets/form_fields/number_field.dart';
import '../../../widgets/form_fields/number_read_field.dart';


class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  MarketPageState createState() => MarketPageState();
}

class MarketPageState extends State<MarketPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late GetMarketCategoriesViewModel getMarketCategoriesViewModel;
  late GetMarketProductsViewModel getMarketProductsViewModel;
  late ListPaymentMethodsViewModel listPaymentMethodsViewModel;
  bool _categoriesLoaded = false;
  bool _productsLoaded = false;
  bool _paymentMethodLoaded = false;
  final bool _status = true;
  String? _token;
  int? _companyId;
  String? _userId;
  int? _selectedMarketCategoryId;
  int? _selectedMarketProductId;
  int? _selectedPaymentMethodId;
  String? _selectedMarketProductName;
  double? _selectedMarketProductPrice;
  final List<CartItem> _cartItems = [];

  final TextEditingController _pieceController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _getTokenFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('TOKEN') ?? '';
    _companyId = prefs.getInt('COMPANY_ID') ?? 0;
    _userId = prefs.getString('USER_ID') ?? '';

    _getMarketCategories();
    _getPaymentMethods();
  }

  @override
  void initState() {
    super.initState();
    _getTokenFromSharedPreferences();
    _discountController.text = '0';
    _priceController.text = '0';
    _amountController.text = '0';
    _pieceController.text = "0";
    _discountController.addListener(_onDiscountChanged);
  }

  Future<void> _getMarketCategories() async {
    getMarketCategoriesViewModel = Provider.of<GetMarketCategoriesViewModel>(context, listen: false);
    GetMarketCategoryRequestModel requestModel = GetMarketCategoryRequestModel(companyId: _companyId!, status: true, deleted: false,);
    await getMarketCategoriesViewModel.fetchMarketCategory(_token!, requestModel);
    setState(() {
      _categoriesLoaded = true;
    });
  }

  Future<void> _getPaymentMethods() async {
    listPaymentMethodsViewModel = Provider.of<ListPaymentMethodsViewModel>(context, listen: false);
    GetPaymentMethodsRequestModel requestModel = GetPaymentMethodsRequestModel(status: _status);
    await listPaymentMethodsViewModel.fetchPaymentMethods(requestModel);
    setState(() {
      _paymentMethodLoaded = true;
    });
  }

  Future<void> _getMarketProducts(int categoryId) async {
    setState(() {
      _productsLoaded = false;
    });
    getMarketProductsViewModel = Provider.of<GetMarketProductsViewModel>(context, listen: false);
    GetMarketProductRequestModel requestModel = GetMarketProductRequestModel(companyId: _companyId!,marketCategoryId: categoryId, status: true, deleted: false,);
    await getMarketProductsViewModel.fetchMarketProduct(_token!, requestModel);
    setState(() {
      _productsLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final createMarketPaymentViewModel = Provider.of<CreateMarketPaymentViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Market")),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildAddToCartSection(createMarketPaymentViewModel),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              if(_cartItems.isNotEmpty)
              _buildCartSection(context, createMarketPaymentViewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddToCartSection(CreateMarketPaymentViewModel createMarketPaymentViewModel) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Colors.green,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            children: [
              const Card(
                color: Colors.green,
                elevation: 5,
                child: ListTile(
                  title: Text("Sepete Ekle", style: TextStyle(color: Colors.white)),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    _buildCategoryDropdownButtonFormField(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    _buildProductDropdownButtonFormField(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    NumberField(controller: _pieceController, label: 'Adet'),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    CreateMaterialButton(
                      label: 'Sepete Ekle',
                      onPressed: _addToCart,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartSection(BuildContext context, CreateMarketPaymentViewModel createMarketPaymentViewModel) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Colors.orange,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            children: [
              const Card(
                color: Colors.orange,
                elevation: 5,
                child: ListTile(
                  title: Text("Sepet", style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _cartItems.length,
                itemBuilder: (context, index) {
                  CartItem item = _cartItems[index];
                  double unitPrice = item.price / item.quantity;
                  return ListTile(
                    title: Text(item.productName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${item.quantity} x ${unitPrice.toStringAsFixed(2)}'),
                        const Divider()
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _removeFromCart(item.productId);
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: NumberReadField(
                      controller: _priceController,
                      label: 'Tutar',
                      readOnly: true,
                    ),
                  ),
                  Expanded(
                    child: NumberReadField(
                      controller: _discountController,
                      label: 'Fark',
                      readOnly: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              NumberReadField(
                controller: _amountController,
                label: 'Toplam',
                readOnly: true,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildPaymentMethodDropdownButtonFormField(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              NullableTextField(controller: _descriptionController, label: 'Açıklama'),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CreateMaterialButton(
                label: 'Ödeme Yap',
                onPressed: () {
                  _onPressedCreateVehicle(createMarketPaymentViewModel);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodDropdownButtonFormField() {
    return DropdownButtonFormField<int>(
      value: _selectedPaymentMethodId,
      items: _paymentMethodLoaded ? buildPaymentMethodDropdownItems(listPaymentMethodsViewModel.paymentMethods) : null,
      onChanged: (value) {
        setState(() {
          _selectedPaymentMethodId = value;
        });
      },
      decoration: const InputDecoration(labelText: 'Ödeme Yöntemi Seçin'),
      validator: (value) {
        if (value == null) {
          return 'Lütfen bir Ödeme Yöntemi seçin!';
        }
        return null;
      },
    );
  }

  Widget _buildCategoryDropdownButtonFormField() {
    return DropdownButtonFormField<int>(
      value: _selectedMarketCategoryId,
      items: _categoriesLoaded ? buildMarketCategoryDropdownItems(getMarketCategoriesViewModel.items) : null,
      onChanged: (value) {
        setState(() {
          _selectedMarketCategoryId = value;
          _selectedMarketProductId = null;
          if (value != null) {
            _getMarketProducts(value);
          }
        });
      },
      decoration: const InputDecoration(labelText: 'Kategori Seçin'),
      validator: (value) {
        if (value == null) {
          return 'Lütfen bir Kategori seçin!';
        }
        return null;
      },
    );
  }

  Widget _buildProductDropdownButtonFormField() {
    return DropdownButtonFormField<int>(
      value: _selectedMarketProductId,
      items: _productsLoaded ? buildMarketProductDropdownItems(getMarketProductsViewModel.items) : null,
      onChanged: (value) {
        setState(() {
          _selectedMarketProductId = value;
          var selectedProduct = getMarketProductsViewModel.items.firstWhere((product) => product.id == value);
          _selectedMarketProductName = selectedProduct.productName;
          _selectedMarketProductPrice = selectedProduct.productPrice;
        });
      },
      decoration: const InputDecoration(labelText: 'Ürün Seçin'),
      validator: (value) {
        if (value == null) {
          return 'Lütfen bir Ürün seçin!';
        }
        return null;
      },
    );
  }

  void _onPressedCreateVehicle(CreateMarketPaymentViewModel createMarketPaymentViewModel) async {
    if (_selectedPaymentMethodId == null) {
      QuickAlertUtils.showError(context, 'Lütfen bir ödeme yöntemi seçin!');
      return;
    }

    if (_discountController.text.isEmpty) {
      _discountController.text = '0';
    }

    if (_formKey.currentState!.validate()) {
      List<PaymentDetail> paymentDetails = _cartItems.map((item) {
        return PaymentDetail(
          productId: item.productId,
          piece: item.quantity,
        );
      }).toList();

      CreateMarketPaymentModel newPayment = CreateMarketPaymentModel(
        companyId: _companyId!,
        employeeId: _userId!,
        paymentMethodId: _selectedPaymentMethodId!,
        price: double.parse(_priceController.text),
        discount: double.parse(_discountController.text),
        amount: double.parse(_amountController.text),
        description: _descriptionController.text,
        paymentDetails: paymentDetails,
      );

      ApiResult result = await createMarketPaymentViewModel.createMarketPayment(newPayment, _token!);
      _handleApiResult(result);
    }
  }

  void _handleApiResult(ApiResult result) {
    if (result.success) {
      Navigator.pop(context, true);
      QuickAlertUtils.showSuccess(context, result.messages.join('\n'));
    } else {
      if(result.messages.isEmpty){
        QuickAlertUtils.showError(context, 'Oturum Sonlanmıştır. Tekrar giriş yapın.');
      }else{
        QuickAlertUtils.showError(context, result.messages.join('\n'));
      }
    }
  }

  void _addToCart() {
    if (_selectedMarketProductId != null && _pieceController.text.isNotEmpty) {
      int quantity = int.parse(_pieceController.text);
      if (quantity <= 0) {
        QuickAlertUtils.showError(context, 'Adet sayısı 0 veya boş olamaz!');
        return;
      }

      double price = _selectedMarketProductPrice ?? 0;

      CartItem newItem = CartItem(
        productId: _selectedMarketProductId!,
        productName: _selectedMarketProductName!,
        quantity: quantity,
        price: price * quantity,
      );

      setState(() {
        _cartItems.add(newItem);
        _updateCartSummary();
      });
    } else {
      QuickAlertUtils.showError(context, 'Lütfen ürün seçin ve adet sayısını girin!');
    }
  }

  void _removeFromCart(int productId) {
    setState(() {
      _cartItems.removeWhere((item) => item.productId == productId);
      _updateCartSummary();
    });
  }

  void _updateCartSummary() {
    double totalPrice = _cartItems.fold(0, (sum, item) => sum + item.price);
    _priceController.text = totalPrice.toStringAsFixed(2);
    double discount = double.parse(_discountController.text);
    double totalAmount = totalPrice - discount;
    _amountController.text = totalAmount.toStringAsFixed(2);
  }

  void _onDiscountChanged() {
    setState(() {
      _updateCartSummary();
    });
  }

}