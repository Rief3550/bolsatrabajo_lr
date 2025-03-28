import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/settings/domain/entities/settings.dart';
import 'package:flutter_job_marketplace/features/settings/domain/usecases/get_settings.dart';
import 'package:flutter_job_marketplace/features/settings/domain/usecases/update_settings.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettings getSettings;
  final UpdateSettings updateSettings;

  SettingsBloc({
    required this.getSettings,
    required this.updateSettings,
  }) : super(SettingsInitial()) {
    on<GetSettingsEvent>(_onGetSettings);
    on<UpdateSettingsEvent>(_onUpdateSettings);
    on<ToggleDarkModeEvent>(_onToggleDarkMode);
    on<ToggleNotificationsEvent>(_onToggleNotifications);
    on<ChangeLanguageEvent>(_onChangeLanguage);
    on<ToggleLocationServicesEvent>(_onToggleLocationServices);
  }

  Future<void> _onGetSettings(
    GetSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());
    
    final result = await getSettings(const NoParams());
    
    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (settings) => emit(SettingsLoaded(settings)),
    );
  }

  Future<void> _onUpdateSettings(
    UpdateSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());
    
    final result = await updateSettings(UpdateSettingsParams(settings: event.settings));
    
    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (success) => emit(SettingsLoaded(event.settings)),
    );
  }

  Future<void> _onToggleDarkMode(
    ToggleDarkModeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final currentState = state;
    if (currentState is SettingsLoaded) {
      final updatedSettings = currentState.settings.copyWith(
        isDarkMode: !currentState.settings.isDarkMode,
      );
      
      add(UpdateSettingsEvent(updatedSettings));
    }
  }

  Future<void> _onToggleNotifications(
    ToggleNotificationsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final currentState = state;
    if (currentState is SettingsLoaded) {
      final updatedSettings = currentState.settings.copyWith(
        enableNotifications: !currentState.settings.enableNotifications,
      );
      
      add(UpdateSettingsEvent(updatedSettings));
    }
  }

  Future<void> _onChangeLanguage(
    ChangeLanguageEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final currentState = state;
    if (currentState is SettingsLoaded) {
      final updatedSettings = currentState.settings.copyWith(
        language: event.language,
      );
      
      add(UpdateSettingsEvent(updatedSettings));
    }
  }

  Future<void> _onToggleLocationServices(
    ToggleLocationServicesEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final currentState = state;
    if (currentState is SettingsLoaded) {
      final updatedSettings = currentState.settings.copyWith(
        enableLocationServices: !currentState.settings.enableLocationServices,
      );
      
      add(UpdateSettingsEvent(updatedSettings));
    }
  }
}

