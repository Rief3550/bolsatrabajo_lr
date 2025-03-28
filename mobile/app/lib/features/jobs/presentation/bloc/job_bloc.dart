import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_job_marketplace/core/error/failures.dart';
import 'package:flutter_job_marketplace/core/usecases/usecase.dart';
import 'package:flutter_job_marketplace/features/jobs/domain/usecases/create_job.dart';
import 'package:flutter_job_marketplace/features/jobs/domain/usecases/delete_job.dart';
import 'package:flutter_job_marketplace/features/jobs/domain/usecases/get_job_by_id.dart';
import 'package:flutter_job_marketplace/features/jobs/domain/usecases/get_jobs.dart';
import 'package:flutter_job_marketplace/features/jobs/domain/usecases/update_job.dart';
import 'package:flutter_job_marketplace/models/job.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final GetJobs getJobs;
  final GetJobById getJobById;
  final CreateJob createJob;
  final UpdateJob updateJob;
  final DeleteJob deleteJob;

  JobBloc({
    required this.getJobs,
    required this.getJobById,
    required this.createJob,
    required this.updateJob,
    required this.deleteJob,
  }) : super(JobInitial()) {
    on<GetJobsEvent>(_onGetJobs);
    on<GetJobByIdEvent>(_onGetJobById);
    on<CreateJobEvent>(_onCreateJob);
    on<UpdateJobEvent>(_onUpdateJob);
    on<DeleteJobEvent>(_onDeleteJob);
  }

  Future<void> _onGetJobs(
    GetJobsEvent event,
    Emitter<JobState> emit,
  ) async {
    emit(JobLoading());
    
    final result = await getJobs(NoParams());
    
    result.fold(
      (failure) => emit(JobError(failure.message)),
      (jobs) => emit(JobsLoaded(jobs)),
    );
  }

  Future<void> _onGetJobById(
    GetJobByIdEvent event,
    Emitter<JobState> emit,
  ) async {
    emit(JobLoading());
    
    final result = await getJobById(JobParams(id: event.id));
    
    result.fold(
      (failure) => emit(JobError(failure.message)),
      (job) => emit(JobLoaded(job)),
    );
  }

  Future<void> _onCreateJob(
    CreateJobEvent event,
    Emitter<JobState> emit,
  ) async {
    emit(JobLoading());
    
    final result = await createJob(CreateJobParams(job: event.job));
    
    result.fold(
      (failure) => emit(JobError(failure.message)),
      (job) => emit(JobCreated(job)),
    );
  }

  Future<void> _onUpdateJob(
    UpdateJobEvent event,
    Emitter<JobState> emit,
  ) async {
    emit(JobLoading());
    
    final result = await updateJob(UpdateJobParams(job: event.job));
    
    result.fold(
      (failure) => emit(JobError(failure.message)),
      (job) => emit(JobUpdated(job)),
    );
  }

  Future<void> _onDeleteJob(
    DeleteJobEvent event,
    Emitter<JobState> emit,
  ) async {
    emit(JobLoading());
    
    final result = await deleteJob(DeleteJobParams(id: event.id));
    
    result.fold(
      (failure) => emit(JobError(failure.message)),
      (success) => emit(JobDeleted()),
    );
  }
}

