import 'package:flutter/material.dart';
import '../app_styles.dart';

final bottomContainerColour = RichText(
    text: TextSpan(
  children: [
    const TextSpan(
      text: 'We\'re ',
    ),
    TextSpan(
      text: 'ready ',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
    const TextSpan(
      text: 'to take ',
    ),
    TextSpan(
      text: 'care of you ',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
  ],
));

final bottomContainerColour1 = RichText(
    text: TextSpan(
  children: [
    const TextSpan(
      text: 'Find the best ',
    ),
    TextSpan(
      text: 'barber ',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
    const TextSpan(
      text: 'in your neighborhood and ',
    ),
    TextSpan(
      text: 'book a dream visit ',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
  ],
));

final bottomContainerColour2 = RichText(
    text: TextSpan(
  children: [
    const TextSpan(
      text: 'We ',
    ),
    TextSpan(
      text: 'love to serve ',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
    const TextSpan(
      text: 'you that ',
    ),
    TextSpan(
      text: 'suits you ',
      style: TextStyle(
        color: kPrimaryColor,
      ),
    ),
  ],
));

class OnBoarding {
  final String title;
  final String image;
  final String text;

  OnBoarding({
    required this.title,
    required this.image,
    required this.text,
  });
}

List<OnBoarding> onboardingContents = [
  OnBoarding(
    // title: 'WELCOME TO\n GUPITAN BARBER APP',
    title: 'Welcome to \n Gupitan Barber App',
    image: 'assets/barbersource1.PNG',
    text: 'We\'re ready to take care of you',
  ),
  OnBoarding(
    title: 'Book a visit easy and fast',
    image: 'assets/barbersource2.png',
    text: 'Find the best barber in your \n neighborhood and book a dream visit',
  ),
  OnBoarding(
    title: 'Don\'t miss our cuts \n It\'s your time to get buzzed',
    image: 'assets/barbersource3.PNG',
    text: 'We love to serve you that suits you',
  ),
];
