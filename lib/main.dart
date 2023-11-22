import 'package:flutter/material.dart';

void main() => runApp(ExpenseTrackerApp());

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExpenseListScreen(),
    );
  }
}

class ExpenseListScreen extends StatefulWidget {
  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  List<String> expenses = []; // List to hold expenses

  void _addExpense(String expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              _navigateToAddExpenseScreen(context);
            },
            child: Text('Add Expense'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(expenses[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToAddExpenseScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddExpenseScreen()),
    );
    if (result != null) {
      _addExpense(result);
    }
  }
}

class AddExpenseScreen extends StatelessWidget {
  final TextEditingController _expenseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _expenseController,
              decoration: InputDecoration(
                labelText: 'Expense Name',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _submitExpense(context);
              },
              child: Text('Save Expense'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitExpense(BuildContext context) {
    if (_expenseController.text.isNotEmpty) {
      Navigator.pop(context, _expenseController.text);
    } else {
      // Show an error message or handle empty input
    }
  }
}
