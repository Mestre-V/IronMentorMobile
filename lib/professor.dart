import 'package:flutter/material.dart';

class AlunoModel {
  final String nome;
  final double peso;
  final double altura;
  final int treinosCompletos;
  final int treinosTotal;

  AlunoModel({
    required this.nome,
    required this.peso,
    required this.altura,
    required this.treinosCompletos,
    required this.treinosTotal,
  });

  // processamento: calcula o IMC do aluno
  double get imc => peso / (altura * altura);

  // processamento: progresso do aluno de 0.0 a 1.0
  double get progresso =>
      treinosTotal == 0 ? 0 : treinosCompletos / treinosTotal;

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
    AlunoModel(nome: 'Lucas Almeida', peso: 78, altura: 1.78, treinosCompletos: 18, treinosTotal: 24),
    AlunoModel(nome: 'Marina Costa', peso: 62, altura: 1.65, treinosCompletos: 22, treinosTotal: 24),
    AlunoModel(nome: 'Rafael Souza', peso: 91, altura: 1.82, treinosCompletos: 10, treinosTotal: 24),
    AlunoModel(nome: 'Beatriz Lima', peso: 55, altura: 1.60, treinosCompletos: 24, treinosTotal: 24),
    AlunoModel(nome: 'Gustavo Rocha', peso: 84, altura: 1.75, treinosCompletos: 14, treinosTotal: 24),
  ];

  // processamento: IMC médio dos alunos
  double get imcMedioAlunos {
    if (alunos.isEmpty) return 0;
    final soma = alunos.fold<double>(0, (prev, a) => prev + a.imc);
    return soma / alunos.length;
  }

  // processamento: progresso médio dos alunos
  double get progressoMedioAlunos {
    if (alunos.isEmpty) return 0;
    final soma = alunos.fold<double>(0, (prev, a) => prev + a.progresso);
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
                    titulo: 'Progresso médio dos alunos',
                    valor: '${(progressoMedioAlunos * 100).toStringAsFixed(0)}%',
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
                  const SizedBox(width: 8),
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
                        _linhaDetalhe('Treinos', '${aluno.treinosCompletos}/${aluno.treinosTotal}'),
                      ],
                    ),
                  )
                : const SizedBox(width: double.infinity, height: 0),
          ),
        ],
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