import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'controller.dart';

void main() {
  runApp(
      const GetMaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Controller();
    Get.put(controller);
    Timer.periodic(const Duration(seconds: 1), (time) {
      controller.switchIcon();
    });

    return AdaptiveTheme(
      light: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lime)
            .copyWith(secondary: Colors.amber),
      ),
      dark: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)
            .copyWith(secondary: Colors.amber),
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        home: _MyHomePage(),
      ),
    );
  }
}

class _MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.find();

    final icons = [
      Triple(Icons.ac_unit, Colors.blue, Colors.lightBlue),
      Triple(Icons.wb_sunny, Colors.orange, Colors.orangeAccent),
      Triple(Icons.nature, Colors.green, Colors.greenAccent),
      Triple(Icons.water, Colors.grey, Colors.blueGrey),
    ];

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Obx(() {
                var icon = icons[controller.icon.value];
                return Icon(
                  icon.data,
                  color: Colors.white,
                )
                    .padding(all: 10)
                    .decorated(
                        color: icon.inner.withAlpha(200),
                        shape: BoxShape.circle)
                    .padding(all: 20)
                    .decorated(
                        color: icon.outer.withAlpha(200),
                        shape: BoxShape.circle);
              }),
            ),
            Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FormBuilderTextField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: "Email is required."),
                          FormBuilderValidators.email(context,
                              errorText: "Not a valid email address."),
                        ]),
                        style: const TextStyle(color: Colors.white),
                        name: "email",
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.white54),
                            hintText: "email",
                            filled: true,
                            fillColor: Colors.white38,
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.amber,
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.lime, width: 0.5),
                                borderRadius: BorderRadius.all(
                                    Radius.elliptical(10, 10)))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FormBuilderTextField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: "Password is required."),
                          FormBuilderValidators.minLength(context, 6,
                              errorText:
                                  "Password needs to be at least 6 characters long."),
                        ]),
                        name: "password",
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.white54),
                            hintText: "password",
                            filled: true,
                            fillColor: Colors.white38,
                            prefixIcon: Icon(
                              Icons.password_outlined,
                              color: Colors.amber,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.elliptical(10, 10)))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.login),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, top: 5, bottom: 5),
                                  child: Text('Login'))
                            ]),
                        onPressed: () {},
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(const BorderSide(
                                color: Colors.lime, width: 0.5)),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.lime),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black12),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(10)),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
