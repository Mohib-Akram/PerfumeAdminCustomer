import 'package:flutter/material.dart';
import 'global_data.dart';
import 'common_crud_screen.dart'; // Contains CrudMenuScreen, ViewScreen, AddScreen, UpdateScreen, DeleteScreen

// New imports for the redesigned navigation
import 'product_type_selection_screen.dart'; // We will create this
import 'gender_type_selection_screen.dart'; // We will create this

void main() {
  runApp(PerfumeApp());
}

class PerfumeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfume App',
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF708090),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            elevation: 10,
            shadowColor: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => UserSelectionScreen()),
            );
          },
          child: Text(
            "𝒲𝑒𝓁𝒸o𝓂𝑒 𝓉o 𝓉𝒽𝑒 𝒫𝑒𝓇𝒫𝓊𝓂𝑒 𝒮𝓉o𝓇𝑒 ｡🌠",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 4.0,
                  color: Color(0xFF708090),
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select User Type')),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSelectionButton(context, 'Admin', () {
              // Admin goes to ProductTypeSelectionScreen with isAdmin: true
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductTypeSelectionScreen(isAdmin: true),
                ),
              );
            }),
            SizedBox(height: 30),
            _buildSelectionButton(context, 'Customer', () {
              // Customer goes to ProductTypeSelectionScreen with isAdmin: false
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductTypeSelectionScreen(isAdmin: false),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionButton(
    BuildContext context,
    String label,
    VoidCallback onTap,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onTap,
      child: Text(label),
    );
  }
}
