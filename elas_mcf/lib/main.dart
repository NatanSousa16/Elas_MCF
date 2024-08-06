import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(ElasMCF());
}

class ElasMCF extends StatefulWidget {
  const ElasMCF({super.key});

  @override
  State<ElasMCF> createState() => _ElasMCFState();
}

class _ElasMCFState extends State<ElasMCF> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  Future<void> _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? _buildDarkTheme() : _buildLightTheme(),
      home: FutureBuilder<String?>(
        future: _loadUserName(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return HomePage(
              userName: snapshot.data!,
              isDarkMode: _isDarkMode,
              onToggleTheme: _toggleTheme,
            );
          } else {
            return LoginPage(
              isDarkMode: _isDarkMode,
              onToggleTheme: _toggleTheme,
            );
          }
        },
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[800]!.withOpacity(0.7),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: Colors.grey[500]),
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.purple,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple.withOpacity(0.3),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.purple.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  Future<String?> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emergencyContactController1 = TextEditingController();
  final TextEditingController _emergencyContactController2 = TextEditingController();
  final TextEditingController _emergencyContactController3 = TextEditingController();
  final TextEditingController _emergencyContactController4 = TextEditingController();
  final TextEditingController _emergencyContactController5 = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  LoginPage({
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.purple, Colors.black]
                : [Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Digite seu nome e informações de emergência',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      labelText: 'Nome',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _surnameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      labelText: 'Sobrenome',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      labelText: 'Telefone',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _emergencyContactController1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      labelText: 'Contato de Emergência 1',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _emergencyContactController2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      labelText: 'Contato de Emergência 2',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _emergencyContactController3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      labelText: 'Contato de Emergência 3',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _emergencyContactController4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      labelText: 'Contato de Emergência 4',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _emergencyContactController5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      labelText: 'Contato de Emergência 5',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      labelText: 'Endereço Residencial',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (_nameController.text.isNotEmpty &&
                          _surnameController.text.isNotEmpty) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString('userName',
                            _nameController.text + ' ' + _surnameController.text);
                        await prefs.setString('phoneNumber', _phoneController.text);
                        await prefs.setString('emergencyContact1',
                            _emergencyContactController1.text);
                        await prefs.setString('emergencyContact2',
                            _emergencyContactController2.text);
                        await prefs.setString('emergencyContact3',
                            _emergencyContactController3.text);
                        await prefs.setString('emergencyContact4',
                            _emergencyContactController4.text);
                        await prefs.setString('emergencyContact5',
                            _emergencyContactController5.text);
                        await prefs.setString('address', _addressController.text);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              userName: _nameController.text,
                              isDarkMode: isDarkMode,
                              onToggleTheme: onToggleTheme,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode
                          ? Colors.grey[800]!.withOpacity(0.7)
                          : Colors.white.withOpacity(0.3),
                      foregroundColor: Colors.black,
                      shadowColor: Colors.black,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Entrar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String userName;
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  HomePage({
    required this.userName,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _courses = [
    'Leis Publicas',
    'Numeros de Emergencia',
    'IDK',
    'IDK1',
    'IDK2',
    'IDK3',
  ];
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
          .where((course) =>
              course.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _editUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(
          isDarkMode: widget.isDarkMode,
          onToggleTheme: widget.onToggleTheme,
        ),
      ),
    );
  }

  void _sendSOS(bool isGeneral) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phoneNumber = prefs.getString('phoneNumber') ?? '';
    String emergencyContact1 = prefs.getString('emergencyContact1') ?? '';
    String emergencyContact2 = prefs.getString('emergencyContact2') ?? '';
    String emergencyContact3 = prefs.getString('emergencyContact3') ?? '';
    String emergencyContact4 = prefs.getString('emergencyContact4') ?? '';
    String emergencyContact5 = prefs.getString('emergencyContact5') ?? '';
    String address = prefs.getString('address') ?? '';

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    String location =
        'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';

    String message;
    if (isGeneral) {
      message = 'SOS! Preciso de ajuda! Localização: $location';
    } else {
      // Aqui você pode adicionar as informações coletadas das perguntas objetivas
      message = 'Emergência específica! Preciso de ajuda! Localização: $location';
    }

    List<String> contacts = [
      emergencyContact1,
      emergencyContact2,
      emergencyContact3,
      emergencyContact4,
      emergencyContact5,
    ];

    for (String contact in contacts) {
      if (contact.isNotEmpty) {
        String whatsappUrl = 'https://wa.me/$contact?text=${Uri.encodeFull(message)}';
        if (await canLaunch(whatsappUrl)) {
          await launch(whatsappUrl);
        } else {
          print('Could not launch $whatsappUrl');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, ${widget.userName}'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: widget.onToggleTheme,
          ),
        ],
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.isDarkMode
                ? [Colors.purple, Colors.black]
                : [Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Procure Aqui...',
                prefixIcon: Icon(Icons.search, color: Colors.white),
                hintStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: widget.isDarkMode
                    ? Colors.grey[800]!.withOpacity(0.7)
                    : Colors.white.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _filteredCourses
                    .map((course) => _buildCourseButton(context, course))
                    .toList(),
              ),
            ),
ElevatedButton(
  onPressed: () {
    _sendSOS(false); // Enviar mensagem de emergência específica
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.red,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  child: Text('Enviar Emergência Específica'),
),

ElevatedButton(
  onPressed: () {
    _sendSOS(true); // Enviar mensagem de SOS geral
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.red,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  child: Text('SOS'),
),

ElevatedButton(
  onPressed: _editUserInfo,
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  child: Text('Editar Informações'),
),

          ],
        ),
      ),
    );
  }

  Widget _buildCourseButton(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.isDarkMode
              ? Colors.grey[800]!.withOpacity(0.7)
              : Colors.white.withOpacity(0.3),
          foregroundColor: widget.isDarkMode ? Colors.white : Colors.black,
          shadowColor: Colors.black,
          elevation: 10,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(title, style: TextStyle(fontSize: 18)),
        ),
      ),
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
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Conteúdo do curso: $title',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}