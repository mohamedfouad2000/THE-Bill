// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_application_6/appcubit/appcubit.dart';
// import 'package:flutter_application_6/appcubit/appstates.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class add extends StatelessWidget {
//   // const add({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<homeCubit, HomeStates>(
//       builder: (BuildContext context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.orange,
//           ),
//           body: Text("سي "),
//         );
//       },
//       listener: (BuildContext context, Object? state) {},
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:untitled1/appcubit/appcubit.dart';
import 'package:untitled1/appcubit/appstates.dart';
import 'package:untitled1/home.dart';
import 'package:untitled1/screen/pdf.dart';
import 'package:untitled1/share.dart';
import 'package:untitled1/shared/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:untitled1/shared/pdfbill.dart';

class add extends StatelessWidget {
  // const add({Key? key}) : super(key: key);
  var NameController = TextEditingController();
  var NumberController = TextEditingController();
  var dateController = TextEditingController();
  var addkey = GlobalKey<FormState>();
  var formkey = GlobalKey<FormState>();

  var nameofproduectController = TextEditingController();
  var amountController = TextEditingController();
  var priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return homeCubit()..createData();
      },
      child: BlocConsumer<homeCubit, HomeStates>(
        builder: (BuildContext context, state) {
          // homeCubit.get(context).products = [];
          var date = new DateTime.now().toString();

          var dateParse = DateTime.parse(date);

          var formattedDate =
              "${dateParse.day}-${dateParse.month}-${dateParse.year}";
          dateController.text = formattedDate.toString();

          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.orange,
                title: Text("اضافه "),
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                      lable: "اسم العميل"),
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
                                      Con: dateController,
                                      enable: false,
                                      lable: "تاريخ اليوم"

                                      // val: "  ",
                                      ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Card(
                            elevation: 8,
                            // color: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      nameofproduectController.text = "";
                                      amountController.text = "";
                                      priceController.text = "";
                                      var x = AlertDialog(
                                        title: Text(
                                          "  اضافه الصنف",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .backgroundColor),
                                        ),
                                        insetPadding: EdgeInsets.all(20),
                                        content: Form(
                                          key: addkey,
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  // insetPadding: EdgeInsets.zero,
                                                  width: 400,
                                                  // height: 400,
                                                  // width: double.infinity,
                                                  child: Column(
                                                    children: [
                                                      TextForm(
                                                          Con:
                                                              nameofproduectController,
                                                          // type: TextInputType.number,
                                                          // val:
                                                          //     "من فضلك ادخل رقم الهاتف الخاص بك  ",
                                                          lable: "اسم الصنف ",
                                                          val:
                                                              "من فضلك ادخل اسم الصنف"),
                                                      // ignore: prefer_const_constructors
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextForm(
                                                          Con: amountController,
                                                          type: TextInputType
                                                              .number,
                                                          // val:
                                                          //     "من فضلك ادخل رقم الهاتف الخاص بك  ",
                                                          lable: "الكميه ",
                                                          val:
                                                              "من فضلك ادخل الكميه"),
                                                      // ignore: prefer_const_constructors
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextForm(
                                                          Con: priceController,
                                                          type: TextInputType
                                                              .number,
                                                          // val:
                                                          //     "من فضلك ادخل رقم الهاتف الخاص بك  ",
                                                          lable: "السعر ",
                                                          val:
                                                              "من فضلك ادخل السعر"),
                                                      // ignore: prefer_const_constructors
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        color: Colors.orange,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            if (addkey
                                                                .currentState!
                                                                .validate()) {
                                                              homeCubit
                                                                  .get(context)
                                                                  .addpro(
                                                                      price: priceController
                                                                          .text,
                                                                      name: nameofproduectController
                                                                          .text,
                                                                      amount: amountController
                                                                          .text)
                                                                  .then(
                                                                      (value) {
                                                                homeCubit
                                                                    .get(
                                                                        context)
                                                                    .getprice();
                                                                Navigator.pop(
                                                                    context);
                                                              });

                                                              //     proName: "proName",
                                                              //     number: "12345",
                                                              //     mobile: "020303",
                                                              //     name: "name",
                                                              //     data: "17/6/2000");
                                                              print(
                                                                  priceController
                                                                      .text);
                                                              print(
                                                                  nameofproduectController
                                                                      .text);
                                                              print(
                                                                  amountController
                                                                      .text);
                                                            }
                                                          },
                                                          child: Text(
                                                            "اضافه",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          ),
                                        ),
                                      );
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              child: x,
                                            );
                                          });
                                    },
                                    child: Text(
                                      "اضافه صنف",
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      if (homeCubit
                                          .get(context)
                                          .products
                                          .isNotEmpty)
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Title(
                                                  color: Colors.orange,
                                                  child: Text(
                                                    "الصنف",
                                                  )),
                                            ),
                                            Expanded(
                                              child: Title(
                                                  color: Colors.orange,
                                                  child: Text("الكميه")),
                                            ),
                                            Expanded(
                                              child: Title(
                                                  color: Colors.orange,
                                                  child: Text("سعرالوحده")),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Title(
                                                    color: Colors.orange,
                                                    child: Text("الاجمالي")),
                                              ),
                                            ),
                                            Expanded(
                                              child: Title(
                                                  color: Colors.orange,
                                                  child: Text("")),
                                            ),
                                          ],
                                        ),
                                      if (homeCubit.get(context).products !=
                                          null)
                                        SingleChildScrollView(
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            primary: false,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return prod(
                                                  homeCubit
                                                      .get(context)
                                                      .products[index],
                                                  index,
                                                  context);
                                            },
                                            itemCount: homeCubit
                                                        .get(context)
                                                        .products !=
                                                    null
                                                ? homeCubit
                                                    .get(context)
                                                    .products
                                                    .length
                                                : 1,
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return Container(
                                                height: 1,
                                                width: double.infinity,
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                              );
                                            },
                                          ),
                                        ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      if (homeCubit.get(context).products.isNotEmpty)
                        Card(
                          elevation: 8,
                          // color: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Title(
                                        color: Colors.orange,
                                        child: Text(
                                          "عدد الاصناف ",
                                        )),
                                  ),
                                  Expanded(
                                    child: Title(
                                        color: Colors.orange,
                                        child: Text(
                                            "${homeCubit.get(context).products.length}")),
                                  ),
                                  Expanded(
                                    child: Title(
                                        color: Colors.orange,
                                        child: Text("السعر الاجمالي")),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Title(
                                          color: Colors.orange,
                                          child: Text(
                                              "${homeCubit.get(context).price} جنيه")),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                        onPressed: () async {
                                          String s = '';
                                          homeCubit
                                              .get(context)
                                              .products
                                              .forEach((element) {
                                            String x = '';
                                            x = 'المنتج : ${element['"pro"']} : العدد : ${element['"num"']} : سعر القطعه  ${element['"price"']} السعر : ${double.parse('${element['"price"']}') * double.parse('${element['"num"']} ')} ';
                                            s = s + '$x \n';
                                          });
                                          String paragraphText =
                                              'الاسم : ${NameController.text} \n'
                                              'رقم الهاتف  : ${NumberController.text} \n'
                                              'التاريخ   : ${dateController.text} \n'
                                              '$s \n'
                                              'السعر الكلــي : ${homeCubit.get(context).price}';

                                          if (formkey.currentState!
                                              .validate()) {
                                            await Share.share(
                                              "$paragraphText",
                                              subject: "hewa ",
                                            );
                                          }
                                        },
                                        child: Text("ارسال")),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                        onPressed: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            homeCubit
                                                .get(context)
                                                .insertData(
                                                    data: dateController.text,
                                                    mobile:
                                                        NumberController.text,
                                                    name: NameController.text)
                                                .then((value) {
                                              // ShowToastFun(
                                              //     msg: "تم الحفظ",
                                              //     Sort: toaststate.success);
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (builder) =>
                                                          home()),
                                                  (route) => false);
                                            });
                                          }
                                        },
                                        child: Text("حفظ")),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                        onPressed: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            convertTolist(context,
                                                date: dateController.text,
                                                mobile: NumberController.text,
                                                name: NameController.text);
                                          }
                                        },
                                        child: Text("اجعله مستند")),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ));
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }

  Widget prod(Map model, index, context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Text(
                  "${model['"pro"'].toString().substring(1, model['"pro"'].length - 1)}  ")),
          Expanded(child: Text("${model['"num"']} ")),
          Expanded(child: Text("${model['"price"']} جنيه")),
          Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                    "${int.parse(model['"price"']) * int.parse(model['"num"'])} جنيه")),
          ),
          Expanded(
              child: TextButton(
                  onPressed: () {
                    homeCubit.get(context).removeIteam(index: index);
                  },
                  child: Text("حـذف"))),
        ],
      );

  convertTolist(
    context, {
    required String name,
    required String mobile,
    required String date,
  }) async {
    var data = <Map<String, String>>[
      for (int i = 0; i < homeCubit.get(context).products.length; i++)
        {
          "pro":
              "${homeCubit.get(context).products[i]['"pro"'].toString().substring(1, homeCubit.get(context).products[i]['"pro"'].toString().length - 1)}",
          "num": "${homeCubit.get(context).products[i]['"num"']}",
          "price": "${homeCubit.get(context).products[i]['"price"']}",
          "allprice":
              "${double.parse('${homeCubit.get(context).products[i]['"price"']} ') * double.parse('${homeCubit.get(context).products[i]['"num"']} ')}",
        },
    ];

    List<List<String>> listOfPurchases = [];
    for (int i = 0; i < data.length; i++) {
      listOfPurchases.add(data[i].values.toList());
    }
    print('siu siu siu  $listOfPurchases');
    var pdf = await pdfBill.generatePdf(
        data: listOfPurchases,
        name: name,
        date: date,
        mobile: mobile,
        allprice: homeCubit.get(context).price);
    pdfBill.openfile(pdf);
  }
}
