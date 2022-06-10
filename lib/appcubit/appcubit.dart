import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/appcubit/appstates.dart';
import 'package:untitled1/model/products.dart';
import 'package:untitled1/screen/add.dart';
import 'package:untitled1/screen/collection.dart';
import 'package:untitled1/screen/h.dart';
import 'package:untitled1/screen/profile.dart';
import 'package:untitled1/shared/cashehelber.dart';
import 'package:untitled1/shared/components.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class homeCubit extends Cubit<HomeStates> {
  homeCubit() : super(init());
  static homeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  String text = "";
  Future<void> addtext({
    required String name,
    required String number,
    required String date,
  }) async {
    text = '''
اسم العميل :sadasd   
رقم العميل : sdfsdgsdfsdf
اليوم : 445456456456456
 ''';
  }

  void changeIcon(index) {
    currentIndex = index;
    emit(ChangeNavIndex());
  }

  List<Widget> Screens = [h(), collection(), profile()];
  List<String> Title = [
    'الرئيسيه',
    'فواتيرك',
    'البروفايل',
    // '',
  ];
  Database? database;

  void changemode() {
    dark = !dark;
    casheHelber.putBool(key: "dark", value: dark);
    print(dark);
    emit(changemodeapp());
  }

  List<Map>? pro = [];
  void createData() {
    openDatabase(
      "path",
      version: 1,
      onCreate: (database, version) {
        print("Data Base Create");
        database
            .execute(
                'CREATE TABLE p (id INTEGER PRIMARY KEY, name TEXT, data TEXT, product TEXT,mobile TEXT,price TEXT ,numberofp TEXT)')
            .then((value) {
          database
              .execute(
                  'CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT,mobile TEXT,organ TEXT ,logo TEXT)')
              .then((value) => print("table Create"));
        }).catchError((Error) {
          print(Error);
        });
      },
      onOpen: (database) {
        // getdata(database);
        // getuser(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBase());
    });
  }

  Future<void> insertData({
    required String name,
    required String data,
    required String mobile,

    // required double price,
  }) async {
    print(products);
    print("siu");
    await database!.transaction((txn) async {
      txn
          .rawInsert(
              "INSERT INTO p (name, data,mobile,product,price,numberofp) VALUES('$name','$data','$mobile','$products','$price','${products.length}')")
          .then((value) {
        print("$value succes");
        emit(AppInsertInDataBase());
        // getData(database);
      }).catchError((onError) {
        emit(AppInsertInDataBaseeroor());
      });
    });
  }

  Future<void> updateData({
    database,
    required String name,
    required String data,
    required String mobile,
    // required pr,
    required var id,
  }) async {
    database!.rawUpdate(
        'UPDATE p SET product = ?,name= ?,data= ?,mobile= ?,price=? ,numberofp= ? WHERE id = ?',
        [
          '$products',
          '$name',
          '$data',
          '$mobile',
          '$price1',
          "${products.length}",
          '$id'
        ]).then((value) {
      getdata(database);
      emit(AppUpdatDataBase());
    });
  }

  void getdata(database) {
    pro = [];
    emit(getdataloading());
    database!.rawQuery("SELECT * FROM p").then((value) {
      pro = value;
      emit(getdatasucc());
    });
  }

  void DeleteData({
    @required var id,
  }) async {
    database!.rawDelete('DELETE FROM p WHERE id = ?', ['$id']).then((value) {
      print("done is Tamam");
      getdata(database);
      emit(AppUpdatDataBase());
    }).catchError((onError) {
      print(onError);
    });

    print("siu");
  }

  List<Map<String, String>> products = [];

  Future<void> addpro(
      {required String name, required amount, required price}) async {
    // emit(addproloading());
    print(name);
    print(amount);
    print(price);

    products.add({
      '"pro"': '"${name}"',
      '"num"': "${amount}",
      '"price"': '${price}',
    });
    emit(addprosucc());
  }

  double price = 0;
  getprice() {
    emit(getpriceloading());
    price = 0;
    products.forEach((element) {
      var z = element['"price"'];
      var x = element['"num"'];
      price += int.parse(z!) * int.parse(x!);

      // print(int.parse(z) * int.parse(x));
    });
    print(price);
    emit(getpricesucc());
  }

  void removeIteam({required int index}) {
    emit(removeIteamloading());
    products.removeAt(index);
    emit(removeIteamsucc());
    getprice();
  }

  void removeIteam1({required int index}) {
    emit(removeIteamloading());
    s.removeAt(index);
    emit(removeIteamsucc());
    getprice1();
  }

  List<productss> s = [];
  void pro_edit({required String model}) {
    s = [];
    String num;
    String price;
    List dynamicMapFromJson = json.decode(model);
    dynamicMapFromJson.forEach((element) {
      s.add(productss.fromJson(element));
    });

    print(s.length);
  }

  Future<void> update_s(
      {required String name, required amount, required price}) async {
    int a = int.parse(amount);
    int b = int.parse(price);

    emit(getpriceloading());
    s.add(productss(pro: name, num: a, price: b));
    emit(getpricesucc());
  }

  Future<void> format_S_To_list() async {
    products = [];

    s.forEach((element) {
      products.add({
        '"pro"': '"${element.pro}"',
        '"num"': "${element.num}",
        '"price"': '${element.price}',
      });
    });
  }

  double price1 = 0;
  getprice1() {
    emit(getpriceloading());
    price1 = 0;
    s.forEach((element) {
      var z = element.price;
      var x = element.num;
      var r = z! * x!;
      price1 += r;

      // print(int.parse(z) * int.parse(x));
    });
    print(price1);
    emit(getpricesucc());
  }

  //  'CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT,mobile TEXT,organ TEXT ,logo TEXT)');

  Future<void> insertuser({
    required String name,
    required String organ,
    required String mobile,
    String logo =
        'https://cdn.dribbble.com/users/3028563/screenshots/17652849/media/a786e40bccabd30d4113bfd36cd1200d.jpg?compress=1&resize=400x300',

    // required double price,
  }) async {
    // print(products);
    print("siu");
    await database!.transaction((txn) async {
      txn
          .rawInsert(
              "INSERT INTO user (name,mobile,organ,logo) VALUES('$name','$mobile','$organ','$logo')")
          .then((value) {
        print("INSERT Done ya user");
        print("$value succes");
        print("aha");
        emit(AppInsertInDataBase());
        // getData(database);
      }).catchError((onError) {
        emit(AppInsertInDataBaseeroor());
      });
    });
  }

  Future<void> updateuser({
    database,
    required String name,
    required String mobile,
    required String organ,
    // required String logo,

    // required pr,
    var id = 1,
  }) async {
    database!.rawUpdate(
        'UPDATE user SET name= ?,mobile= ?,organ= ?  WHERE id = ?',
        ['$name', '$mobile', '$organ', '$id']).then((value) {
      getuser(database);
      emit(AppUpdatDataBase());
    });
  }

  List<Map>? user;
  void getuser(database) {
    user = [];
    emit(getdataloading());
    database?.rawQuery("SELECT * FROM user").then((value) {
      print("aha");
      // pro = value;
      print(value);
      user = value;
      print("object");
      print(user);
    }).then((value) {
      emit(getdatasucc());
    });
  }
}
