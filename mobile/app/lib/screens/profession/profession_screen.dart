import 'package:flutter/material.dart';
import 'package:flutter_job_marketplace/routes.dart';
import 'package:flutter_job_marketplace/widgets/custom_button.dart';

class ProfessionScreen extends StatefulWidget {
  const ProfessionScreen({super.key});

  @override
  State<ProfessionScreen> createState() => _ProfessionScreenState();
}

class _ProfessionScreenState extends State<ProfessionScreen> {
  String _selectedProfileType = '';
  String _selectedProfession = '';
  String _selectedExperience = '';
  bool _hasLicense = false;
  final TextEditingController _additionalInfoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> _professions = [
    'Mecánico',
    'Pintor',
    'Electricista',
    'Jardinería',
    'Chofer',
    'Gastronomía',
    'Otro',
  ];

  final List<String> _experienceLevels = [
    'Menos de 1 año',
    '1-3 años',
    '3-5 años',
    'Más de 5 años',
  ];

  @override
  void dispose() {
    _additionalInfoController.dispose();
    super.dispose();
  }

  void _saveAndContinue() {
    if (_formKey.currentState!.validate()) {
      // In a real app, you would save the profession data here
      Navigator.pushNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil Profesional'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Falta poco, terminemos la carga para poder operar...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Defina el Perfil',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Prestación'),
                        value: 'Prestación',
                        groupValue: _selectedProfileType,
                        onChanged: (value) {
                          setState(() {
                            _selectedProfileType = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Contratación'),
                        value: 'Contratación',
                        groupValue: _selectedProfileType,
                        onChanged: (value) {
                          setState(() {
                            _selectedProfileType = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (_selectedProfileType == 'Prestación') ...[
                  const Text(
                    'Perfil de trabajo',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Profesión',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedProfession.isEmpty ? null : _selectedProfession,
                    hint: const Text('Seleccione su profesión'),
                    items: _professions.map((String profession) {
                      return DropdownMenuItem<String>(
                        value: profession,
                        child: Text(profession),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedProfession = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione una profesión';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Tiempo de experiencia',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedExperience.isEmpty ? null : _selectedExperience,
                    hint: const Text('Seleccione su experiencia'),
                    items: _experienceLevels.map((String experience) {
                      return DropdownMenuItem<String>(
                        value: experience,
                        child: Text(experience),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedExperience = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione su experiencia';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _additionalInfoController,
                    decoration: const InputDecoration(
                      labelText: 'Información adicional',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '¿Posee Matrícula?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('Sí'),
                          value: true,
                          groupValue: _hasLicense,
                          onChanged: (value) {
                            setState(() {
                              _hasLicense = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: const Text('No'),
                          value: false,
                          groupValue: _hasLicense,
                          onChanged: (value) {
                            setState(() {
                              _hasLicense = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  if (_hasLicense) ...[
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () {
                        // Implement file upload logic
                      },
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Cargar Matrícula'),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Los formatos aceptados son .PDF .DOCS .JPG',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ] else if (_selectedProfileType == 'Contratación') ...[
                  const Text(
                    'Contratación',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Profesiones buscadas',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedProfession.isEmpty ? null : _selectedProfession,
                    hint: const Text('Seleccione la profesión que busca'),
                    items: _professions.map((String profession) {
                      return DropdownMenuItem<String>(
                        value: profession,
                        child: Text(profession),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedProfession = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione una profesión';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Tipo de contratación',
                      border: OutlineInputBorder(),
                    ),
                    hint: const Text('Seleccione el tipo de contratación'),
                    items: const [
                      DropdownMenuItem(
                        value: 'Temporal',
                        child: Text('Temporal'),
                      ),
                      DropdownMenuItem(
                        value: 'Permanente',
                        child: Text('Permanente'),
                      ),
                      DropdownMenuItem(
                        value: 'Por proyecto',
                        child: Text('Por proyecto'),
                      ),
                    ],
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione un tipo de contratación';
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 32),
                CustomButton(
                  text: 'Completar',
                  onPressed: _saveAndContinue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

