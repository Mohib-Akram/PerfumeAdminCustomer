import 'package:flutter/material.dart';
import 'global_data.dart'; // For rowColors
import 'gender_type_selection_screen.dart'; // To navigate to the next level

class ProductTypeSelectionScreen extends StatelessWidget {
  final bool isAdmin; // To know whether to enable CRUD or just view

  ProductTypeSelectionScreen({required this.isAdmin});

  // Extract unique product types from perfumeData keys
  List<String> get productTypes {
    Set<String> types = {};
    for (String key in perfumeData.keys) {
      types.add(key.split('-')[0]); // "Perfume-Men" -> "Perfume"
    }
    return types.toList()..sort(); // Sort for consistent order
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${isAdmin ? 'Admin' : 'Customer'}: Select Product Type'),
      ),
      backgroundColor: Colors.black,
      body: productTypes.isEmpty
          ? Center(
              child: Text(
                'No product types available.',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : ListView.separated(
              itemCount: productTypes.length,
              separatorBuilder: (_, __) => SizedBox(height: 10),
              itemBuilder: (_, index) {
                String type = productTypes[index];
                return Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: rowColors[index % rowColors.length],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(
                      type,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                    onTap: () {
                      // Navigate to GenderTypeSelectionScreen, passing the selected type and isAdmin flag
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GenderTypeSelectionScreen(
                            productType: type,
                            isAdmin: isAdmin,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
