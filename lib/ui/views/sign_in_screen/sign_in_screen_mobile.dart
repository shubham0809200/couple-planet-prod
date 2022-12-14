part of 'sign_in_screen_view.dart';

class _SignInScreenMobile extends StatelessWidget {
  final SignInScreenViewModel viewModel;

  const _SignInScreenMobile({required this.viewModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyWidget(),
    );
  }

  Widget bodyWidget() {
    return Builder(builder: (context) {
      return CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 4,
                        child: Image.asset(
                          logo,
                          height: 160,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        viewModel.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Palette.firebaseBlack,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        viewModel.subTitle,
                        style: const TextStyle(
                            color: Palette.firebaseBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                    ],
                  )),
                  TextField(
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter Your Email'),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: ((value) {
                      viewModel.emailId = value;
                    }),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter Your Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          viewModel.isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          viewModel.onPasswordVisibilityChanged();
                        },
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: !viewModel.isPasswordVisible,
                    onChanged: ((value) {
                      viewModel.password = value;
                    }),
                  ),
                  const SizedBox(height: 16),
                  RaisedGradientButton(
                      child: viewModel.isLoading
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white))
                          : const Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                      onPressed: () async {
                        viewModel.updateIsLoading();

                        await viewModel.signInUser().then((flag) {
                          if (flag == 'EMPTY') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Email and Password Can\'t be $flag',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ));
                          } else if (flag == 'SUCCESS') {
                            Navigator.pushReplacementNamed(
                              context,
                              homeScreen,
                            );
                          } else if (flag != '') {
                            print(flag);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                flag,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                'Error in Auth',
                                style: TextStyle(fontSize: 16),
                              ),
                            ));
                          }
                          viewModel.updateIsLoading();
                        });
                      }),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an Account?'),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            signUpScreen,
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Palette.firebaseAmber,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
