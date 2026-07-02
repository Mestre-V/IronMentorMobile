import 'package:flutter/material.dart';
import 'package:segundaavaliacaovictor/professor.dart';

class AlunosDadosPage extends StatelessWidget {
  final AlunoModel aluno;

  const AlunosDadosPage({super.key, required this.aluno});

  // processamento: quantos treinos ainda faltam pro aluno
  int get treinosRestantes => aluno.treinosTotal - aluno.treinosCompletos;

  // processamento: percentual concluído formatado
  String get percentualConcluido => '${(aluno.progresso * 100).toStringAsFixed(0)}%';

  @override
  Widget build(BuildContext context) {
    // lista de informações que vão virar os cards da tela
    final itens = [
      _ItemDetalhe('Peso', '${aluno.peso.toStringAsFixed(1)} kg'),
      _ItemDetalhe('Altura', '${aluno.altura.toStringAsFixed(2)} m'),
      _ItemDetalhe('IMC', '${aluno.imc.toStringAsFixed(1)} (${aluno.imcClassificacao})'),
      _ItemDetalhe('Treinos concluídos', '${aluno.treinosCompletos}/${aluno.treinosTotal}'),
      _ItemDetalhe('Treinos restantes', '$treinosRestantes'),
      _ItemDetalhe('Progresso', percentualConcluido),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF1A2332),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A2332),
        elevation: 0,
        title: Text(
          aluno.nome,
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: itens.length,
        itemBuilder: (context, index) {
          final item = itens[index];
          // entrada em cascata dos cards
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: Duration(milliseconds: 300 + (index * 100)),
            curve: Curves.easeOut,
            builder: (context, valor, child) {
              return Opacity(
                opacity: valor.clamp(0, 1),
                child: Transform.translate(
                  offset: Offset(0, (1 - valor.clamp(0, 1)) * 20),
                  child: child,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF2A3F5F),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.titulo, style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                  Text(
                    item.valor,
                    style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// classe simples só pra guardar cada linha de informação
class _ItemDetalhe {
  final String titulo;
  final String valor;

  _ItemDetalhe(this.titulo, this.valor);
}