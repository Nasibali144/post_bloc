import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:post_bloc/Application/Home/Bloc/home_bloc.dart';
import 'package:post_bloc/Configuration/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(HomePostGetEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts Bloc"),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeDeleteSuccessState) {
            Utils.fireSnackBar("Post successfully deleted!", context);
          }

          if (state is HomeErrorState) {
            Utils.fireSnackBar("Something error, please try again!", context);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: UniqueKey(),
                    startActionPane: ActionPane(
                      extentRatio: 0.25,
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {},
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          icon: Icons.update,
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      extentRatio: 0.25,
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            context
                                .read<HomeBloc>()
                                .add(
                                HomePostDeleteEvent(state.items[index].id));
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete_outline,
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          state.items[index].title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          state.items[index].body,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              if(state.isLoading) const Center(
                child: CircularProgressIndicator(),
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HomeBloc>().add(HomeCreatePostEvent(context));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
