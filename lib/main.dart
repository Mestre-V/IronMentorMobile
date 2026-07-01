import 'package:flutter/material.dart';
import 'package:segundaavaliacaovictor/treinos.dart';
import 'package:segundaavaliacaovictor/professor.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iron Mentor',
      home:  LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
   LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _userType = 'Professor';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Padding(
          padding:  EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(
                'Iron Mentor',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
               SizedBox(height: 20),

              TextField(
              
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle:  TextStyle(color: Colors.orange),
                  focusedBorder:  OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 2),
                  ),
                  border:  OutlineInputBorder(),
                ),
              ),
               SizedBox(height: 20),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle:  TextStyle(color: Colors.orange),
                  focusedBorder:  OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 2),
                  ),
                  border:  OutlineInputBorder(),
                ),
              ),
               SizedBox(height: 20),

              // para tipo de usuário
              Container(
                padding:  EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color:  Color(0xFF2A3F5F),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: _userType,
                  isExpanded: true,
                  underline:  SizedBox(),
                  style:  TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  dropdownColor:  Color(0xFF2A3F5F),
                  items:  [
                    DropdownMenuItem(value: 'Professor', child: Text('Professor')),
                    DropdownMenuItem(value: 'Aluno', child: Text('Aluno')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _userType = value!;
                    });
                  },
                ),
              ),
               SizedBox(height: 40),

              // botao de login
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient:  LinearGradient(
                    colors: [Color(0xFFFF6B35), Color(0xFFFF4500)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                        if (_userType == 'Professor') {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfessorPage()));
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TreinosPage(userType: _userType)));
                        }
                      },
                    child:  Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'Entrar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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
