import 'package:flutter/material.dart';
import 'package:flutter_job_marketplace/routes.dart';
import 'package:flutter_job_marketplace/widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit profile
              Navigator.pushNamed(context, AppRoutes.securityData);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/1.jpg'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Juan Pérez',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Mecánico',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.people,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    '12',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.work,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    '2',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Profesión',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildProfileSection(
                title: 'Experiencia - A',
                content: '5 años de experiencia en reparación de vehículos',
                icon: Icons.work,
              ),
              _buildProfileSection(
                title: 'Desarrollo - B',
                content: 'Especialista en motores diésel y gasolina',
                icon: Icons.build,
              ),
              _buildProfileSection(
                title: 'CV - C',
                content: 'Ver currículum completo',
                icon: Icons.description,
                isLink: true,
                onTap: () {
                  // Show CV
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Currículum'),
                      content: const SingleChildScrollView(
                        child: Text(
                          'Experiencia laboral:\n- Taller Mecánico López (2018-2023)\n- Concesionario Toyota (2015-2018)\n\nFormación:\n- Técnico en Mecánica Automotriz\n- Certificación en Sistemas de Inyección',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cerrar'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              _buildProfileSection(
                title: 'Datos Personales - D',
                content: 'Editar información personal',
                icon: Icons.person,
                isLink: true,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.securityData);
                },
              ),
              _buildProfileSection(
                title: 'Servicios - E',
                content: 'Ver servicios ofrecidos',
                icon: Icons.miscellaneous_services,
                isLink: true,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.services);
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Comentarios',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildCommentCard(
                username: 'user1',
                comment: 'Excelente servicio, muy profesional y puntual.',
                date: '10/03/2023',
                rating: 5,
              ),
              _buildCommentCard(
                username: 'user2',
                comment: 'Buen trabajo, recomendado para reparaciones complejas.',
                date: '05/02/2023',
                rating: 4,
              ),
              _buildCommentCard(
                username: 'user3',
                comment: 'Rápido y eficiente, precios razonables.',
                date: '20/01/2023',
                rating: 5,
              ),
              const SizedBox(height: 24),
              const Text(
                'Trabajos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildWorkCard(
                title: 'Reparación de motor',
                date: '15/03/2023',
                status: 'Completado',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.workDetails);
                },
              ),
              _buildWorkCard(
                title: 'Cambio de frenos',
                date: '28/02/2023',
                status: 'Completado',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.workDetails);
                },
              ),
              _buildWorkCard(
                title: 'Diagnóstico electrónico',
                date: '10/02/2023',
                status: 'Completado',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.workDetails);
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Edición de Perfil visible',
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.securityData);
                      },
                      icon: Icons.edit,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Edición oferta de trabajo',
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.bolsaWork);
                      },
                      icon: Icons.work,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Bolsa de Trabajo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '3803-000-000',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection({
    required String title,
    required String content,
    required IconData icon,
    bool isLink = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: isLink ? onTap : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.grey,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: TextStyle(
                      color: isLink ? Colors.blue : Colors.black,
                      decoration: isLink ? TextDecoration.underline : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentCard({
    required String username,
    required String comment,
    required String date,
    required int rating,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Comentario - $username',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(comment),
            const SizedBox(height: 8),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkCard({
    required String title,
    required String date,
    required String status,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const Icon(
                Icons.work,
                color: Colors.grey,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Fecha: $date',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
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

