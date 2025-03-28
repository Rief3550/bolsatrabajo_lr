import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  final bool isDarkMode;
  final bool enableNotifications;
  final String language;
  final bool enableLocationServices;

  const Settings({
    required this.isDarkMode,
    required this.enableNotifications,
    required this.language,
    required this.enableLocationServices,
  });

  Settings copyWith({
    bool? isDarkMode,
    bool? enableNotifications,
    String? language,
    bool? enableLocationServices,
  }) {
    return Settings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      enableNotifications: enableNotifications ?? this.enableNotifications,
      language: language ?? this.language,
      enableLocationServices: enableLocationServices ?? this.enableLocationServices,
    );
  }

  @override
  List<Object?> get props => [
    isDarkMode,
    enableNotifications,
    language,
    enableLocationServices,
  ];
}

