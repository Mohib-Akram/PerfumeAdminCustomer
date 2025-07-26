import 'package:flutter/material.dart';
import 'global_data.dart';

class CrudMenuScreen extends StatelessWidget {
  final String dataKey;

  CrudMenuScreen({required this.dataKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$dataKey Options')),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildButton(context, 'View', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ViewScreen(dataKey: dataKey)),
              );
            }),
            _buildButton(context, 'Add', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddScreen(dataKey: dataKey)),
              );
            }),
            _buildButton(context, 'Update', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UpdateScreen(dataKey: dataKey),
                ),
              );
            }),
            _buildButton(context, 'Delete', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DeleteScreen(dataKey: dataKey),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        padding: EdgeInsets.all(16),
      ),
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ViewScreen extends StatelessWidget {
  final String dataKey;

  ViewScreen({required this.dataKey});

  @override
  Widget build(BuildContext context) {
    var items = perfumeData[dataKey]!;

    return Scaffold(
      appBar: AppBar(title: Text('View - $dataKey')),
      backgroundColor: Colors.black,
      body: items.isEmpty
          ? Center(
              child: Text(
                'No perfumes found',
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => SizedBox(height: 10),
              itemBuilder: (_, index) {
                String key = items.keys.elementAt(index);
                return Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: rowColors[index % rowColors.length],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$key: ${items[key]}',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                );
              },
            ),
    );
  }
}

class AddScreen extends StatefulWidget {
  final String dataKey;

  AddScreen({required this.dataKey});

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final nameController = TextEditingController();
  final descController = TextEditingController();

  void addItem() {
    var map = perfumeData[widget.dataKey]!;
    setState(() {
      map[nameController.text] = descController.text;
      nameController.clear();
      descController.clear();
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Added Successfully')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add - ${widget.dataKey}')),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: addItem, child: Text('Add')),
          ],
        ),
      ),
    );
  }
}

class UpdateScreen extends StatefulWidget {
  final String dataKey;

  UpdateScreen({required this.dataKey});

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  void updateItem(String key, String newVal) {
    perfumeData[widget.dataKey]![key] = newVal;
    setState(() {});
  }

  void showDialogBox(String key, String val) {
    TextEditingController controller = TextEditingController(text: val);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Update $key'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () {
              updateItem(key, controller.text);
              Navigator.pop(context);
            },
            child: Text('Update'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var items = perfumeData[widget.dataKey]!;

    return Scaffold(
      appBar: AppBar(title: Text('Update - ${widget.dataKey}')),
      backgroundColor: Colors.black,
      body: items.isEmpty
          ? Center(
              child: Text('No items', style: TextStyle(color: Colors.white)),
            )
          : ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => SizedBox(height: 10),
              itemBuilder: (_, index) {
                String key = items.keys.elementAt(index);
                return Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: rowColors[index % rowColors.length],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '$key: ${items[key]}',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => showDialogBox(key, items[key]!),
                        child: Text('Edit'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class DeleteScreen extends StatefulWidget {
  final String dataKey;

  DeleteScreen({required this.dataKey});

  @override
  _DeleteScreenState createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  void deleteItem(String key) {
    perfumeData[widget.dataKey]!.remove(key);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var items = perfumeData[widget.dataKey]!;

    return Scaffold(
      appBar: AppBar(title: Text('Delete - ${widget.dataKey}')),
      backgroundColor: Colors.black,
      body: items.isEmpty
          ? Center(
              child: Text('No items', style: TextStyle(color: Colors.white)),
            )
          : ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => SizedBox(height: 10),
              itemBuilder: (_, index) {
                String key = items.keys.elementAt(index);
                return Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: rowColors[index % rowColors.length],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '$key: ${items[key]}',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => deleteItem(key),
                        child: Text('Delete'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
