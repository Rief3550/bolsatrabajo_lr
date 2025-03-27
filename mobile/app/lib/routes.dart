import 'package:flutter/material.dart';
import 'package:flutter_job_marketplace/screens/bolsa/bolsa_work_screen.dart';
import 'package:flutter_job_marketplace/screens/chat/chat_list_screen.dart';
import 'package:flutter_job_marketplace/screens/chat/chat_screen.dart';
import 'package:flutter_job_marketplace/screens/consent/consent_screen.dart';
import 'package:flutter_job_marketplace/screens/home/home_screen.dart';
import 'package:flutter_job_marketplace/screens/login/login_screen.dart';
import 'package:flutter_job_marketplace/screens/notifications/notifications_screen.dart';
import 'package:flutter_job_marketplace/screens/onboarding/onboarding_screen.dart';
import 'package:flutter_job_marketplace/screens/profession/profession_screen.dart';
import 'package:flutter_job_marketplace/screens/profile/profile_screen.dart';
import 'package:flutter_job_marketplace/screens/register/register_screen.dart';
import 'package:flutter_job_marketplace/screens/security/security_data_screen.dart';
import 'package:flutter_job_marketplace/screens/services/services_screen.dart';
import 'package:flutter_job_marketplace/screens/settings/settings_screen.dart';
import 'package:flutter_job_marketplace/screens/splash/splash_screen.dart';
import 'package:flutter_job_marketplace/screens/work/work_details_screen.dart';
import 'package:flutter_job_marketplace/screens/work/work_public_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String services = '/services';
  static const String profession = '/profession';
  static const String notifications = '/notifications';
  static const String workDetails = '/work-details';
  static const String workPublic = '/work-public';
  static const String consent = '/consent';
  static const String securityData = '/security-data';
  static const String bolsaWork = '/bolsa-work';
  static const String settings = '/settings';
  static const String chatList = '/chat-list';
  static const String chat = '/chat';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        onboarding: (context) => const OnboardingScreen(),
        login: (context) => const LoginScreen(),
        register: (context) => const RegisterScreen(),
        home: (context) => const HomeScreen(),
        profile: (context) => const ProfileScreen(),
        services: (context) => const ServicesScreen(),
        profession: (context) => const ProfessionScreen(),
        notifications: (context) => const NotificationsScreen(),
        workDetails: (context) => const WorkDetailsScreen(),
        workPublic: (context) => const WorkPublicScreen(),
        consent: (context) => const ConsentScreen(),
        securityData: (context) => const SecurityDataScreen(),
        bolsaWork: (context) => const BolsaWorkScreen(),
        settings: (context) => const SettingsScreen(),
        chatList: (context) => const ChatListScreen(),
        chat: (context) => const ChatScreen(),
      };
}

