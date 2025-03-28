part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class GetSettingsEvent extends SettingsEvent {}

class UpdateSettingsEvent extends SettingsEvent {
  final Settings settings;

  const UpdateSettingsEvent(this.settings);

  @override
  List<Object> get props => [settings];
}

class ToggleDarkModeEvent extends SettingsEvent {}

class ToggleNotificationsEvent extends SettingsEvent {}

class ChangeLanguageEvent extends SettingsEvent {
  final String language;

  const ChangeLanguageEvent(this.language);

  @override
  List<Object> get props => [language];
}

class ToggleLocationServicesEvent extends SettingsEvent {}

