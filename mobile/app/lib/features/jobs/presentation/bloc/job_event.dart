part of 'job_bloc.dart';

abstract class JobEvent extends Equatable {
  const JobEvent();

  @override
  List<Object> get props => [];
}

class GetJobsEvent extends JobEvent {}

class GetJobByIdEvent extends JobEvent {
  final String id;

  const GetJobByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class CreateJobEvent extends JobEvent {
  final Job job;

  const CreateJobEvent(this.job);

  @override
  List<Object> get props => [job];
}

class UpdateJobEvent extends JobEvent {
  final Job job;

  const UpdateJobEvent(this.job);

  @override
  List<Object> get props => [job];
}

class DeleteJobEvent extends JobEvent {
  final String id;

  const DeleteJobEvent(this.id);

  @override
  List<Object> get props => [id];
}

