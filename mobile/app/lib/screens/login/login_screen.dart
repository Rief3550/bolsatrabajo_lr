import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job_marketplace/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_job_marketplace/routes.dart';
import 'package:flutter_job_marketplace/utils/validators.dart';
import 'package:flutter_job_marketplace/widgets/custom_button.dart';
import 'package:flutter_job_marketplace/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _isPasswordVisible = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    
    _animationController.forward();
    
    // Para pruebas, pre-llenamos las credenciales
    _userController.text = 'admin';
    _passwordController.text = 'admin';
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Usar el BlocProvider para obtener el AuthBloc
      context.read<AuthBloc>().add(LoginEvent(
        username: _userController.text.trim(),
        password: _passwordController.text,
      ));
    }
  }

  void _navigateToRegister() {
    Navigator.pushNamed(context, AppRoutes.register);
  }

  void _navigateToForgotPassword() {
    // Implementar navegación a pantalla de recuperación de contraseña
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Inicio de sesión exitoso'),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 40),
                        Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.work,
                              size: 60,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Iniciar sesión',
                          style: Theme.of(context).textTheme.displayMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        CustomTextField(
                          controller: _userController,
                          label: 'Usuario',
                          prefixIcon: Icons.person,
                          validator: Validators.validateUsername,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: _passwordController,
                          label: 'Contraseña',
                          prefixIcon: Icons.lock,
                          isPassword: !_isPasswordVisible,
                          validator: Validators.validatePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value ?? false;
                                    });
                                  },
                                ),
                                const Text('Recordarme'),
                              ],
                            ),
                            TextButton(
                              onPressed: _navigateToForgotPassword,
                              child: const Text('¿Olvidaste tu contraseña?'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          text: 'Iniciar sesión',
                          onPressed: state is AuthLoading ? null : _login,
                          isLoading: state is AuthLoading,
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text('O continúa con'),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          text: 'Continuar con Google',
                          onPressed: state is AuthLoading ? null : () {},
                          isOutlined: true,
                          icon: Icons.g_mobiledata,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('¿No tienes una cuenta?'),
                            TextButton(
                              onPressed: _navigateToRegister,
                              child: const Text(
                                'Regístrate ahora',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'de forma sencilla',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

