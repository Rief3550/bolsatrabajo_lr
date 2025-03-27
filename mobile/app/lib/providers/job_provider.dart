import 'package:flutter/material.dart';
import 'package:flutter_job_marketplace/models/job.dart';

class JobProvider extends ChangeNotifier {
  List<Job> _jobs = [];
  bool _isLoading = false;

  List<Job> get jobs => _jobs;
  bool get isLoading => _isLoading;

  JobProvider() {
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, you would fetch jobs from a backend
      // For now, we'll create some mock jobs
      await Future.delayed(const Duration(seconds: 1));

      _jobs = [
        Job(
          id: '1',
          userId: 'user1',
          name: 'Pintura de interior',
          details: 'Pintura de interior de casa, incluye paredes y techo',
          description: 'Se requiere preparación de superficies y aplicación de dos manos de pintura',
          requirements: 'Materiales incluidos, herramientas propias',
          price: 1000,
          type: 'Servicio',
          contract: 'Por proyecto',
          time: '5 días',
          isPeriodic: false,
        ),
        Job(
          id: '2',
          userId: 'user2',
          name: 'Reparación de motor',
          details: 'Reparación de motor diésel 2.0',
          description: 'Diagnóstico y reparación de motor con problemas de arranque',
          requirements: 'Repuestos no incluidos',
          price: 1200,
          type: 'Servicio',
          contract: 'Por proyecto',
          time: '3 días',
          isPeriodic: false,
        ),
        Job(
          id: '3',
          userId: 'user3',
          name: 'Instalación eléctrica',
          details: 'Instalación eléctrica completa para casa',
          description: 'Instalación de cableado, tomacorrientes, interruptores y tablero principal',
          requirements: 'Materiales incluidos',
          price: 1500,
          type: 'Servicio',
          contract: 'Por proyecto',
          time: '7 días',
          isPeriodic: false,
        ),
        Job(
          id: '4',
          userId: 'user4',
          name: 'Diseño de jardín',
          details: 'Diseño y ejecución de jardín para casa',
          description: 'Incluye diseño, preparación de terreno, plantación y sistema de riego',
          requirements: 'Plantas no incluidas',
          price: 2000,
          type: 'Servicio',
          contract: 'Por proyecto',
          time: '10 días',
          isPeriodic: false,
        ),
      ];
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addJob(Job job) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, you would add the job to a backend
      // For now, we'll just add it to the local list
      await Future.delayed(const Duration(seconds: 1));

      _jobs.add(job);
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateJob(Job updatedJob) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, you would update the job in a backend
      // For now, we'll just update it in the local list
      await Future.delayed(const Duration(seconds: 1));

      final index = _jobs.indexWhere((job) => job.id == updatedJob.id);
      if (index != -1) {
        _jobs[index] = updatedJob;
      }
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteJob(String jobId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, you would delete the job from a backend
      // For now, we'll just remove it from the local list
      await Future.delayed(const Duration(seconds: 1));

      _jobs.removeWhere((job) => job.id == jobId);
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Job> getJobsByUserId(String userId) {
    return _jobs.where((job) => job.userId == userId).toList();
  }

  Job? getJobById(String jobId) {
    try {
      return _jobs.firstWhere((job) => job.id == jobId);
    } catch (e) {
      return null;
    }
  }
}

