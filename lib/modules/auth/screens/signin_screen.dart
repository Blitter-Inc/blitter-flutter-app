import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:blitter_flutter_app/config/animation.dart';
import 'package:blitter_flutter_app/config/color.dart';
import 'package:blitter_flutter_app/data/cubits/cubits.dart';
import 'package:blitter_flutter_app/widgets/loading_spinner.dart';
import '../widgets/widgets.dart';

class SigninScreen extends StatefulWidget {
  static const route = '/sign-in';

  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen>
    with TickerProviderStateMixin {
  static const backgroundSvg =
      r"<svg xmlns='http://www.w3.org/2000/svg' width='100%' height='100%' viewBox='0 0 1600 800'><rect fill='#5DC14C' width='1600' height='800'/><g fill-opacity='1'><path fill='#47a037'  d='M486 705.8c-109.3-21.8-223.4-32.2-335.3-19.4C99.5 692.1 49 703 0 719.8V800h843.8c-115.9-33.2-230.8-68.1-347.6-92.2C492.8 707.1 489.4 706.5 486 705.8z'/><path fill='#35782a'  d='M1600 0H0v719.8c49-16.8 99.5-27.8 150.7-33.5c111.9-12.7 226-2.4 335.3 19.4c3.4 0.7 6.8 1.4 10.2 2c116.8 24 231.7 59 347.6 92.2H1600V0z'/><path fill='#23501c'  d='M478.4 581c3.2 0.8 6.4 1.7 9.5 2.5c196.2 52.5 388.7 133.5 593.5 176.6c174.2 36.6 349.5 29.2 518.6-10.2V0H0v574.9c52.3-17.6 106.5-27.7 161.1-30.9C268.4 537.4 375.7 554.2 478.4 581z'/><path fill='#12280e'  d='M0 0v429.4c55.6-18.4 113.5-27.3 171.4-27.7c102.8-0.8 203.2 22.7 299.3 54.5c3 1 5.9 2 8.9 3c183.6 62 365.7 146.1 562.4 192.1c186.7 43.7 376.3 34.4 557.9-12.6V0H0z'/><path fill='#000000'  d='M181.8 259.4c98.2 6 191.9 35.2 281.3 72.1c2.8 1.1 5.5 2.3 8.3 3.4c171 71.6 342.7 158.5 531.3 207.7c198.8 51.8 403.4 40.8 597.3-14.8V0H0v283.2C59 263.6 120.6 255.7 181.8 259.4z'/><path fill='#003633'  d='M1600 0H0v136.3c62.3-20.9 127.7-27.5 192.2-19.2c93.6 12.1 180.5 47.7 263.3 89.6c2.6 1.3 5.1 2.6 7.7 3.9c158.4 81.1 319.7 170.9 500.3 223.2c210.5 61 430.8 49 636.6-16.6V0z'/><path fill='#006d66'  d='M454.9 86.3C600.7 177 751.6 269.3 924.1 325c208.6 67.4 431.3 60.8 637.9-5.3c12.8-4.1 25.4-8.4 38.1-12.9V0H288.1c56 21.3 108.7 50.6 159.7 82C450.2 83.4 452.5 84.9 454.9 86.3z'/><path fill='#00a39a'  d='M1600 0H498c118.1 85.8 243.5 164.5 386.8 216.2c191.8 69.2 400 74.7 595 21.1c40.8-11.2 81.1-25.2 120.3-41.7V0z'/><path fill='#00dacd'  d='M1397.5 154.8c47.2-10.6 93.6-25.3 138.6-43.8c21.7-8.9 43-18.8 63.9-29.5V0H643.4c62.9 41.7 129.7 78.2 202.1 107.4C1020.4 178.1 1214.2 196.1 1397.5 154.8z'/><path fill='#11FFF1'  d='M1315.3 72.4c75.3-12.6 148.9-37.1 216.8-72.4h-723C966.8 71 1144.7 101 1315.3 72.4z'/></g></svg>";

  bool _isLoading = false;
  bool _otpSent = false;
  bool _otpVerified = false;

  late AnimationController _formOpacityController;
  late Animation<double> _formOpacity;
  late AnimationController _logoOpacityController;
  late Animation<double> _logoOpacity;

  Widget _formFadeTransitionContainer(Widget child) {
    return FadeTransition(
      opacity: _formOpacity,
      child: child,
    );
  }

  Future<void> _activateLoader() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      _isLoading = true;
    });
    _formOpacityController.forward();
  }

  Future<void> _deactivateLoader() async {
    _formOpacityController.reverse();
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _animateOutForm() async {
    _formOpacityController.reverse();
    await _activateLoader();
  }

  Future<void> _codeSentHandler() async {
    await _deactivateLoader();
    setState(() {
      _otpSent = true;
    });
    _formOpacityController.forward();
  }

  Future<void> _verificationCompletedHandler() async {
    _logoOpacityController.forward();
    await _deactivateLoader();
    setState(() {
      _otpVerified = true;
    });
    _formOpacityController.forward();
  }

  Future<void> _verificationFailedHandler() async {
    await _deactivateLoader();
    _formOpacityController.forward();
    // handle error display logic here
  }

  @override
  void initState() {
    super.initState();
    _formOpacityController = AnimationController(
      vsync: this,
      duration: defaultTransitionDuration,
    );
    _formOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _formOpacityController,
        curve: Curves.easeInOut,
      ),
    );
    _logoOpacityController = AnimationController(
      vsync: this,
      duration: defaultTransitionDuration,
    );
    _logoOpacity = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _logoOpacityController,
        curve: Curves.easeInOut,
      ),
    );
    _formOpacityController.forward();
    // _formOpacityController.addStatusListener((status) async {});
  }

  @override
  void dispose() {
    _formOpacityController.dispose();
    _logoOpacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => SigninCubit(
        codeSent: _codeSentHandler,
        verificationCompleted: _verificationCompletedHandler,
        verificationFailed: _verificationFailedHandler,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: _otpVerified
              ? Text(
                  'Update Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = foregroundShader,
                  ),
                )
              : null,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            SvgPicture.string(
              backgroundSvg,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fitHeight,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              alignment: Alignment.center,
              child: _otpVerified
                  ? _formFadeTransitionContainer(const UpdateProfileForm())
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FadeTransition(
                          opacity: _logoOpacity,
                          child: const BlitterText(),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          height: 220,
                          child: _isLoading
                              ? _formFadeTransitionContainer(
                                  const LoadingSpinner())
                              : !_otpSent
                                  ? _formFadeTransitionContainer(
                                      PhoneInputForm(
                                        animateOutForm: _animateOutForm,
                                      ),
                                    )
                                  : _formFadeTransitionContainer(
                                      OTPInputForm(
                                        animateOutForm: _animateOutForm,
                                      ),
                                    ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
