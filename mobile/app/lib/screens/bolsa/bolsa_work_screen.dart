import 'package:flutter/material.dart';
import 'package:flutter_job_marketplace/routes.dart';
import 'package:flutter_job_marketplace/widgets/custom_button.dart';

class BolsaWorkScreen extends StatefulWidget {
  const BolsaWorkScreen({super.key});

  @override
  State<BolsaWorkScreen> createState() => _BolsaWorkScreenState();
}

class _BolsaWorkScreenState extends State<BolsaWorkScreen> {
  final List<Map<String, dynamic>> _jobs = [
    {
      'id': '1',
      'title': 'Trabajo1',
      'description': 'Pintura de interior de casa',
      'details': 'Incluye paredes y techo',
      'requirements': 'Materiales incluidos',
      'price': 1000,
    },
    {
      'id': '2',
      'title': 'Trabajo2',
      'description': 'Reparación de motor',
      'details': 'Motor diésel 2.0',
      'requirements': 'Repuestos no incluidos',
      'price': 1200,
    },
    {
      'id': '3',
      'title': 'Trabajo3',
      'description': 'Instalación eléctrica',
      'details': 'Casa completa',
      'requirements': 'Materiales incluidos',
      'price': 1500,
    },
    {
      'id': '4',
      'title': 'Trabajo4',
      'description': 'Diseño de jardín',
      'details': '200m² de terreno',
      'requirements': 'Plantas no incluidas',
      'price': 2000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bolsa de Trabajo'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _jobs.length,
                itemBuilder: (context, index) {
                  return _buildJobCard(
                    title: _jobs[index]['title'],
                    description: _jobs[index]['description'],
                    details: _jobs[index]['details'],
                    requirements: _jobs[index]['requirements'],
                    price: _jobs[index]['price'],
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.workDetails);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new job
          _showAddJobDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildJobCard({
    required String title,
    required String description,
    required String details,
    required String requirements,
    required double price,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$$price',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Descripción: $description',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Detalle: $details',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Requerimientos: $requirements',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddJobDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nuevo Trabajo'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Detalles',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Requerimientos',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Precio',
                  border: OutlineInputBorder(),
                  prefixText: '\$',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Trabajo publicado con éxito'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Publicar'),
          ),
        ],
      ),
    );
  }
}

