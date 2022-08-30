part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomePostGetEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomePostDeleteEvent extends HomeEvent {
  final String id;

  @override
  List<Object> get props => [id];

  const HomePostDeleteEvent(this.id);
}

class HomeCreatePostEvent extends HomeEvent {
  final BuildContext context;

  @override
  List<Object> get props => [context];

  const HomeCreatePostEvent(this.context);
}
