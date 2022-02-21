import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/helpers/methods.dart';

import '../app_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    var nameController = TextEditingController();
    return BlocConsumer<AppCubit, AppState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    MyHeightSizedBox(x: 50),
                    TextFormField(
                      onFieldSubmitted: (value) {
                        cubit.getWoeId(
                          city: value.toString(),
                        );
                        nameController.clear();
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'enter city name',
                        //labelText: 'enter city name ',
                        labelStyle: const TextStyle(
                          color: Colors.blue,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    MyHeightSizedBox(x: 30),
                    if (state is GetWeatherLoadingState ||
                        state is GetIdLoadingState)
                      const LinearProgressIndicator(
                        color: Colors.white,
                      ),
                    if (state is GetWeatherSuccessState)
                      Column(
                        children: [
                          MyText(
                            text: 'Temperature',
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                          MyHeightSizedBox(x: 15),
                          MyText(
                              text: cubit.theTemp!.roundToDouble().toString(),
                              fontSize: 25),
                          MyHeightSizedBox(x: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  MyText(
                                    text: 'Mini Temp',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  MyHeightSizedBox(x: 15),
                                  MyText(
                                    text: cubit.minTemp!
                                        .roundToDouble()
                                        .toString(),
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  MyText(
                                    text: 'Max Temp',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  MyHeightSizedBox(x: 15),
                                  MyText(
                                      text: cubit.maxTemp!
                                          .roundToDouble()
                                          .toString(),
                                      fontSize: 18),
                                ],
                              ),
                            ],
                          ),
                          MyHeightSizedBox(x: 30),
                          if (cubit.theTemp! > 26)
                            Column(
                              children: [
                                const Icon(
                                  Icons.wb_sunny,
                                  size: 150,
                                  color: Colors.yellowAccent,
                                ),
                                MyHeightSizedBox(x: 15),
                                MyText(text: cubit.stateName, fontSize: 30)
                              ],
                            ),
                          if (cubit.theTemp! < 22)
                            Column(
                              children: [
                                const Icon(
                                  Icons.cloud,
                                  size: 150,
                                  color: Colors.white,
                                ),
                                MyHeightSizedBox(x: 15),
                                MyText(text: cubit.stateName, fontSize: 30)
                              ],
                            ),
                          MyHeightSizedBox(x: 30),
                          MyText(
                            text: cubit.date,
                            fontSize: 30,
                          ),
                        ],
                      ) ,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
