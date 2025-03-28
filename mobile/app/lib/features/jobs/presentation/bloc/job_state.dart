part of 'job_bloc.dart';

abstract class JobState extends Equatable {
  const JobState();
  
  @override
  List<Object?> get props => [];
}

class JobInitial extends JobState {}

class JobLoading extends JobState {}

class JobsLoaded extends JobState {
  final List<Job> jobs;

  const JobsLoaded(this.jobs);

  @override
  List<Object?> get props => [jobs];
}

class JobLoaded extends JobState {
  final Job job;

  const JobLoaded(this.job);

  @override
  List<Object?> get props => [job];
}

class JobCreated extends JobState {
  final Job job;

  const JobCreated(this.job);

  @override
  List<Object?> get props => [job];
}

class JobUpdated extends JobState {
  final Job job;

  const JobUpdated(this.job);

  @override
  List<Object?> get props => [job];
}

class JobDeleted extends JobState {}

class JobError extends JobState {
  final String message;

  const JobError(this.message);

  @override
  List<Object?> get props => [message];
}

