import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'api_states.dart';
import 'apis_cubit.dart';

class HomeApis extends StatelessWidget {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  late ApiCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      ApiCubit(ApisInitialState())
        ..getHttp(),
      child: BlocConsumer<ApiCubit, ApisStates>(
        listener: (context, state) {},
        builder: (context, state) {
          cubit = ApiCubit.get(context);
          return Scaffold(
            key: _scaffoldKey,
            appBar: (AppBar(
              title: Text(cubit.title[cubit.position]),
            )),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.biotech), label: cubit.title[0]),
                BottomNavigationBarItem(
                    icon: Icon(Icons.sports), label: cubit.title[1]),
                BottomNavigationBarItem(
                    icon: Icon(Icons.business), label: cubit.title[2]),
              ],
              currentIndex: cubit.position,
              onTap: (value) {
                // setState(() {
                //   _position = value;
                // });
                switch (value) {
                  case 0:
                    {
                      cubit.changeTaskState("TECHNOLOGY NEWS");
                    }
                    break;
                  case 1:
                    {
                      cubit.changeTaskState("SPORTS NEWS");
                    }
                    break;
                  case 2:
                    {
                      cubit.changeTaskState("BUSINESS NEWS");
                    }
                    break;
                }
                cubit.onBottomNavigationChange(value);
              },
            ),
            body: cubit.screen[cubit.position],
          );
        },
      ),
    );
  }
}
