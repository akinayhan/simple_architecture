import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'add_market_category_page.dart';
import 'add_market_product_page.dart';
import 'delete_market_category_page.dart';
import 'delete_market_product_page.dart';
import 'update_market_category_page.dart';
import 'update_market_product_page.dart';

class MarketManagementPage extends StatefulWidget {
  final int companyId;
  final String token;

  const MarketManagementPage({super.key, required this.companyId, required this.token});

  @override
  MarketManagementPageState createState() => MarketManagementPageState();
}

class MarketManagementPageState extends State<MarketManagementPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Market Yönetim"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildNavigationCard(
              context,
              "Kategori Ekle",
              Colors.blue,
              Ionicons.add_circle_outline,
              AddMarketCategoryPage(
                companyId: widget.companyId,
                token: widget.token,
              ),
            ),
            _buildNavigationCard(
              context,
              "Kategori Düzenle",
              Colors.green,
              Ionicons.create_outline,
              UpdateMarketCategoryPage(
                companyId: widget.companyId,
                token: widget.token,
              ),
            ),
            _buildNavigationCard(
              context,
              "Kategori Sil",
              Colors.red,
              Ionicons.trash_bin_outline,
              DeleteMarketCategoryPage(
                companyId: widget.companyId,
                token: widget.token,
              ),
            ),
            _buildNavigationCard(
              context,
              "Ürün Ekle",
              Colors.blue,
              Ionicons.add_circle_outline,
              AddMarketProductPage(
                companyId: widget.companyId,
                token: widget.token,
              ),
            ),
            _buildNavigationCard(
              context,
              "Ürün Düzenle",
              Colors.green,
              Ionicons.create_outline,
              UpdateMarketProductPage(
                companyId: widget.companyId,
                token: widget.token,
              ),
            ),
            _buildNavigationCard(
              context,
              "Ürün Sil",
              Colors.red,
              Ionicons.trash_outline,
              DeleteMarketProductPage(
                companyId: widget.companyId,
                token: widget.token,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard(BuildContext context, String title, Color color, IconData icon, Widget page) {
    return Card(
      color: color,
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }
}
