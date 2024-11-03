import 'dart:io';

import 'package:calculator_bo6/const/text_const.dart';
import 'package:calculator_bo6/controller/calculator.dart';
import 'package:calculator_bo6/data/photo_with_value.dart';
import 'package:calculator_bo6/model/photo_with_value.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String? backgroundImagePath;

  @override
  void initState() {
    super.initState();
    loadbackgroundImage();
  }

  Future<void> loadbackgroundImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      backgroundImagePath = prefs.getString("backgroundImagePath") ?? "assets/images/gura.jpg";
    });
  }

  Future<void> pickBackgroundImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("backgroundImagePath", pickedFile.path);

      setState(() {
        backgroundImagePath = pickedFile.path;
      });
    }
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
            child: backgroundImagePath != null
                ? Image.file(
                    File(backgroundImagePath!),
                    fit: BoxFit.fill,
                  )
                : Image.asset(
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
                        style: TextStyle(fontSize: title.sp),
                      ),
                      IconButton(
                        onPressed: pickBackgroundImage,
                        icon: Icon(
                          Icons.image,
                          size: 20.sp,
                        ),
                        tooltip: "Foto de Fundo",
                      ),
                      GestureDetector(
                          onTap: () {
                            showPhotoSeletor("x");
                          },
                          child: Text(
                            "Tap to Select X : ${calculator.x ?? ''}",
                            style: TextStyle(fontSize: body.sp),
                          )),
                      GestureDetector(
                        onTap: () {
                          showPhotoSeletor("y");
                        },
                        child: Text(
                          "Tap to Select Y : ${calculator.y ?? ''}",
                          style: TextStyle(fontSize: body.sp),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showPhotoSeletor("z");
                        },
                        child: Text(
                          "Tap to Select Z : ${calculator.z ?? ''}",
                          style: TextStyle(fontSize: body.sp),
                        ),
                      ),
                      Text(
                        "1 = ${calculator.calculateFirstFormula()}",
                        style: TextStyle(fontSize: body.sp),
                      ),
                      Text(
                        "2 = ${calculator.calculateSecondFormula()}",
                        style: TextStyle(fontSize: body.sp),
                      ),
                      Text(
                        "3 = ${calculator.calculateThirdFormula()}",
                        style: TextStyle(fontSize: body.sp),
                      ),
                      ElevatedButton(
                        onPressed: clearValues,
                        child: Text(
                          "Limpar",
                          style: TextStyle(fontSize: lable.sp, color: textColor),
                        ),
                        // style: ElevatedButton.styleFrom(fixedSize: Size(30.w, 20.h)),
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
