import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:digitalcontractsapp/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OnBoardingViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();

  int _currentIndex = 0;
  final SwiperController _swiperController = SwiperController();
  final List<Gradient> _colors = [
    LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xff96EFA6), Color(0xff26A6B5)]),
    LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xffA1A3FF), Color(0xff6D63EF)]),
    LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xff8582FF), Color(0xff75ADF0)]),
  ];
  final List<String> _images = [
    'assets/onboarding/onboarding_1.jpg',
    'assets/onboarding/onboarding_2.jpeg',
    'assets/onboarding/onboarding_3.jpeg',
  ];

  // * Getters

  int get currentIndex => _currentIndex;
  SwiperController get swiperController => _swiperController;
  List<Gradient> get color => _colors;
  List<String> get images => _images;

  // * Functions

  void updateIndex(index) {
    _currentIndex = index;
    notifyListeners();
  }

  void nextStep() {
    if (_currentIndex != 2)
      _swiperController.next();
    else
      goLogin();
  }

  void goLogin() => _navigationService.back();
}
