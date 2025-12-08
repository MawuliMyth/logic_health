@echo off
REM Example: create_mvc.bat auth

set FEATURE=%1

if "%FEATURE%"=="" (
    echo Please provide a feature name. Example: create_mvc.bat auth
    exit /B 1
)

set ROOT=lib\features\%FEATURE%

mkdir %ROOT%\models
mkdir %ROOT%\controllers
mkdir %ROOT%\views

REM create model file
echo class %FEATURE:~0,1%%FEATURE:~1%Model {> %ROOT%\models\%FEATURE%_model.dart
echo.    // TODO: Define fields and constructor here>> %ROOT%\models\%FEATURE%_model.dart
echo }>> %ROOT%\models\%FEATURE%_model.dart

REM create controller file
echo import '../models/%FEATURE%_model.dart';> %ROOT%\controllers\%FEATURE%_controller.dart
echo.>> %ROOT%\controllers\%FEATURE%_controller.dart
echo class %FEATURE:~0,1%%FEATURE:~1%Controller {>> %ROOT%\controllers\%FEATURE%_controller.dart
echo     // TODO: Add logic and API calls here>> %ROOT%\controllers\%FEATURE%_controller.dart
echo }>> %ROOT%\controllers\%FEATURE%_controller.dart

REM create view file
echo import 'package:flutter/material.dart';> %ROOT%\views\%FEATURE%_view.dart
echo.>> %ROOT%\views\%FEATURE%_view.dart
echo class %FEATURE:~0,1%%FEATURE:~1%View extends StatelessWidget {>> %ROOT%\views\%FEATURE%_view.dart
echo.    const %FEATURE:~0,1%%FEATURE:~1%View({Key? key}) : super(key: key);>> %ROOT%\views\%FEATURE%_view.dart
echo.>> %ROOT%\views\%FEATURE%_view.dart
echo   @override>> %ROOT%\views\%FEATURE%_view.dart
echo   Widget build(BuildContext context) {>> %ROOT%\views\%FEATURE%_view.dart
echo     return Scaffold(>> %ROOT%\views\%FEATURE%_view.dart
echo       appBar: AppBar(title: const Text("%FEATURE:~0,1%%FEATURE:~1% View")),>> %ROOT%\views\%FEATURE%_view.dart
echo       body: Center(child: Text("This is the %FEATURE% view")),>> %ROOT%\views\%FEATURE%_view.dart
echo     );>> %ROOT%\views\%FEATURE%_view.dart
echo   }>> %ROOT%\views\%FEATURE%_view.dart
echo }>> %ROOT%\views\%FEATURE%_view.dart

echo MVC structure created for feature: %FEATURE%
pause
