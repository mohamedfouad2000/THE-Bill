import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:untitled1/appcubit/appcubit.dart';
import 'package:untitled1/appcubit/appstates.dart';
import 'package:untitled1/home.dart';
import 'package:untitled1/shared/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class profile extends StatelessWidget {
  // const h({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    homeCubit.get(context).getuser(homeCubit.get(context).database);
    var NameController = TextEditingController();
    var NumberController = TextEditingController();
    var organController = TextEditingController();
    var formkey = GlobalKey<FormState>();

    return BlocConsumer<homeCubit, HomeStates>(
      builder: (BuildContext context, state) {
      //  homeCubit.get(context).getuser(homeCubit.get(context).database);

        print(homeCubit.get(context).user);

        return ConditionalBuilder(
          condition: state is! getdataloading,
          builder: (BuildContext context) {
            print("user is aha");
            // print(homeCubit.get(context).user?[0]);
            NameController.text = homeCubit.get(context).user?[0]['name'];
            NumberController.text = homeCubit.get(context).user?[0]['mobile'];
            organController.text = homeCubit.get(context).user?[0]['organ'];

            return SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Card(
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            TextForm(
                                Con: NameController,
                                val: "من فضلك ادخل الاسم الخاص بك  ",
                                lable: "الاسم"),
                            SizedBox(
                              height: 15,
                            ),
                            TextForm(
                                Con: NumberController,
                                type: TextInputType.number,
                                val: "من فضلك ادخل رقم الهاتف الخاص بك  ",
                                lable: "رقم الهاتف"),
                            SizedBox(
                              height: 15,
                            ),
                            TextForm(
                                Con: organController,
                                type: TextInputType.text,
                                val: "من فضلك ادخل المؤسسه الخاص بك  ",
                                lable: "المؤسسه"),
                            SizedBox(
                              height: 15,
                            ),
                            TextButton(
                                onPressed: () {
                                  homeCubit
                                      .get(context)
                                      .updateuser(
                                          database:
                                              homeCubit.get(context).database,
                                          id: 1,
                                          name: NameController.text,
                                          mobile: NumberController.text,
                                          organ: organController.text)
                                      .then((value) {
                                    print("done update");
                                    homeCubit.get(context).currentIndex = 0;
                                  });
                                },
                                child: Text("تعديل البيانات "))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        child: Image(
                          image: NetworkImage(
                              'https://cdn.dribbble.com/users/3028563/screenshots/17652849/media/a786e40bccabd30d4113bfd36cd1200d.jpg?compress=1&resize=400x300'
                              ),
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            );
          },
          fallback: (BuildContext context) {
            return Center(child: CircularProgressIndicator());
          },
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
