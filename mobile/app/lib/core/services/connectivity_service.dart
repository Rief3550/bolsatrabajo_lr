import 'dart:async';

abstract class ConnectivityService {
  Future<bool> get isConnected;
  Stream<bool> get connectivityStream;
  void dispose();
}

class ConnectivityServiceImpl implements ConnectivityService {
  final StreamController<bool> _connectivityStreamController = StreamController<bool>.broadcast();
  bool _isConnected = true;

  ConnectivityServiceImpl() {
    // En una implementación real, aquí se inicializaría la escucha de cambios de conectividad
    // usando el paquete connectivity_plus
    _init();
  }

  void _init() async {
    // Simulación de conectividad para desarrollo
    _isConnected = true;
    _connectivityStreamController.add(_isConnected);
  }

  @override
  Future<bool> get isConnected async => _isConnected;

  @override
  Stream<bool> get connectivityStream => _connectivityStreamController.stream;

  @override
  void dispose() {
    _connectivityStreamController.close();
  }
}

