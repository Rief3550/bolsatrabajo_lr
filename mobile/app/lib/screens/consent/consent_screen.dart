import 'package:flutter/material.dart';
import 'package:flutter_job_marketplace/routes.dart';
import 'package:flutter_job_marketplace/widgets/custom_button.dart';

class ConsentScreen extends StatefulWidget {
  const ConsentScreen({super.key});

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  bool _agreedToTerms = false;

  void _continueToProfile() {
    if (_agreedToTerms) {
      Navigator.pushNamed(context, AppRoutes.securityData);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debe aceptar los términos para continuar'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consentimiento'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '¡Bienvenido!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Para comenzar debemos completar el perfil para poder contratar o ofrecer servicios en la app.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              const Text(
                'Necesitamos que estés de acuerdo para continuar:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'La aplicación necesita información personal para protegerte tenemos un convenio de confidencialidad para tu protección.',
                style: TextStyle(fontSize: 16),
              ),
              TextButton(
                onPressed: () {
                  // Show privacy policy
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Política de Privacidad'),
                      content: const SingleChildScrollView(
                        child: Text(
                          'Tu Privacidad es Nuestra Prioridad: En Bolsa de Trabajo LR, nos comprometemos a proteger la privacidad de nuestros usuarios...',
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
                child: const Text(
                  'Leer más',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Se solicita honestidad y sinceridad en la información por la interacción entre personas.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreedToTerms = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'He leído y acepto los términos y condiciones y la política de privacidad',
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CustomButton(
                text: 'Continuar',
                onPressed: _continueToProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

