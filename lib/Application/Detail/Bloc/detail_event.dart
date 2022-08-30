part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class DetailSaveEvent extends DetailEvent {
  @override
  List<Object?> get props => [];
}
