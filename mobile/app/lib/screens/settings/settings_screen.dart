import 'package:flutter/material.dart';
import 'package:flutter_job_marketplace/providers/auth_provider.dart';
import 'package:flutter_job_marketplace/providers/theme_provider.dart';
import 'package:flutter_job_marketplace/routes.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            title: 'Cuenta',
            children: [
              _buildSettingItem(
                context,
                icon: Icons.person,
                title: 'Perfil',
                subtitle: 'Editar información personal',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.profile);
                },
              ),
              _buildSettingItem(
                context,
                icon: Icons.security,
                title: 'Seguridad',
                subtitle: 'Cambiar contraseña',
                onTap: () {
                  // Navigate to security settings
                },
              ),
              _buildSettingItem(
                context,
                icon: Icons.notifications,
                title: 'Notificaciones',
                subtitle: 'Configurar notificaciones',
                onTap: () {
                  // Navigate to notification settings
                },
              ),
              _buildSettingItem(
                context,
                icon: Icons.privacy_tip,
                title: 'Privacidad',
                subtitle: 'Configurar privacidad',
                onTap: () {
                  // Navigate to privacy settings
                },
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'Apariencia',
            children: [
              SwitchListTile(
                secondary: Icon(
                  themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).primaryColor,
                ),
                title: const Text('Modo oscuro'),
                subtitle: Text(
                  themeProvider.isDarkMode ? 'Activado' : 'Desactivado',
                ),
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'Soporte',
            children: [
              _buildSettingItem(
                context,
                icon: Icons.help,
                title: 'Ayuda',
                subtitle: 'Preguntas frecuentes',
                onTap: () {
                  // Navigate to help
                },
              ),
              _buildSettingItem(
                context,
                icon: Icons.contact_support,
                title: 'Contacto',
                subtitle: 'Contactar con soporte',
                onTap: () {
                  // Navigate to contact
                },
              ),
              _buildSettingItem(
                context,
                icon: Icons.info,
                title: 'Acerca de',
                subtitle: 'Información de la aplicación',
                onTap: () {
                  // Show about dialog
                  showAboutDialog(
                    context: context,
                    applicationName: 'Bolsa de Trabajo LR',
                    applicationVersion: '1.0.0',
                    applicationIcon: Icon(
                      Icons.work,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                    applicationLegalese: '© 2023 Bolsa de Trabajo LR',
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        'Bolsa de Trabajo LR es una plataforma que conecta profesionales con clientes de manera rápida y segura.',
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'Sesión',
            children: [
              _buildSettingItem(
                context,
                icon: Icons.exit_to_app,
                title: 'Cerrar sesión',
                subtitle: 'Salir de la aplicación',
                onTap: () async {
                  // Show confirmation dialog
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Cerrar sesión'),
                      content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Cerrar sesión'),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    await authProvider.logout();
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: children,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

