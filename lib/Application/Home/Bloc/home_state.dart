part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitialState extends HomeState {
  final List<Post> items;
  @override
  List<Object> get props => [items];

  const HomeInitialState(this.items);
}

class HomePostGetState extends HomeState{
  final List<Post> items;

  @override
  List<Object> get props => [items];

  const HomePostGetState(this.items);
}
