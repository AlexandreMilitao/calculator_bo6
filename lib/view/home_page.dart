import 'package:calculator_bo6/controller/calculator.dart';
import 'package:calculator_bo6/data/photo_with_value.dart';
import 'package:calculator_bo6/model/photo_with_value.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<PhotoWithValue> photosWithValues = DataPhoto().photosWithValues;
  final Calculator calculator = Calculator();
  String? selectedVariable;
  PhotoWithValue? selectedPhoto;

  @override
  void initState() {
    super.initState();
  }

  void showPhotoSeletor(String variable) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return GridView.builder(
          padding: EdgeInsets.all(10.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10,
          ),
          itemCount: photosWithValues.length,
          itemBuilder: (BuildContext context, int index) {
            final photoWithValue = photosWithValues[index];
            return GestureDetector(
              onTap: () {
                setState(
                  () {
                    selectedPhoto = photoWithValue;
                    if (variable == "x") {
                      calculator.vM.x = photoWithValue.value;
                    } else if (variable == "y") {
                      calculator.vM.y = photoWithValue.value;
                    } else {
                      calculator.vM.z = photoWithValue.value;
                    }
                  },
                );
                Navigator.pop(context);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.w),
                child: Image.asset(
                  photoWithValue.photoPath,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      },
    );
  }

  void clearValues() {
    setState(() {
      calculator.clearValues();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    if (kDebugMode) {
      WakelockPlus.enable();
    }
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/gura.jpg",
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    children: [
                      Text(
                        "Calculadora Terminus BO6",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: theme.displayLarge?.fontSize,
                          color: theme.titleLarge?.color,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showPhotoSeletor("x");
                        },
                        child: Text(
                          "Tap to Select X = ${calculator.vM.x}",
                          style: TextStyle(
                            fontSize: theme.bodyLarge?.fontSize,
                            color: theme.bodyLarge?.color,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showPhotoSeletor("y");
                        },
                        child: Text(
                          "Tap to Select Y = ${calculator.vM.y}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: theme.bodyLarge?.fontSize,
                            color: theme.bodyLarge?.color,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showPhotoSeletor("z");
                        },
                        child: Text(
                          "Tap to Select Z = ${calculator.vM.z}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: theme.bodyLarge?.fontSize,
                            color: theme.bodyLarge?.color,
                          ),
                        ),
                      ),
                      Text(
                        "1 = ${calculator.vM.res1}",
                        style: TextStyle(
                          fontSize: theme.bodyLarge?.fontSize,
                          color: theme.bodyLarge?.color,
                        ),
                      ),
                      Text(
                        "2 = ${calculator.vM.res2}",
                        style: TextStyle(
                          fontSize: theme.bodyLarge?.fontSize,
                          color: theme.bodyLarge?.color,
                        ),
                      ),
                      Text(
                        "3 = ${calculator.vM.res3}",
                        style: TextStyle(
                          fontSize: theme.bodyLarge?.fontSize,
                          color: theme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      calculator.calculateAll();
                    });
                  },
                  child: Text(
                    "Calcular",
                    style: TextStyle(
                      color: theme.bodyLarge?.color,
                      fontSize: theme.bodyLarge?.fontSize,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: clearValues,
                  child: Text(
                    "Limpar",
                    style: TextStyle(
                      color: theme.bodyLarge?.color,
                      fontSize: theme.bodyLarge?.fontSize,
                    ),
                  ),
                ),
                Image.asset(
                  "assets/images/logo2.png",
                  height: 70.h,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
