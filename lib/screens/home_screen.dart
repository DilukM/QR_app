import 'package:admin/screens/qr_scanner_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomeTab(),
    const HistoryTab(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Attendance App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Add settings functionality here
            },
          ),
        ],
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Mark Student Attendance',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Icon(
              Icons.qr_code,
              size: 200.0,
              color: Color.fromARGB(
                  255, 52, 97, 165), // Set the color of the QR code icon
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QRScannerScreen(),
                  ),
                );
              },
              child: const Text(
                'Scan Student QR',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Upcoming Events',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const ListTile(
            leading: Icon(Icons.event),
            title: Text('PD Lecture'),
            subtitle: Text('10:00 AM - 12:00 PM'),
          ),
          // Add more events as needed
          const Spacer(), // Added spacer to push Attendance Summary to the bottom
          const Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  'Attendance Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SummaryCard(title: 'Total Students', value: '100'),
                    SummaryCard(title: 'Present', value: '90'),
                    SummaryCard(title: 'Absent', value: '10'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'History',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;

  const SummaryCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
