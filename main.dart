import 'package:flutter/material.dart';

void main() {
  runApp(const CourseDashboardApp());
}

class CourseDashboardApp extends StatelessWidget {
  const CourseDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  String _selectedCategory = 'Science';
  final List<String> _categories = ['Science', 'Arts', 'Technology'];
  bool _isButtonAnimated = false;

  final List<Map<String, dynamic>> _courses = [
    {'name': 'Mobile App Development', 'instructor': 'Mr. Emmanuel Botchway', 'icon': Icons.phone_android},
    {'name': 'Financial Accounting', 'instructor': 'Dr. Asante', 'icon': Icons.account_balance},
    {'name': 'Web Engineering', 'instructor': 'Mr. Domfeh', 'icon': Icons.web},
    {'name': 'Project Management', 'instructor': 'Dr. K. Adu', 'icon': Icons.task},
    {'name': 'Information Security', 'instructor': 'Mr. Jacob Mensah', 'icon': Icons.security},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit Confirmation'),
          content: const Text('Are you sure you want to exit the app?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exiting app...')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;
    String tabName;

    switch (_selectedIndex) {
      case 0:
        tabName = 'Home';
        bodyContent = Center(
          child: Text(
            'Welcome to $tabName',
            style: const TextStyle(fontSize: 24),
          ),
        );
        break;
      case 1:
        tabName = 'Courses';
        bodyContent = ListView.builder(
          itemCount: _courses.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(_courses[index]['icon']),
              title: Text(_courses[index]['name']),
              subtitle: Text('Instructor: ${_courses[index]['instructor']}'),
            );
          },
        );
        break;
      case 2:
        tabName = 'Profile';
        bodyContent = SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // c. Exit Confirmation Dialog
              ElevatedButton(
                onPressed: _showExitDialog,
                child: const Text('Logout'),
              ),
              const SizedBox(height: 20),
              // d. Animated Action Button
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isButtonAnimated = !_isButtonAnimated;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _isButtonAnimated ? 200 : 150,
                  height: _isButtonAnimated ? 80 : 60,
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      'Enroll in a Course',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // e. Course Selection Dropdown
              DropdownButton<String>(
                value: _selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: _categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              Text('Selected Category: $_selectedCategory'),
            ],
          ),
        );
        break;
      default:
        tabName = '';
        bodyContent = const SizedBox.shrink();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(tabName),
      ),
      body: bodyContent,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}