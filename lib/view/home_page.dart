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
                      calculator.x = photoWithValue.value;
                    } else if (variable == "y") {
                      calculator.y = photoWithValue.value;
                    } else {
                      calculator.z = photoWithValue.value;
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
      calculator.x = null;
      calculator.y = null;
      calculator.z = null;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showPhotoSeletor("x");
                        },
                        child: Text(
                          "Tap to Select X : ${calculator.x ?? ''}",
                          style: TextStyle(
                            fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showPhotoSeletor("y");
                        },
                        child: Text(
                          "Tap to Select Y : ${calculator.y ?? ''}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showPhotoSeletor("z");
                        },
                        child: Text(
                          "Tap to Select Z : ${calculator.z ?? ''}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                      Text(
                        "1 = ${calculator.calculateFirstFormula()}",
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      Text(
                        "2 = ${calculator.calculateSecondFormula()}",
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      Text(
                        "3 = ${calculator.calculateThirdFormula()}",
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: clearValues,
                        child: Text(
                          "Limpar",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                    ],
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
