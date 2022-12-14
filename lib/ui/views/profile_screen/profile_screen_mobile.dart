part of 'profile_screen_view.dart';

class _ProfileScreenMobile extends StatelessWidget {
  final ProfileScreenViewModel viewModel;

  const _ProfileScreenMobile({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: bodyWidget());
  }

  Widget bodyWidget() {
    return Builder(builder: (context) {
      return SafeArea(
          child: FutureBuilder<DocumentSnapshot>(
              future: viewModel.getUser(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot?> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text("Something went wrong"));
                }

                if (snapshot.hasData && !snapshot.data!.exists) {
                  return const Center(child: Text("Document does not exist"));
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  UserModel userModel = UserModel.fromJson(data);
                  viewModel.nameController =
                      TextEditingController(text: userModel.name);
                  viewModel.emailController =
                      TextEditingController(text: userModel.email);
                  viewModel.aboutController =
                      TextEditingController(text: userModel.about);
                  viewModel.phoneNumberController =
                      TextEditingController(text: userModel.phoneNumber);
                  viewModel.profileImageController =
                      TextEditingController(text: userModel.profileImage);
                  viewModel.genderController =
                      TextEditingController(text: userModel.gender);
                  viewModel.ageController = TextEditingController(
                      text: userModel.age.toDate().toString());
                  viewModel.sexualOrientation = userModel.sexualOrientation;
                  viewModel.intrestedInController = userModel.intrestedIn;
                  viewModel.interestsController = userModel.interests;

                  return ProfileForm(userModel: userModel);
                }
                return const Center(child: CircularProgressIndicator());
              }));
    });
  }
}

Future selectPhoto(
    BuildContext context, ProfileScreenViewModel viewModel) async {
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

class ProfileForm extends HookViewModelWidget<ProfileScreenViewModel> {
  final UserModel userModel;

  const ProfileForm({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget buildViewModelWidget(
      BuildContext context, ProfileScreenViewModel viewModel) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: <Widget>[
                  _titleBar(context, viewModel),
                  if (viewModel.imageFile == null)
                    userModel.profileImage == ""
                        ? InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.amber,
                            onTap: () => selectPhoto(context, viewModel),
                            child: AppRoundImage.assets(
                              userPlaceholder,
                              width: 150,
                              height: 150,
                              hasBorder: false,
                            ),
                          )
                        : InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.amber,
                            onTap: () => selectPhoto(context, viewModel),
                            child: AppRoundImage.url(
                              userModel.profileImage,
                              width: 150,
                              height: 150,
                              hasBorder: true,
                            ),
                          ),
                  if (viewModel.imageFile != null)
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => selectPhoto(context, viewModel),
                      child: AppRoundImage.file(
                        viewModel.imageFile!,
                        width: 150,
                        height: 150,
                        hasBorder: true,
                      ),
                    ),
                  _sizedBox(32.0),
                  // Name Box
                  _nameBox(context, viewModel),
                  _sizedBox(16.0),
                  // Email Box
                  _emailBox(context, viewModel),
                  _sizedBox(16.0),
                  // About Section Box
                  _aboutBox(context, viewModel),
                  _sizedBox(16.0),
                  // Phone Number Box
                  _phoneNumberBox(context, viewModel),
                  _sizedBox(16.0),
                  // Gender Box
                  _genderBox(context, viewModel),
                  _sizedBox(16.0),
                  // Age Box
                  _ageBox(context, viewModel),
                  _sizedBox(16.0),
                  // Sexual Orientation Box
                  _sexualOrientation(context, viewModel),
                  _sizedBox(16.0),
                  // Intrested In Box
                  _intrestedIn(context, viewModel),
                  _sizedBox(16.0),
                  // Intrest Box
                  _intrestBox(context, viewModel),
                  _sizedBox(16.0),
                  // Update Profile Button
                  _updateProfile(context, viewModel),
                  _sizedBox(150.0),
                  // Logout Button
                  _logout(context, viewModel),
                  _sizedBox(16.0),
                  // Delete Account Button
                  _deleteAccount(context, viewModel),
                  _sizedBox(16.0),
                ])))
      ],
    );
  }

  _sizedBox(double height) {
    return SizedBox(height: height);
  }

  _titleBar(BuildContext context, ProfileScreenViewModel viewModel) {
    return Column(
      children: [
        Text(
          viewModel.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          viewModel.subTitle,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  _nameBox(BuildContext context, ProfileScreenViewModel viewModel) {
    return SingleAnswer(
        controller: viewModel.nameController!,
        label: "Name",
        hint: "Enter your name",
        onChanged: (value) {
          viewModel.nameController!.text = value;
        });
  }

  _emailBox(BuildContext context, ProfileScreenViewModel viewModel) {
    return SingleAnswer(
        controller: viewModel.emailController!,
        label: "Email",
        hint: "Enter your email",
        textInputType: TextInputType.emailAddress,
        onChanged: (value) {
          viewModel.emailController!.text = value;
        });
  }

  _aboutBox(BuildContext context, ProfileScreenViewModel viewModel) {
    return SingleAnswer(
        maxLines: 3,
        controller: viewModel.aboutController!,
        label: "About",
        hint: "Enter your about",
        onChanged: (value) {
          viewModel.aboutController!.text = value;
        });
  }

  _phoneNumberBox(BuildContext context, ProfileScreenViewModel viewModel) {
    return SingleAnswer(
        controller: viewModel.phoneNumberController!,
        label: "Phone Number",
        hint: "Enter your phone number",
        textInputType: TextInputType.phone,
        onChanged: (value) {
          viewModel.phoneNumberController!.text = value;
        });
  }

  _genderBox(BuildContext context, ProfileScreenViewModel viewModel) {
    return DropDownAnswer(
      title: 'Select Your Gender',
      onChanged: (value) {
        viewModel.genderController!.text = value!;
        viewModel.notifyListeners();
      },
      values: genderList,
      value: viewModel.genderController!.text,
    );
  }

  _ageBox(BuildContext context, ProfileScreenViewModel viewModel) {
    return SingleAnswer(
        controller: viewModel.ageController!,
        label: "Age",
        hint: "Enter your age",
        onTap: () {
          showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100))
              .then((value) {
            viewModel.ageController!.text = value.toString();
          });
        },
        textInputType: TextInputType.datetime,
        onChanged: (value) {
          viewModel.ageController!.text = value;
        });
  }

  _sexualOrientation(BuildContext context, ProfileScreenViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Sexual Orientation",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            for (int i = 0; i < viewModel.sexualOrientation.length; i++)
              Chip(
                  label: Text(viewModel.sexualOrientation[i],
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary))),
            Chip(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                label: Text("Add more",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary))),
          ],
        ),
      ],
    );
  }

  _intrestedIn(BuildContext context, ProfileScreenViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Interested In",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            for (int i = 0; i < viewModel.intrestedInController.length; i++)
              Chip(
                  label: Text(viewModel.intrestedInController[i],
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary))),
            Chip(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                label: Text("Add more",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary))),
          ],
        ),
      ],
    );
  }

  _intrestBox(BuildContext context, ProfileScreenViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Interests",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            for (int i = 0; i < viewModel.interestsController.length; i++)
              Chip(
                  label: Text(viewModel.interestsController[i],
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary))),
            Chip(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                label: Text("Add more",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary))),
          ],
        ),
      ],
    );
  }

  _updateProfile(BuildContext context, ProfileScreenViewModel viewModel) {
    return RaisedGradientButton(
        child: viewModel.isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
            : const Text("Update Profile"),
        onPressed: () {
          viewModel.updateIsLoading();
          viewModel.updateProfile(context).then((flag) {
            if (flag == 'EMPTY') {
              customSnackbar(context, 'All fields are compulsory', Colors.red);
            } else if (flag == 'SUCCESS') {
              customSnackbar(
                  context, 'Profile Updated Successfully', Colors.green);
            } else if (flag == '') {
              customSnackbar(context, flag, Colors.red);
            } else {
              customSnackbar(context, 'Something went wrong', Colors.red);
            }
          });
          viewModel.updateIsLoading();
        });
  }

  _logout(BuildContext context, ProfileScreenViewModel viewModel) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(10)),
      child: TextButton(
        onPressed: () {
          _showDialog(context, "Logout", "Are you sure you want to logout?",
              "LoggedOut Successfully", () => viewModel.signOutUser());
        },
        child: Text(
          "Logout",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary, fontSize: 15),
        ),
      ),
    );
  }

  _deleteAccount(BuildContext context, ProfileScreenViewModel viewModel) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(10)),
      child: TextButton(
        onPressed: () {
          _showDialog(
              context,
              "Delete Account",
              "Are you sure you want to delete your account? This action cannot be undone.",
              "Account Deleted Successfully",
              () => viewModel.deleteAccount());
        },
        child: Text(
          "Delete Account",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary, fontSize: 15),
        ),
      ),
    );
  }
}

_showDialog(BuildContext context, String title, String dialogtext,
    String snackBarMessage, Function function) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(dialogtext),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  function().then((value) {
                    Navigator.pushReplacementNamed(
                      context,
                      signInScreen,
                    );
                    customSnackbar(context, snackBarMessage, Colors.green);
                  });
                },
                child: Text(title))
          ],
        );
      });
}
