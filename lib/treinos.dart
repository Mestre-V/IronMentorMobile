import 'package:flutter/material.dart';

class TreinosPage extends StatefulWidget {
  final String userType;

  const TreinosPage({super.key, required this.userType});

  @override
  State<TreinosPage> createState() => _TreinosPageState();
}

class _TreinosPageState extends State<TreinosPage> {
  // treinos pra cada dia
  final Map<String, List<String>> treinos = {
    'Segunda': [
      'Supino Reto, 4 séries de 8 repetições',
      'Supino Inclinado, 3 séries de 10 repetições',
      'Rosca Direta, 3 séries de 12 repetições',
    ],
    'Terça': [
      'Agachamento, 4 séries de 8 repetições',
      'Leg Press, 3 séries de 12 repetições',
      'Extensora, 3 séries de 12 repetições',
      'Flexora, 3 séries de 12 repetições',
    ],
    'Quarta': [
      'Rosca Inversa, 3 séries de 12 repetições',
      'Polia Alta, 3 séries de 12 repetições',
      'Crucifixo, 3 séries de 15 repetições',
    ],
    'Quinta': [
      'Agachamento Livre, 4 séries de 6 repetições',
      'Stiff, 3 séries de 10 repetições',
      'Panturrilha, 4 séries de 15 repetições',
    ],
    'Sexta': [
      'Supino Declinado, 3 séries de 10 repetições',
      'Paralela, 3 séries de 8 repetições',
      'Crucifixo Máquina, 3 séries de 12 repetições',
      'Rosca Rosca, 3 séries de 12 repetições',
    ],
    'Sábado': [
      'Descansar, que o homem não é de ferro',
    ],
  };

  final List<String> dias = ['Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'];
  int diaAtivo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A2332),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A2332),
        elevation: 0,
        title: const Text('Meus Treinos', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        children: [
          // grid dos dias da semana 2 linhas de 3 colunas
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 8,
              childAspectRatio: 2.8,
              children: List.generate(
                dias.length,
                (index) => GestureDetector(
                  onTap: () => setState(() => diaAtivo = index),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: diaAtivo == index ? const Color(0xFFFF6B35) : const Color(0xFF2A3F5F),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      dias[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(color: diaAtivo == index ? Colors.white : Colors.grey[400], fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // lista de exercícios do dia que o cara seleciona
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemCount: treinos[dias[diaAtivo]]?.length ?? 0,
              itemBuilder: (context, index) {
                final exercicio = treinos[dias[diaAtivo]]![index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A3F5F),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(exercicio, style: TextStyle(color: Colors.grey[400], fontSize: 16)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
