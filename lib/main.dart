import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IMC App',
      home: const ImcScreen(),
    );
  }
}

class ImcScreen extends StatefulWidget {
  const ImcScreen({super.key});

  @override
  State<ImcScreen> createState() => _ImcScreenState();
}

class _ImcScreenState extends State<ImcScreen> {
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();

  String resultado = "";
  String categoria = "";

  void calcularIMC() {
    if (pesoController.text.isEmpty || alturaController.text.isEmpty) {
      setState(() {
        resultado = "Campos vacíos";
        categoria = "";
      });
      return;
    }

    double? peso = double.tryParse(pesoController.text);
    double? altura = double.tryParse(alturaController.text);

    if (peso == null || altura == null) {
      setState(() {
        resultado = "Valores inválidos";
        categoria = "";
      });
      return;
    }

    if (peso <= 0 || altura <= 0) {
      setState(() {
        resultado = "Valores positivos únicamente";
        categoria = "";
      });
      return;
    }

    // 🔥 CORRECCIÓN
    double alturaMetros = altura / 100;
    double imc = peso / (alturaMetros * alturaMetros);

    if (imc < 18.5) {
      categoria = "Bajo peso";
    } else if (imc <= 24.9) {
      categoria = "Peso normal";
    } else if (imc <= 29.9) {
      categoria = "Sobrepeso";
    } else {
      categoria = "Obesidad";
    }

    setState(() {
      resultado = imc.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Card(
          elevation: 10,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Calcula tu IMC",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: pesoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Peso (kg)",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: alturaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Altura (cm)",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: calcularIMC,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  child: const Text("Calcular IMC"),
                ),
                const SizedBox(height: 20),
                if (resultado.isNotEmpty) ...[
                  Text(
                    "IMC: $resultado",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    categoria,
                    style: const TextStyle(fontSize: 18),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
