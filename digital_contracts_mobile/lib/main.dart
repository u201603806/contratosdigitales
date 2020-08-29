import 'package:flutter/material.dart';
import 'package:digitalcontractsapp/app/locator.dart';

import 'app/initialize.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  Initialize();
}
