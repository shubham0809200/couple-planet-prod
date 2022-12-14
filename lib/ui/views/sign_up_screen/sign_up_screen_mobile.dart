part of 'sign_up_screen_view.dart';

class _SignUpScreenMobile extends StatelessWidget {
  final SignUpScreenViewModel viewModel;

  const _SignUpScreenMobile({required this.viewModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyWidget(),
    );
  }

  Widget bodyWidget() {
    return Builder(builder: (context) {
      return SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
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
                    if (viewModel.imageUrl == "" && viewModel.imageFile == null)
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.amber,
                        onTap: () => selectPhoto(context),
                        child: AppRoundImage.assets(
                          userPlaceholder,
                          width: 150,
                          height: 150,
                          hasBorder: false,
                        ),
                      ),
                    if (viewModel.imageFile != null)
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => selectPhoto(context),
                        child: AppRoundImage.file(
                          viewModel.imageFile!,
                          width: 150,
                          height: 150,
                          hasBorder: false,
                        ),
                      ),
                    const SizedBox(height: 16),
                    _name(context),
                    const SizedBox(height: 16),
                    // _age(context),
                    // const SizedBox(height: 16),
                    _gender(context),
                    const SizedBox(height: 16),
                    _email(context),
                    const SizedBox(height: 16),
                    _phoneNumber(context),
                    const SizedBox(height: 16),
                    _password(context),
                    const SizedBox(height: 16),
                    _confirmPassword(context),
                    const SizedBox(height: 16),
                    RaisedGradientButton(
                        child: viewModel.isLoading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white))
                            : const Text(
                                'Create Account',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                        onPressed: () async {
                          viewModel.updateIsLoading();

                          await viewModel.signInUser().then((flag) {
                            if (flag == 'EMPTY') {
                              customSnackbar(context,
                                  'All fields are compulsory', Colors.red);
                            } else if (flag == 'SUCCESS') {
                              Navigator.pushReplacementNamed(
                                context,
                                homeScreen,
                              );
                            } else if (flag == 'PASSWORD_DIDNT_MATCH') {
                              customSnackbar(context, 'Password Didn\'t Match.',
                                  Colors.red);
                            } else if (flag != '') {
                              print(flag);
                              customSnackbar(context, flag, Colors.red);
                            } else {
                              customSnackbar(
                                  context, 'Error in Auth', Colors.red);
                            }
                            viewModel.updateIsLoading();
                          });
                        }),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an Account?'),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'Sign In',
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
        ),
      );
    });
  }

  Widget _name(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyText1,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Name',
          hintText: 'Enter Your Name'),
      keyboardType: TextInputType.name,
      onChanged: ((value) {
        viewModel.name = value;
      }),
    );
  }

  _age(BuildContext context) {
    // select a date with datePicker and conver it to timestamp
    return Flexible(
      child: SingleAnswer(
        controller: TextEditingController(text: viewModel.age),
        onChanged: ((value) {
          viewModel.age = value;
        }),
        onTap: () {
          viewModel.datePicker(context).then((value) {
            viewModel.age = value;
            viewModel.notifyListeners();
          });
        },
        label: 'Date Of Birth',
        textInputType: TextInputType.datetime,
      ),
    );
  }

  Widget _gender(BuildContext context) {
    return DropDownAnswer(
      title: 'Select Your Gender',
      onChanged: (value) {
        viewModel.gender = value!;
        viewModel.notifyListeners();
      },
      values: genderList,
      value: viewModel.gender,
    );
  }

  Widget _email(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyText1,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
          hintText: 'Enter Your Email'),
      keyboardType: TextInputType.emailAddress,
      onChanged: ((value) {
        viewModel.emailId = value;
      }),
    );
  }

  Widget _phoneNumber(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyText1,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Phone Number',
          hintText: 'Enter Your Phone Number'),
      keyboardType: TextInputType.phone,
      onChanged: ((value) {
        viewModel.phoneNumber = value;
      }),
    );
  }

  Widget _password(BuildContext context) {
    return TextField(
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
    );
  }

  Widget _confirmPassword(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Confirm Password',
        hintText: 'Enter Your Password Again',
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
        viewModel.confirmPassword = value;
      }),
    );
  }

  Future selectPhoto(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      leading: const Icon(Icons.camera),
                      title: const Text('Camera'),
                      onTap: () {
                        Navigator.of(context).pop();
                        viewModel.pickImage(ImageSource.camera);
                      }),
                  ListTile(
                      leading: const Icon(Icons.filter),
                      title: const Text('Pick a file'),
                      onTap: () {
                        Navigator.of(context).pop();
                        viewModel.pickImage(ImageSource.gallery);
                      }),
                ],
              ),
              onClosing: () {},
            ));
  }
}
