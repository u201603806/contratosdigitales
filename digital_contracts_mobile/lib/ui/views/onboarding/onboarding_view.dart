import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:digitalcontractsapp/res/pallete_color.dart';
import 'package:digitalcontractsapp/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:stacked/stacked.dart';

class OnBoardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnBoardingViewModel>.nonReactive(
      viewModelBuilder: () => OnBoardingViewModel(),
      builder: (_, model, child) => Scaffold(
        body: Stack(
          children: <Widget>[_ImageSwiper(), _SkipButton(), _NextButton()],
        ),
      ),
    );
  }
}

class _NextButton extends ViewModelWidget<OnBoardingViewModel> {
  const _NextButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, OnBoardingViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, bottom: 10.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25.0)), color: Colors.white, boxShadow: [BoxShadow(color: Colors.white, blurRadius: 6)]),
          child: IconButton(
            icon: Icon(
              model.currentIndex == 2 ? Icons.check : Icons.arrow_forward,
              color: Color(0xffFD7F80),
            ),
            onPressed: model.nextStep,
          ),
        ),
      ),
    );
  }
}

class _SkipButton extends ViewModelWidget<OnBoardingViewModel> {
  const _SkipButton({
    Key key,
  }) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, OnBoardingViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, bottom: 10.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: FlatButton(
          child: Text(
            "Skip",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          onPressed: model.goLogin,
        ),
      ),
    );
  }
}

class _ImageSwiper extends ViewModelWidget<OnBoardingViewModel> {
  const _ImageSwiper({
    Key key,
  }) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, OnBoardingViewModel model) {
    return Swiper(
      loop: false,
      index: model.currentIndex,
      onIndexChanged: (index) => model.updateIndex(index),
      controller: model.swiperController,
      pagination: SwiperPagination(
        margin: EdgeInsets.only(bottom: 5.0),
        builder: DotSwiperPaginationBuilder(
          activeColor: Colors.white,
          activeSize: 20.0,
        ),
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        return IntroItem(
          image: model.images[index],
        );
      },
    );
  }
}

class IntroItem extends StatelessWidget {
  final String image;

  const IntroItem({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
          Color(0xff1357BD),
          Color(0x0f0B203A),
          PalleteColor.backgroundMenuDrawerColor,
        ]),
        image: DecorationImage(image: AssetImage(image), fit: MediaQuery.of(context).orientation == Orientation.portrait ? BoxFit.contain : BoxFit.contain),
      ),
    );
  }
}
