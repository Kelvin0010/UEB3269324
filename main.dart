import 'package:flutter/material.dart';

void main() {
  runApp(const StudentInfoManagerApp());
}

class StudentInfoManagerApp extends StatelessWidget {
  const StudentInfoManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Information Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _studentCount = 0;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final String _name = 'Afriyie Kelvin Kwarteng';
  final String _course = 'Mobile Application Development';
  final String _university = 'University of Energy and Natural Resources';
  final String _profileImageUrl = 'https://st2.depositphotos.com/2101611/6967/v/450/depositphotos_69671201-stock-illustration-male-portrait-icon.jpg';

  void _showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Hello, $_name! Welcome to the Student Info Manager.')),
    );
  }

  void _incrementCounter() {
    setState(() {
      _studentCount++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_studentCount > 0) _studentCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Information Manager'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // a. Welcome Dashboard
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      _name,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      _course,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      _university,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            // b. Interactive Notification
            ElevatedButton(
              onPressed: _showSnackbar,
              child: const Text('Show Alert'),
            ),
            const SizedBox(height: 20),
            // c. Student Counter
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: _decrementCounter,
                ),
                Text(
                  'Students Enrolled: $_studentCount',
                  style: const TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _incrementCounter,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // d. Student Login Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email with @';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Form is valid, proceed
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login successful!')),
                        );
                      }
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // e. Profile Picture Display
            Center(
              child: Image.network(
                _profileImageUrl,
                width: MediaQuery.of(context).size.width * 0.5, // Responsive width
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}