// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:untitled1/appcubit/appcubit.dart';
import 'package:untitled1/appcubit/appstates.dart';
import 'package:untitled1/screen/add.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<homeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (builder) => add()),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.orange,
          ),
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Text(
                // ignore: unnecessary_string_interpolations
                "${homeCubit.get(context).Title[homeCubit.get(context).currentIndex]}"),
                // centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    homeCubit.get(context).changemode();
                  },
                  icon: Icon(
                    Icons.dark_mode_rounded,
                    color: Colors.white,
                  ))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Colors.white,
            fixedColor: Colors.orange,
            currentIndex: homeCubit.get(context).currentIndex,
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "الرئيسيه",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payment),
                label: "فواتيرك",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "البروفايل"),
            ],
            onTap: (i) {
              homeCubit.get(context).changeIcon(i);
            },
          ),
          body: homeCubit
              .get(context)
              .Screens[homeCubit.get(context).currentIndex],
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
