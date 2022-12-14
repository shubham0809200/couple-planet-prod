part of 'splash_screen_view.dart';

class _SplashScreenMobile extends StatelessWidget {
  final SplashScreenViewModel viewModel;

  const _SplashScreenMobile({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(
            child: Image(
              image: AssetImage(logo),
              height: 200,
              width: 300,
            ),
          ),
        ],
      ),
    );
  }
}
