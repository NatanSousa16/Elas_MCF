import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // Definir o modo de interface do usuário para tela cheia
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // Modo tela cheia imersivo

  runApp(MyApp());
}

const appTitle = 'Bem vinda, Joice';
const leisPublicas = 'LEIS PÚBLICAS';
const instituicoesApoio = 'INSTITUIÇÕES DE APOIO';
const numerosEmergencia = 'NÚMEROS DE EMERGÊNCIA';
const funcao = 'FUNÇÃO';
const sos = 'SOS';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// Widget reutilizável para o fundo com imagem
class Background extends StatelessWidget {
  final Widget child;

  Background({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fundo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                appTitle,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 50),
              MenuButton(
                iconPath: 'assets/estrela.png',
                label: leisPublicas,
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LeisPublicasPage())),
              ),
              MenuButton(
                iconPath: 'assets/estrela.png',
                label: instituicoesApoio,
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => InstituicoesApoioPage())),
              ),
              MenuButton(
                iconPath: 'assets/estrela.png',
                label: numerosEmergencia,
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NumerosEmergenciaPage())),
              ),
              MenuButton(
                iconPath: 'assets/estrela.png',
                label: funcao,
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FuncaoPage())),
              ),
              Spacer(),
              MenuButton(
                iconPath: 'assets/adicao.png',
                label: sos,
                backgroundColor: Color(0xFFFFD600),
                textColor: Colors.blue,
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SOSPage())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  MenuButton({
    required this.iconPath,
    required this.label,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.deepPurple,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16),
              Image.asset(iconPath, width: 24, height: 24),
              SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Definições das páginas com fundo reutilizado
class LeisPublicasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: Text(
            'Conteúdo da página de $leisPublicas',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class InstituicoesApoioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: Text(
            'Conteúdo da página de $instituicoesApoio',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class NumerosEmergenciaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: Text(
            'Conteúdo da página de $numerosEmergencia',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class FuncaoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: Text(
            'Conteúdo da página de $funcao',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class SOSPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: Text(
            'Conteúdo da página de $sos',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
