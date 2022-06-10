import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:untitled1/appcubit/appcubit.dart';
import 'package:untitled1/appcubit/appstates.dart';
import 'package:untitled1/home.dart';
import 'package:untitled1/screen/editpage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class collection extends StatelessWidget {
  // const collection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(homeCubit.get(context).ge)
    homeCubit.get(context).getdata(homeCubit.get(context).database);

    return BlocConsumer<homeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return BlocConsumer<homeCubit, HomeStates>(
          builder: (BuildContext context, state) {
            return homeCubit.get(context).pro!.isNotEmpty &&
                    state is! getdataloading
                ? ConditionalBuilder(
                    builder: (BuildContext context) {
                      return ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return buldd(
                              homeCubit.get(context).pro![index], context);
                        },
                        itemCount: homeCubit.get(context).pro!.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 1,
                            width: double.infinity,
                          );
                        },
                      );
                    },
                    condition: state is! getdataloading,
                    fallback: (BuildContext context) {
                      return Center(child: CircularProgressIndicator());
                    },
                  )
                : Container(
                    child: Center(
                        child: Text(
                      "لا توجد فواتير لديك ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )),
                  );
          },
          listener: (BuildContext context, Object? state) {},
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  Widget buldd(model, context) => Card(
        elevation: 8,
        // color: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text("اسم العميل "),
                Spacer(),
                Text("${model['name']} "),
                Spacer(),
                Text("التاريخ "),
                Spacer(),
                Text("${model['data']} "),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text("الاجمالي"),
                Spacer(),
                Text("${model['price']} جنيه"),
                Spacer(),
                Text("عدد الاصناف"),
                Spacer(),
                Text("${model['numberofp']}"),
                Spacer(),
                // Text("${model['name']} "),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => edituser(
                                        model: model,
                                      )));
                        },
                        child: Text("تعديل"))),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          homeCubit.get(context).DeleteData(id: model['id']);
                        },
                        child: Text("حذف"))),
              ],
            )
          ],
        ),
      );

}
