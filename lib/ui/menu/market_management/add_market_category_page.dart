import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/market/create_market_category_model.dart';
import '../../../utils/design/button_design/create_material_button.dart';
import '../../../utils/design/form_fields/generic_field.dart';
import '../../../../utils/design/dialog_design/quick_alert_utils.dart';
import '../../../utils/result/api_result.dart';
import '../../../view_model/market/create_market_category_view_model.dart';

class AddMarketCategoryPage extends StatefulWidget {
  final int companyId;
  final String token;
  const AddMarketCategoryPage({super.key, required this.companyId, required this.token});

  @override
  AddMarketCategoryPageState createState() => AddMarketCategoryPageState();
}

class AddMarketCategoryPageState extends State<AddMarketCategoryPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final createMarketCategoryViewModel = Provider.of<CreateMarketCategoryViewModel>(context);
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kategori Ekle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GenericTextField(controller: _categoryNameController, label: 'Kategori İsmi'),
                    SizedBox(height: screenHeight * 0.02),
                    CreateMaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _onPressedCreateMarketCategory(createMarketCategoryViewModel);
                        }
                      },
                      label: 'Kategori Ekle',
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

  void _onPressedCreateMarketCategory(CreateMarketCategoryViewModel createMarketCategoryViewModel) async {
    if (_formKey.currentState!.validate()) {
      CreateMarketCategoryModel newCategory = CreateMarketCategoryModel(
        companyId: widget.companyId,
        categoryName: _categoryNameController.text,
      );

      ApiResult result = await createMarketCategoryViewModel.createMarketCategory(newCategory, widget.token);
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
}
