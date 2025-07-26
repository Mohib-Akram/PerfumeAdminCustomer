import 'package:flutter/material.dart';
import 'global_data.dart'; // For rowColors
import 'common_crud_screen.dart'; // For CrudMenuScreen and ViewScreen

class GenderTypeSelectionScreen extends StatelessWidget {
  final String productType; // e.g., "Perfume", "Itar", "Spray"
  final bool isAdmin; // To determine navigation (CRUD or View)

  GenderTypeSelectionScreen({required this.productType, required this.isAdmin});

  // The fixed list of gender types, as per your data structure
  final List<String> genderTypes = ['Men', 'Women', 'Unisex'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${isAdmin ? 'Admin' : 'Customer'}: Select Type for $productType',
        ),
      ),
      backgroundColor: Colors.black,
      body: ListView.separated(
        itemCount: genderTypes.length,
        separatorBuilder: (_, __) => SizedBox(height: 10),
        itemBuilder: (_, index) {
          String gender = genderTypes[index];
          // Construct the full dataKey
          String fullDataKey = '$productType-$gender';

          return Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: rowColors[index % rowColors.length],
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              title: Text(
                gender,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                if (isAdmin) {
                  // Admin path: Navigate to CrudMenuScreen for the fullDataKey
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CrudMenuScreen(dataKey: fullDataKey),
                    ),
                  );
                } else {
                  // Customer path: Navigate to ViewScreen for the fullDataKey
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ViewScreen(dataKey: fullDataKey),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
