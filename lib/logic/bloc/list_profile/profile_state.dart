part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ListProfileInitial extends ProfileState {}

class ProfileStateLoading extends ProfileState {}

class ListProfileStateSuccess extends ProfileState {
  final Data data;
  ListProfileStateSuccess(this.data);
  @override
  List<Object> get props => [this.data];
}

class ListProfileStateFailed extends ProfileState {
  final ExceptionModel data;
  ListProfileStateFailed(this.data);
  @override
  List<Object> get props => [this.data];
}
