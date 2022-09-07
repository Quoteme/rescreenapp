import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(iconTheme: const IconThemeData(size: 64)),
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            iconTheme: const IconThemeData(color: Colors.white, size: 64),
            textTheme: TextTheme(bodyText2: TextStyle(color: Colors.grey))),
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Rescreen settings"),
              actions: [
                FittedBox(child: CloseButton(onPressed: () => exit(0)))
              ],
            ),
            body: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    const FittedBox(child: Text("Extend Monitor: ")),
                    IconButton(
                        onPressed: () => {
                              Process.run("mons", ["-e", "left"])
                            },
                        icon: const Icon(Icons.arrow_circle_left)),
                    IconButton(
                        onPressed: () => {
                              Process.run("mons", ["-e", "top"]),
                            },
                        icon: const Icon(Icons.arrow_circle_up)),
                    IconButton(
                        onPressed: () => {
                              Process.run("mons", ["-e", "bottom"]),
                            },
                        icon: const Icon(Icons.arrow_circle_down)),
                    IconButton(
                        onPressed: () => {
                              Process.run("mons", ["-e", "right"]),
                            },
                        icon: const Icon(Icons.arrow_circle_right)),
                  ],
                ),
                TableRow(
                  children: [
                    const FittedBox(child: Text("Esclusively use:")),
                    IconButton(
                        onPressed: () => {
                              Process.run("mons", ["-o"]),
                            },
                        icon: const Icon(Icons.laptop)),
                    IconButton(
                        onPressed: () => {
                              Process.run("mons", ["-s"]),
                            },
                        icon: const Icon(Icons.monitor)),
                    Container(),
                    Container(),
                  ],
                ),
                TableRow(
                  children: [
                    const FittedBox(child: Text("Mirror/Duplicate:")),
                    IconButton(
                        onPressed: () => {
                              Process.run("mons", ["-m"]),
                            },
                        icon: const Icon(Icons.screen_share)),
                    IconButton(
                        onPressed: () => {
                              Process.run("mons", ["-d"]),
                            },
                        icon: const Icon(Icons.cast)),
                    Container(),
                    Container(),
                  ],
                ),
                // Row(
                //   children: const [Text("Rotation")],
                // )
              ],
            )));
  }
}
