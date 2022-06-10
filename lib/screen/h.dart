import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:untitled1/appcubit/appcubit.dart';
import 'package:untitled1/appcubit/appstates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class h extends StatelessWidget {
  // const h({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<homeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return Align(
          // alignment:AlignmentDirectional.topStart ,
          child: Padding(
            padding: const EdgeInsets.only(right: 12, left: 12),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("مرحبا ",
                    style: TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Text('${homeCubit.get(context).user?[0]['name'].toString()}',
                        style: TextStyle(fontSize: 20)),
                         Spacer(),
                    Container(
                        width: 70,
                        height: 80,
                        child: Image(
                            image: NetworkImage(
                                'https://cdn.dribbble.com/users/3028563/screenshots/17652849/media/a786e40bccabd30d4113bfd36cd1200d.jpg?compress=1&resize=400x300'))),
                 
                  ],
                ),
              
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
