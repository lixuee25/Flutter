import 'package:final_app_flutter/components/app_bar.dart';
import 'package:final_app_flutter/page/home_page.dart';
import 'package:flutter/material.dart';
import '../model/shoes_model.dart';
import 'main_tab_page.dart';
import 'shoes_detail_page.dart';

class SearchResultPage extends StatelessWidget {
  final String searchTerm;

  const SearchResultPage({Key? key, required this.searchTerm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredShoes = shoes
        .where((shoe) =>
            shoe.name!.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: TdAppBar(
        title: 'Search',
        showAvatar: false,
        leftPressed: () {
          Route route = PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => MainTabPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return child;
            },
          );
          Navigator.push(context, route);
        },
      ),
      body: ListView.builder(
        itemCount: filteredShoes.length,
        itemBuilder: (context, index) {
          final shoe = filteredShoes[index];
          return ListTile(
            leading: Image.asset(
              shoe.imageStr!,
              width: 50,
              height: 50,
            ),
            title: Text(shoe.name ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Price: \$${shoe.price ?? 0.0}'),
                Text('Quantity: ${shoe.quantity ?? 0}'),
                Text('Size: ${shoe.size ?? 0}'),
                Text('Description: ${shoe.description ?? ''}'),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoesDetailPage(shoe: shoe),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
