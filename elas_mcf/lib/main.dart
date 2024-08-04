import 'package:flutter/material.dart';

void main() {
  runApp(elasmcf());
}

class elasmcf extends StatefulWidget {
  const elasmcf({super.key});

  @override
  State<elasmcf> createState() => _elasmcfState();
}

class _elasmcfState extends State<elasmcf> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _courses = ['Leis Publicas', 'Numeros de Emergencia', 'IDK', 'IDK1', 'IDK2', 'IDK3'];
  late List<String> _filteredCourses;

  @override
  void initState() {
    super.initState();
    _filteredCourses = _courses;
    _searchController.addListener(_filterCourses);
  }

  void _filterCourses() {
    setState(() {
      _filteredCourses = _courses
          .where((course) => course.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Elas MCF'),
          backgroundColor: Colors.purple,
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hi, Programmer',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search here...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: _filteredCourses.map((course) => _buildCourseButton(context, course)).toList(),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.playlist_play), label: 'Courses'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Wishlist'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseButton(BuildContext context, String title) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CoursePage(title: title),
          ),
        );
      },
      child: Text(title, style: TextStyle(fontSize: 18)),
    );
  }
}

class CoursePage extends StatelessWidget {
  final String title;

  CoursePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text(
          'Welcome to $title course!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
