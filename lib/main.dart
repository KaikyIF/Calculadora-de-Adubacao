import 'package:flutter/material.dart';

void main() {
  runApp(const CalculadoraApp());
}

// ============================================================
// PASSO 1 - Aplicativo principal
// ============================================================

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de Adubação',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const TelaCalculadora(),
    );
  }
}

// ============================================================
// PASSO 2 - Tela principal da calculadora
// ============================================================

class TelaCalculadora extends StatefulWidget {
  const TelaCalculadora({super.key});

  @override
  State<TelaCalculadora> createState() => _TelaCalculadoraState();
}

// ============================================================
// PASSO 3 - Estado da tela
// ============================================================

class _TelaCalculadoraState extends State<TelaCalculadora> {
  // ==========================================================
  // PASSO 4 - Controllers dos campos de texto
  // ==========================================================

  final _areaController = TextEditingController();
  final _doseController = TextEditingController();

  // ==========================================================
  // PASSO 5 - Variável para guardar o tamanho do saco
  // ==========================================================

  int _pesoSaco = 50;

  // ==========================================================
  // PASSO 6 - Variáveis que armazenam os resultados
  // ==========================================================

  double? _totalFertilizante;
  int? _sacos;
  String? _erro;

  // ==========================================================
  // PASSO 7 - Função responsável pelo cálculo
  // ==========================================================

  void _calcular() {
    // Pega os valores digitados pelo usuário.
    final textoArea = _areaController.text.trim().replaceAll(',', '.');
    final textoDose = _doseController.text.trim().replaceAll(',', '.');

    // Tenta converter os textos para números.
    final area = double.tryParse(textoArea);
    final dose = double.tryParse(textoDose);

    setState(() {
      // Limpa o resultado anterior antes de fazer uma nova validação.
      _totalFertilizante = null;
      _sacos = null;
      _erro = null;

      // ======================================================
      // PASSO 8 - Verifica se os campos estão vazios
      // ======================================================

      if (textoArea.isEmpty || textoDose.isEmpty) {
        _erro = 'Preencha todos os campos antes de calcular.';
        return;
      }

      // ======================================================
      // PASSO 9 - Verifica se os valores são números válidos
      // ======================================================

      if (area == null || dose == null) {
        _erro = 'Por favor, insira valores numéricos válidos.';
        return;
      }

      // ======================================================
      // PASSO 10 - Verifica se os valores são maiores que zero
      // ======================================================

      if (area <= 0 || dose <= 0) {
        _erro = 'Todos os valores devem ser maiores que zero.';
        return;
      }

      // ======================================================
      // PASSO 11 - Realiza o cálculo
      // ======================================================

      _totalFertilizante = area * dose;
      _sacos = (_totalFertilizante! / _pesoSaco).ceil();
    });
  }

  // ============================================================
  // PASSO 12 - Função para limpar os campos
  // ============================================================

  void _limpar() {
    setState(() {
      _areaController.clear();
      _doseController.clear();

      // Volta o tamanho do saco para 50 kg.
      _pesoSaco = 50;

      _totalFertilizante = null;
      _sacos = null;
      _erro = null;
    });
  }

  // ============================================================
  // PASSO 13 - Libera os controllers quando a tela é fechada
  // ============================================================

  @override
  void dispose() {
    _areaController.dispose();
    _doseController.dispose();

    super.dispose();
  }

  // ============================================================
  // PASSO 14 - Formatação da quantidade de fertilizante
  // ============================================================

  String _formatarKg(double valor) {
    final fixo = valor.toStringAsFixed(2);

    return '${fixo.replaceAll('.', ',')} kg';
  }

  // ============================================================
  // PASSO 15 - Construção da interface
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ========================================================
      // PASSO 16 - Barra superior
      // ========================================================

      appBar: AppBar(
        title: const Text('Calculadora de Adubação'),
        centerTitle: true,
      ),

      // ========================================================
      // PASSO 17 - Conteúdo principal
      // ========================================================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Calcule a quantidade de fertilizante necessária '
              'para sua área.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            // ==================================================
            // PASSO 18 - Card dos dados de entrada
            // ==================================================
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Dados da adubação',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ==========================================
                    // PASSO 19 - Campo da área
                    // ==========================================
                    _CampoNumero(
                      controller: _areaController,
                      label: 'Área do terreno',
                      dica: 'Ex.: 10',
                      icone: Icons.landscape,
                    ),

                    const SizedBox(height: 16),

                    // ==========================================
                    // PASSO 20 - Campo da dose
                    // ==========================================
                    _CampoNumero(
                      controller: _doseController,
                      label: 'Dose recomendada (kg/ha)',
                      dica: 'Ex.: 200',
                      icone: Icons.grass,
                    ),

                    const SizedBox(height: 16),

                    // ==========================================
                    // PASSO 21 - Escolha do peso do saco
                    // ==========================================
                    DropdownButtonFormField<int>(
                      value: _pesoSaco,
                      decoration: const InputDecoration(
                        labelText: 'Peso do saco',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.inventory_2),
                      ),

                      // Opções disponíveis.
                      items: const [
                        DropdownMenuItem(value: 25, child: Text('25 kg')),
                        DropdownMenuItem(value: 50, child: Text('50 kg')),
                        DropdownMenuItem(value: 60, child: Text('60 kg')),
                      ],

                      // Executado quando o usuário escolhe uma opção.
                      onChanged: (valor) {
                        if (valor != null) {
                          setState(() {
                            _pesoSaco = valor;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ==================================================
            // PASSO 22 - Botões
            // ==================================================
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _calcular,
                    icon: const Icon(Icons.calculate),
                    label: const Text('Calcular'),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _limpar,
                    icon: const Icon(Icons.clear),
                    label: const Text('Limpar'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ==================================================
            // PASSO 23 - Área do resultado
            // ==================================================
            _AreaResultado(
              totalFertilizante: _totalFertilizante,
              sacos: _sacos,
              pesoSaco: _pesoSaco,
              erro: _erro,
              formatar: _formatarKg,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PASSO 24 - Widget reutilizável para campos numéricos
// ============================================================

class _CampoNumero extends StatelessWidget {
  const _CampoNumero({
    required this.controller,
    required this.label,
    required this.dica,
    required this.icone,
  });

  final TextEditingController controller;
  final String label;
  final String dica;
  final IconData icone;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      // Teclado numérico.
      keyboardType: const TextInputType.numberWithOptions(decimal: true),

      decoration: InputDecoration(
        labelText: label,
        hintText: dica,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icone),
      ),
    );
  }
}

// ============================================================
// PASSO 25 - Widget responsável por mostrar o resultado
// ============================================================

class _AreaResultado extends StatelessWidget {
  const _AreaResultado({
    required this.totalFertilizante,
    required this.sacos,
    required this.pesoSaco,
    required this.erro,
    required this.formatar,
  });

  final double? totalFertilizante;
  final int? sacos;
  final int pesoSaco;
  final String? erro;
  final String Function(double) formatar;

  @override
  Widget build(BuildContext context) {
    // ==========================================================
    // PASSO 26 - Mostra mensagem de erro
    // ==========================================================

    if (erro != null) {
      return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.warning_amber, color: Colors.red),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  erro!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // ==========================================================
    // PASSO 27 - Caso ainda não exista resultado
    // ==========================================================

    if (totalFertilizante == null || sacos == null) {
      return const SizedBox.shrink();
    }

    // ==========================================================
    // PASSO 28 - Card com o resultado
    // ==========================================================

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Resultado',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            // Quantidade total de fertilizante.
            Text(
              'Fertilizante necessário:',
              style: TextStyle(color: Colors.grey.shade700),
            ),

            const SizedBox(height: 4),

            Text(
              formatar(totalFertilizante!),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            // Quantidade de sacos.
            Text(
              'Sacos de $pesoSaco kg:',
              style: TextStyle(color: Colors.grey.shade700),
            ),

            const SizedBox(height: 4),

            Text(
              '$sacos sacos',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
