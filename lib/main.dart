import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com a imagem
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fundo.png'), // Caminho para a imagem de fundo
                fit: BoxFit.cover, // Ajusta a imagem para cobrir todo o espaço
              ),
            ),
          ),
          // Conteúdo da página
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bem vinda, Joice',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 50),
                MenuButton(
                  iconPath: 'assets/estrela.png', // Substitua com seu caminho de imagem
                  label: 'LEIS PÚBLICAS',
                  onPressed: () {
                    print('LEIS PÚBLICAS clicado');
                    // Adicione a navegação ou ação desejada aqui
                  },
                ),
                MenuButton(
                  iconPath: 'assets/estrela.png', // Substitua com seu caminho de imagem
                  label: 'INSTITUIÇÕES DE APOIO',
                  onPressed: () {
                    print('INSTITUIÇÕES DE APOIO clicado');
                    // Adicione a navegação ou ação desejada aqui
                  },
                ),
                MenuButton(
                  iconPath: 'assets/estrela.png', // Substitua com seu caminho de imagem
                  label: 'NÚMEROS DE EMERGÊNCIA',
                  onPressed: () {
                    print('NÚMEROS DE EMERGÊNCIA clicado');
                    // Adicione a navegação ou ação desejada aqui
                  },
                ),
                MenuButton(
                  iconPath: 'assets/estrela.png', // Substitua com seu caminho de imagem
                  label: 'FUNÇÃO',
                  onPressed: () {
                    print('FUNÇÃO clicado');
                    // Adicione a navegação ou ação desejada aqui
                  },
                ),
                MenuButton(
                  iconPath: 'assets/estrela.png', // Substitua com seu caminho de imagem
                  label: 'FUNÇÃO',
                  onPressed: () {
                    print('FUNÇÃO clicado');
                    // Adicione a navegação ou ação desejada aqui
                  },
                ),
                
                Spacer(),
                MenuButton(
                  iconPath: 'assets/adicao.png', // Substitua com seu caminho de imagem
                  label: 'SOS',
                  backgroundColor: Color(0xFFFFD600),
                  textColor: Colors.blue,
                  onPressed: () {
                    print('SOS clicado');
                    // Adicione a navegação ou ação desejada aqui
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed; // Função a ser chamada quando o botão for clicado

  MenuButton({
    required this.iconPath,
    required this.label,
    required this.onPressed, // Função obrigatória para o clique
    this.backgroundColor = Colors.white,
    this.textColor = Colors.deepPurple,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: onPressed, // Ação ao clicar no botão
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
              Image.asset(iconPath, width: 24, height: 24), // Ícone
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
