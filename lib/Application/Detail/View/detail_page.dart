import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_bloc/Application/Detail/Bloc/detail_bloc.dart';
import 'package:post_bloc/Configuration/utils.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailBloc(),
      child: Builder(
          builder: (context) {
            var bloc = context.read<DetailBloc>();
            return BlocListener<DetailBloc, DetailState>(
              listener: (context, state) {
                if(state is DetailSuccessState) {
                  Utils.fireSnackBar(state.successMessage, context);
                  Navigator.pop(context, "refresh");
                }

                if(state is DetailErrorState) {
                  Utils.fireSnackBar(state.errorMessage, context);
                }
              },
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text("Detail Page"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        bloc.add(DetailSaveEvent());
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 19),),
                    ),
                  ],
                ),
                body: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: bloc.titleController,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                                hintText: "Title"
                            ),
                          ),

                          const SizedBox(height: 15,),

                          TextField(
                            controller: bloc.bodyController,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                                hintText: "Body"
                            ),
                          ),
                        ],
                      ),
                    ),

                    BlocBuilder<DetailBloc, DetailState>(
                      // buildWhen: (oldState, newState) {
                      //   return newState is DetailInitialState;
                      // },
                      builder: (context, state) {
                        if(state is DetailInitialState && state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
