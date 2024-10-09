import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  // Definir o modo de interface do usuário para tela cheia
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // Modo tela cheia imersivo

  runApp(MyApp());
}

const appTitle = 'Bem vinda, ';
const leisPublicas = 'LEIS PÚBLICAS';
const instituicoesApoio = 'INSTITUIÇÕES DE APOIO';
const numerosEmergencia = 'NÚMEROS EMERGENCIAIS';

const sos = 'SOS';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController(); // Novo campo para WhatsApp

  @override
  void dispose() {
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _cpfController.dispose();
    _whatsappController.dispose(); // Libera o controlador de WhatsApp
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField('Nome', _nomeController),
                SizedBox(height: 10),
                _buildTextField('Sobrenome', _sobrenomeController),
                SizedBox(height: 10),
                _buildTextField('CPF', _cpfController, keyboardType: TextInputType.number),
                SizedBox(height: 10),
                _buildTextField('Número de Contato para Emergência\nExemplo:(5588911111111)', _whatsappController, keyboardType: TextInputType.phone), // Campo WhatsApp
                SizedBox(height: 20),
                _buildLoginButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return Container(
      width: double.infinity,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.black54,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFFD600),
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                nome: _nomeController.text,
                sobrenome: _sobrenomeController.text,
                cpf: _cpfController.text,
                whatsapp: _whatsappController.text, // Passando o número de WhatsApp
              ),
            ),
          );
        },
        child: Text('Entrar'),
      ),
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
  final String nome;
  final String sobrenome;
  final String cpf;
  final String whatsapp; // Recebendo o número de WhatsApp

  HomePage({
    required this.nome,
    required this.sobrenome,
    required this.cpf,
    required this.whatsapp, // Passando o número de WhatsApp
  });

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
                'Bem vinda, $nome', // Exibe o nome aqui
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 50),
              MenuButton(
                iconPath: 'assets/leis_publicas.png',
                label: 'Leis Públicas',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LeisPublicasPage())),
              ),
              MenuButton(
                iconPath: 'assets/instituicoes_apoio.png',
                label: 'Instituições de Apoio',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => InstituicoesApoioPage())),
              ),
              MenuButton(
                iconPath: 'assets/numeros_emergencia.png',
                label: 'Números de Emergência',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NumerosEmergenciaPage())),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 200,
                  child: MenuButton(
                    iconPath: 'assets/sos.png',
                    label: 'SOS',
                    backgroundColor: Color(0xFFFFD600),
                    textColor: Colors.blue,
                    hideArrow: true,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SOSPage(whatsapp: whatsapp), // Passando o WhatsApp para a SOSPage
                      ),
                    ),
                  ),
                ),
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
  final bool hideArrow;  // Propriedade para esconder a seta

  MenuButton({
    required this.iconPath,
    required this.label,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.deepPurple,
    this.hideArrow = false,  // Define padrão como falso, seta visível
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 16),
                  Image.asset(iconPath, width: 24, height: 24),  // Ícone à esquerda
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
              if (!hideArrow)  // Mostra a seta somente se hideArrow for falso
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Image.asset('assets/seta.png', width: 24, height: 24),  // Seta à direita
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
      backgroundColor: Colors.purpleAccent, // Cor de fundo da tela
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // LEI MARIA DA PENHA
            customExpansionTile(
              icon: Icons.gavel,
              title: 'LEI MARIA DA PENHA',
              description: 'O que é?\n\n'
                  'Lei brasileira que visa proteger as mulheres da violência doméstica e familiar. A lei define a violência doméstica como crime, e aponta formas de evitar, enfrentar e punir a agressão.',
              additionalInfo: 'O que precisa?\n\n'
                  '1. Procurar órgãos públicos como saúde, assistência social, segurança pública, e justiça.\n'
                  '2. Não tenha vergonha de pedir ajuda, inclusive psicológica.\n'
                  '3. Ligue 180 para atendimento 24 horas.\n'
                  '4. Solicite medidas protetivas para afastamento do agressor.',
            ),
            SizedBox(height: 20),

            // MEDIDA PROTETIVA ONLINE
            customExpansionTile(
              icon: Icons.shield,
              title: 'MEDIDA PROTETIVA ONLINE',
              description: 'O que é?\n\n'
                  'Medida criada por lei e determinada pelo juiz, para proteger mulheres vítimas de violência doméstica e familiar.',
              additionalInfo: 'O que precisa?\n\n'
                  '1. Acessar o gov.br com seu CPF.\n'
                  '2. Preencher um formulário descrevendo o caso.\n'
                  '3. Aguardar a aprovação.',
            ),
            SizedBox(height: 20),

            // BOLSA FAMÍLIA
            customExpansionTile(
              icon: Icons.family_restroom,
              title: 'BOLSA FAMÍLIA',
              description: 'O que é?\n\n'
                  'Programa de transferência de renda para famílias com renda mensal de, no máximo, 218 reais por pessoa.',
              additionalInfo: 'Como fazer?\n\n'
                  '1. Estar inscrito no Cadastro Único, com dados atualizados.\n'
                  '2. O cadastramento é feito no CRAS, com apresentação de CPF ou título de eleitor.',
            ),
            SizedBox(height: 20),

            // VALE GÁS
            customExpansionTile(
              icon: Icons.local_gas_station,
              title: 'VALE GÁS',
              description: 'O que é?\n\n'
                  'Recarga gratuita de botijão de gás para famílias cearenses em situação de vulnerabilidade, distribuída três vezes ao ano.',
              additionalInfo: 'Quem tem direito?\n\n'
                  '1. Famílias com Cartão Mais Infância Ceará ou inscritas no CadÚnico, beneficiadas pelo Bolsa Família.',
            ),
            SizedBox(height: 20),

            // BPC - BENEFÍCIO DE PRESTAÇÃO CONTINUADA
            customExpansionTile(
              icon: Icons.attach_money,
              title: 'BPC - BENEFÍCIO DE PRESTAÇÃO CONTINUADA',
              description: 'O que é?\n\n'
                  'Benefício de um salário mínimo pago mensalmente a idosos ou pessoas com deficiência que não podem garantir sua sobrevivência.',
              additionalInfo: 'Quem tem direito?\n\n'
                  '1. Pessoa idosa com 65 anos ou mais e renda familiar de até 1/4 do salário mínimo por pessoa.\n'
                  '2. Pessoa com transtorno global de desenvolvimento(Autismo). Quem recebe acima de um salário mínimo não recebe\n'
                  '3. O Cadastro Único deve estar atualizado há menos de dois anos.',
            ),
            SizedBox(height: 20),

            // CARTÃO MAIS INFÂNCIA CEARÁ
            customExpansionTile(
              icon: Icons.card_giftcard,
              title: 'CARTÃO MAIS INFÂNCIA CEARÁ',
              description: 'O que é?\n\n'
                  'Programa do Governo do Ceará que oferece 100 Reais mensais para famílias em situação de vulnerabilidade social.',
              additionalInfo: 'Quem tem direito?\n\n'
                  '1. Famílias com renda per capita de até 89,00 Reais.',
            ),
            SizedBox(height: 20),

            // CARTÃO CEARÁ SEM FOME
            customExpansionTile(
              icon: Icons.fastfood,
              title: 'CARTÃO CEARÁ SEM FOME',
              description: 'O que é?\n\n'
                  'Programa que distribui 300 Reais mensais para compra de alimentos a famílias vulneráveis.',
              additionalInfo: 'Quem tem direito?\n\n'
                  '1. Famílias cadastradas no Cadastro Único há no máximo 24 meses.\n'
                  '2. Beneficiárias do Bolsa Família, com renda per capita de até 218,00 Reais.',
            ),
          ],
        ),
      ),
    );
  }

  Widget customExpansionTile({required IconData icon, required String title, required String description, required String additionalInfo}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Fundo branco
        borderRadius: BorderRadius.circular(15), // Bordas arredondadas
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2), // Sombra suave
          ),
        ],
      ),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.purple), // Ícone à esquerda
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.purple, // Texto roxo
          ),
        ),
        trailing: Icon(Icons.arrow_forward, color: Colors.amber), // Seta à direita
        children: [
          ListTile(
            title: Text(
              description,
              style: TextStyle(color: Colors.black), // Texto preto
            ),
          ),
          ListTile(
            title: Text(
              additionalInfo,
              style: TextStyle(color: Colors.black), // Texto preto
            ),
          ),
        ],
      ),
    );
  }
}


class InstituicoesApoioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,  // Cor de fundo igual à página de Leis Públicas
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SupportGroupItem(
              icon: Icons.group,
              title: 'Grupo terapêutico de saúde mental: Primazia',
              description: 'Para mulheres das UBS Sede I e III',
            ),
            SizedBox(height: 20),
            SupportGroupItem(
              icon: Icons.group,
              title: 'Grupo terapêutico de saúde mental: Florescer',
              description: 'Para agentes de saúde da Sede',
            ),
            SizedBox(height: 20),
            SupportGroupItem(
              icon: Icons.group,
              title: 'Grupo terapêutico de saúde mental: Amanhecer',
              description: 'Para agentes de saúde da Lagoinha',
            ),
            SizedBox(height: 20),
            SupportGroupItem(
              icon: Icons.family_restroom,
              title: 'Grupo terapêutico de saúde mental: Gerando Vidas',
              description: 'Para gestantes da Sede I e III',
            ),
            SizedBox(height: 20),
            SupportGroupItem(
              icon: Icons.fitness_center,
              title: 'Grupos de atividades físicas',
              description: 'Vinculados às UBS',
            ),
            SizedBox(height: 20),
            SupportGroupItem(
              icon: Icons.child_friendly,
              title: 'Grupo de mães atípicas no CIR',
              description: 'Centro de Reabilitação',
            ),
            SizedBox(height: 20),
            SupportGroupItem(
              icon: Icons.self_improvement,
              title: 'Grupo semanal de autocuidado em saúde mental - CAPS -',
              description: 'Com enfermeira e assistente social',
            ),
            SizedBox(height: 20),
            SupportGroupItem(
              icon: Icons.psychology,
              title: 'Grupo quinzenal de psicoterapia integrativa em saúde mental com terapeuta holístico no CAPS',
              description: 'E grupo mensal de práticas integrativas',
            ),
            SizedBox(height: 20),
            SupportGroupItem(
              icon: Icons.public,
              title: 'Projeto Equivida',
              description: 'Territórios: Lagoinha, Ubaia, Bom Sucesso, e mais',
            ),
          ],
        ),
      ),
    );
  }
}

// Componente para criar os itens dos grupos de apoio
class SupportGroupItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  SupportGroupItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,  // Fundo branco
        borderRadius: BorderRadius.circular(15),  // Bordas arredondadas
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),  // Sombra suave
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.purple),  // Ícone à esquerda
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.purple,  // Texto roxo
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: Colors.black),  // Texto preto
        ),
        trailing: Icon(Icons.arrow_forward, color: Colors.amber),  // Seta à direita
      ),
    );
  }
}


class NumerosEmergenciaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,  // Mesma cor de fundo
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            EmergencyContactItem(
              title: 'Central de Atendimento à Mulher – 180',
              phoneNumber: 'tel:180',
            ),
            SizedBox(height: 20),
            EmergencyContactItem(
              title: 'Polícia Militar do Ceará - 190',
              phoneNumber: 'tel:190',
              description: 'Localizado ao lado do posto de combustível de Mizael',
            ),
            SizedBox(height: 20),
            EmergencyContactItem(
              title: 'Casa da Mulher Brasileira (Fortaleza)',
              phoneNumber: 'tel:+558531082950',
            ),
            SizedBox(height: 20),
            EmergencyContactItem(
              title: 'Conselho Municipal dos Direitos da Mulher (COMDIM)',
              phoneNumber: 'tel:+558821721092',
              description: 'Rua lateral do CVT - Quixeré',
            ),
            SizedBox(height: 20),
            EmergencyContactItem(
              title: 'Conselho Municipal de Assistência Social (CRAS)',
              phoneNumber: 'tel:+558821721092',
              description: 'Rua lateral do CVT - Quixeré',
            ),
            SizedBox(height: 20),
            EmergencyContactItem(
              title: 'Conselho Municipal dos Direitos da Pessoa Idosa (CMDPI)',
              phoneNumber: 'tel:+558821721092',
              description: 'Rua lateral do CVT - Quixeré',
            ),
            SizedBox(height: 20),
            EmergencyContactItem(
              title: 'Conselho Municipal dos Direitos da Criança e do Adolescente (CMDCA)',
              phoneNumber: 'tel:+5588997551632',
              description: 'Rua lateral do CVT - Quixeré',
            ),
          ],
        ),
      ),
    );
  }
}

// Componente para os itens de número de emergência
class EmergencyContactItem extends StatelessWidget {
  final String title;
  final String phoneNumber;
  final String? description;

  EmergencyContactItem({
    required this.title,
    required this.phoneNumber,
    this.description,
  });

  // Função para abrir o discador com a função launchUrl
  void _launchPhoneDialer(String number) async {
    final Uri url = Uri.parse(number);
    if (!await launchUrl(url)) {
      throw 'Could not launch $number';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchPhoneDialer(phoneNumber),  // Abre o telefone ao clicar
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              if (description != null) ...[
                SizedBox(height: 8),
                Text(
                  description!,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class SOSPage extends StatefulWidget {
  final String whatsapp;

  SOSPage({required this.whatsapp});

  @override
  _SOSPageState createState() => _SOSPageState();
}

class _SOSPageState extends State<SOSPage> {
  Position? _currentPosition; // Variável para armazenar a posição atual
  String _locationMessage = 'Buscando localização...'; // Mensagem inicial de localização

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Pega a localização inicial quando a página é aberta
  }

  // Função para buscar a localização
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica se o serviço de localização está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = 'Serviço de localização está desabilitado.';
      });
      return;
    }

    // Verifica as permissões de localização
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = 'Permissão de localização negada';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = 'Permissão de localização negada permanentemente';
      });
      return;
    }

    // Obtém a localização atual
    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        _currentPosition = position;
        _locationMessage =
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      });
    });
  }

  // Função para enviar a mensagem SOS com a localização
  void _sendSOSMessage() {
    final message = 'Emergência! Preciso de ajuda. Minha localização atual é: $_locationMessage';
    final url = 'https://wa.me/${widget.whatsapp}?text=${Uri.encodeComponent(message)}';

    if (canLaunch(url) != null) {
      launch(url);
    } else {
      print('Não foi possível abrir o WhatsApp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Caixas de diálogo acima do botão "Enviar SOS"
              _buildCustomBox(
                'Este recurso é destinado exclusivamente para situações reais de emergência.',
              ),
              SizedBox(height: 10),
              _buildCustomBox(
                'O uso indevido, como trotes ou chamadas falsas, é ilegal e será tratado com seriedade.',
              ),
              SizedBox(height: 10),
              _buildCustomBox(
                'Caso o sistema detecte uso impróprio, as autoridades competentes serão automaticamente notificadas.',
              ),
              SizedBox(height: 10),
              _buildCustomBox(
                'Lembre-se: fazer trote é crime e pode colocar vidas em risco. Utilize esta função apenas quando '
                'estiver em perigo real ou precisar de assistência urgente.',
              ),
              SizedBox(height: 30),

              // Exibe a localização atualizada
              Text(
                'Localização atual: $_locationMessage',
                style: TextStyle(color: Colors.black, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // Botão para enviar SOS
              ElevatedButton(
                onPressed: _sendSOSMessage,
                child: Text('Enviar SOS com localização'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para criar os quadros com o estilo branco como os botões do segundo anexo
  Widget _buildCustomBox(String text) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white, // Cor branca como nos botões do segundo anexo
        borderRadius: BorderRadius.circular(10), // Borda arredondada
        boxShadow: [
          BoxShadow(
            color: Colors.black12, // Adiciona uma leve sombra
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 16), // Texto preto
        textAlign: TextAlign.center, // Centraliza o texto
      ),
    );
  }
}