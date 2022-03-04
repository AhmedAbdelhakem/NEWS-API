import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'api_states.dart';
import 'apis_cubit.dart';

class TechScreen extends StatelessWidget {
  late ApiCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApiCubit, ApisStates>(
      listener: (context, state) {},
      builder: (context, state) {
        cubit = ApiCubit.get(context);
        return cubit.articles.isEmpty
            ? buildEmptyDesign()
            : Container(
                padding: EdgeInsets.all(10),
                child: ListView.separated(
                  itemBuilder: (context, index) =>
                      buildTaskItem(cubit.articles[index]),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
                  itemCount: cubit.articles.length,
                ),
              );
      },
    );
  }

  Widget buildEmptyDesign() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Loading",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          CircularProgressIndicator.adaptive(),
        ],
      ),
    );
  }

  Widget buildTaskItem(articale) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.network(articale['urlToImage']),
          Text(
            articale['title'],
            style: TextStyle(
              fontSize: 22,
            ),
          )
        ],
      ),
    );
  }
}
