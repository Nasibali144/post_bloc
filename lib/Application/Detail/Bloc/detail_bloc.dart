import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:post_bloc/Domain/post_repository.dart';
part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {

  PostRepository postRepository = PostRepository.instance;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  DetailBloc() : super(const DetailInitialState(false)) {
    on<DetailSaveEvent>(_getPosts);
  }

  Future<void> _getPosts(DetailSaveEvent event, Emitter<DetailState> emit) async {
    String title = titleController.text.trim();
    String body = bodyController.text.trim();

    if(title.isEmpty || body.isEmpty) {
      emit(const DetailErrorState("All fields are required!!!"));
      return;
    }

    emit(const DetailInitialState(true));

    var result = await postRepository.createPost(title, body, 1);

    if(result) {
      emit(const DetailSuccessState("Post successfully created!"));
    } else {
      emit(const DetailErrorState("Post wasn't created!"));
    }
  }
}
