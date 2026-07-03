import 'package:flutter/material.dart';
import 'package:segundaavaliacaovictor/alunosdados.dart';

class AlunoModel {
  final String nome;
  final double peso;
  final double altura;
  final double gorduraKg;
  final double massaMuscularKg;

  AlunoModel({
    required this.nome,
    required this.peso,
    required this.altura,
    required this.gorduraKg,
    required this.massaMuscularKg,
  });

  // processamento: calcula o IMC do aluno
  double get imc => peso / (altura * altura);

  // processamento: percentual de gordura do aluno, baseado na gordura (kg) e na massa muscular (kg)
  double get percentualGordura {
    final total = gorduraKg + massaMuscularKg;
    return total == 0 ? 0 : (gorduraKg / total) * 100;
  }

  // processamento: classificação textual do IMC
  String get imcClassificacao {
    if (imc < 18.5) return 'Abaixo do peso';
    if (imc < 25) return 'Peso normal';
    if (imc < 30) return 'Sobrepeso';
    return 'Obesidade';
  }
}

class ProfessorPage extends StatefulWidget {
  const ProfessorPage({super.key});

  @override
  State<ProfessorPage> createState() => _ProfessorPageState();
}

class _ProfessorPageState extends State<ProfessorPage> {
  // lista de alunos
  final List<AlunoModel> alunos = [
    AlunoModel(nome: 'Lucas Almeida', peso: 78, altura: 1.78, gorduraKg: 14, massaMuscularKg: 38),
    AlunoModel(nome: 'Marina Costa', peso: 62, altura: 1.65, gorduraKg: 16, massaMuscularKg: 24),
    AlunoModel(nome: 'Rafael Souza', peso: 91, altura: 1.82, gorduraKg: 22, massaMuscularKg: 40),
    AlunoModel(nome: 'Beatriz Lima', peso: 55, altura: 1.60, gorduraKg: 12, massaMuscularKg: 22),
    AlunoModel(nome: 'Gustavo Rocha', peso: 84, altura: 1.75, gorduraKg: 18, massaMuscularKg: 36),
  ];

  // processamento: IMC médio dos alunos
  double get imcMedioAlunos {
    if (alunos.isEmpty) return 0;
    final soma = alunos.fold<double>(0, (prev, a) => prev + a.imc);
    return soma / alunos.length;
  }

  // processamento: percentual de gordura médio dos alunos
  double get gorduraMediaAlunos {
    if (alunos.isEmpty) return 0;
    final soma = alunos.fold<double>(0, (prev, a) => prev + a.percentualGordura);
    return soma / alunos.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A2332),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A2332),
        elevation: 0,
        title: const Text(
          'Painel do Professor',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // cabeçalho simples com as estatísticas dos alunos
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: EstatisticaBox(titulo: 'Alunos', valor: '${alunos.length}'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: EstatisticaBox(
                    titulo: 'IMC médio dos alunos',
                    valor: imcMedioAlunos.toStringAsFixed(1),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: EstatisticaBox(
                    titulo: 'Gordura média dos alunos',
                    valor: '${gorduraMediaAlunos.toStringAsFixed(0)}%',
                  ),
                ),
              ],
            ),
          ),

          // lista de alunos com entrada escalonada
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemCount: alunos.length,
              itemBuilder: (context, index) {
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: Duration(milliseconds: 400 + (index * 120)),
                  curve: Curves.easeOutBack,
                  builder: (context, valor, child) {
                    return Opacity(
                      opacity: valor.clamp(0, 1),
                      child: Transform.translate(
                        offset: Offset(0, (1 - valor.clamp(0, 1)) * 30),
                        child: child,
                      ),
                    );
                  },
                  child: AlunoCard(aluno: alunos[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// widget stateless simples pra estatística do topo
class EstatisticaBox extends StatelessWidget {
  final String titulo;
  final String valor;

  const EstatisticaBox({super.key, required this.titulo, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A3F5F),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            valor,
            style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(
            titulo,
            style: TextStyle(color: Colors.grey[400], fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// card do aluno
class AlunoCard extends StatefulWidget {
  final AlunoModel aluno;

  const AlunoCard({super.key, required this.aluno});

  @override
  State<AlunoCard> createState() => _AlunoCardState();
}

class _AlunoCardState extends State<AlunoCard> {
  bool expandido = false;

  @override
  Widget build(BuildContext context) {
    final aluno = widget.aluno;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A3F5F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => setState(() => expandido = !expandido),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      aluno.nome,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  // botão de mais opções, abre a tela de dados detalhados do aluno
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.grey),
                    onPressed: () => _abrirDadosDoAluno(context, aluno),
                  ),
                  AnimatedRotation(
                    turns: expandido ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          // detalhes que aparecem/desaparecem animados
          // AnimatedSize calcula a altura sozinho
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: expandido
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(color: Colors.white12),
                        _linhaDetalhe('Peso', '${aluno.peso.toStringAsFixed(1)} kg'),
                        _linhaDetalhe('Altura', '${aluno.altura.toStringAsFixed(2)} m'),
                        _linhaDetalhe('IMC', '${aluno.imc.toStringAsFixed(1)} (${aluno.imcClassificacao})'),
                        _linhaDetalhe('Gordura corporal', '${aluno.gorduraKg.toStringAsFixed(1)} kg'),
                        _linhaDetalhe('Massa muscular', '${aluno.massaMuscularKg.toStringAsFixed(1)} kg'),
                        _linhaDetalhe('% Gordura', '${aluno.percentualGordura.toStringAsFixed(1)}%'),
                      ],
                    ),
                  )
                : const SizedBox(width: double.infinity, height: 0),
          ),
        ],
      ),
    );
  }

  // navega pra alunosdados com uma transição de fade e zoom leve
  void _abrirDadosDoAluno(BuildContext context, AlunoModel aluno) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) =>
            AlunosDadosPage(aluno: aluno),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final escala = Tween<double>(begin: 0.92, end: 1).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          );
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: escala, child: child),
          );
        },
      ),
    );
  }

  Widget _linhaDetalhe(String rotulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(rotulo, style: TextStyle(color: Colors.grey[400], fontSize: 13)),
          Text(valor, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}