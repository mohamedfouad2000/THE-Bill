import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:untitled1/appcubit/appcubit.dart';
import 'package:untitled1/appcubit/appstates.dart';
import 'package:untitled1/home.dart';
import 'package:untitled1/shared/cashehelber.dart';
import 'package:untitled1/shared/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class startpage extends StatelessWidget {
  const startpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var NameController = TextEditingController();
    var NumberController = TextEditingController();
    var organController = TextEditingController();
    var formkey = GlobalKey<FormState>();
    // homeCubit()..createData();

    return BlocConsumer<homeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
              // title: Text("مرحبا"),
              ),
          body: SingleChildScrollView(
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(children: [
                    Text(
                      "مرحبا بك برجاء تسجيل بياناتك ",
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(
                      height: 15,
                    ),
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
                    Container(
                        width: double.infinity,
                        color: Theme.of(context).backgroundColor,
                        child: TextButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                homeCubit
                                    .get(context)
                                    .insertuser(
                                        name: NameController.text,
                                        organ: organController.text,
                                        mobile: NumberController.text)
                                    .then((value) {
                                  casheHelber
                                      .putBool(key: "start", value: true)
                                      .then((value) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => home()),
                                        (route) => false);
                                  });
                                });
                              }
                            },
                            child: Text(
                              "دخول",
                              style: TextStyle(color: Colors.white),
                            ))),
                  ]),
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
