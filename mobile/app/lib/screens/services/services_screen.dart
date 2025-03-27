import 'package:flutter/material.dart';
import 'package:flutter_job_marketplace/routes.dart';
import 'package:flutter_job_marketplace/widgets/service_card.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final List<Map<String, dynamic>> _services = [
    {
      'name': 'Juan Pérez',
      'profession': 'Mecánico',
      'experience': '5 años',
      'development': 'Especialista en motores',
      'matches': 12,
      'jobs': 2,
    },
    {
      'name': 'María López',
      'profession': 'Pintora',
      'experience': '3 años',
      'development': 'Interiores y exteriores',
      'matches': 8,
      'jobs': 4,
    },
    {
      'name': 'Carlos Rodríguez',
      'profession': 'Electricista',
      'experience': '7 años',
      'development': 'Instalaciones residenciales',
      'matches': 15,
      'jobs': 6,
    },
    {
      'name': 'Ana Martínez',
      'profession': 'Jardinera',
      'experience': '4 años',
      'development': 'Diseño de jardines',
      'matches': 10,
      'jobs': 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
              showModalBottomSheet(
                context: context,
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: const Text('Filtrar por profesión'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Filtrar por experiencia'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Filtrar por calificación'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
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
                itemCount: _services.length,
                itemBuilder: (context, index) {
                  return ServiceCard(
                    name: _services[index]['name'],
                    profession: _services[index]['profession'],
                    experience: _services[index]['experience'],
                    development: _services[index]['development'],
                    matches: _services[index]['matches'],
                    jobs: _services[index]['jobs'],
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.workPublic);
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
          // Add new service
          Navigator.pushNamed(context, AppRoutes.profession);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

