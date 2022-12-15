part of 'profile_menu_screen_view.dart';

class _ProfileMenuScreenMobile extends StatelessWidget {
  final ProfileMenuScreenViewModel viewModel;

  const _ProfileMenuScreenMobile({Key? key, required this.viewModel})
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
                  // return Center(
                  //     child: Text(
                  //   "ConnectionState.done ${viewModel.title} ",
                  //   style:
                  //       TextStyle(color: Theme.of(context).colorScheme.primary),
                  // ));
                  return ProfileMenuItemsScreen(userModel: userModel);
                }
                return const Center(child: CircularProgressIndicator());
              }));
    });
  }
}

class ProfileMenuItemsScreen
    extends HookViewModelWidget<ProfileMenuScreenViewModel> {
  final UserModel userModel;

  const ProfileMenuItemsScreen({Key? key, required this.userModel})
      : super(key: key);

  @override
  Widget buildViewModelWidget(
      BuildContext context, ProfileMenuScreenViewModel viewModel) {
    return CustomScrollView(slivers: [
      SliverFillRemaining(
        hasScrollBody: false,
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _titleBar(context, viewModel),
                userModel.profileImage == ""
                    ? InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.amber,
                        // onTap: () => selectPhoto(context, viewModel),
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

                        // onTap: () => selectPhoto(context, viewModel),
                        child: AppRoundImage.url(
                          userModel.profileImage,
                          width: 150,
                          height: 150,
                          hasBorder: true,
                        ),
                      ),
                _sizedBox(16),
                _presonalInfo(context, viewModel),
                _sizedBox(50),
                _menuItems(context),
              ],
            )),
      ),
    ]);
  }

  _sizedBox(double height) {
    return SizedBox(height: height);
  }

  _titleBar(BuildContext context, ProfileMenuScreenViewModel viewModel) {
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

  _presonalInfo(BuildContext context, ProfileMenuScreenViewModel viewModel) {
    return Column(
      children: [
        Text(
          userModel.name,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        Text(
          userModel.email,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  _menuItems(BuildContext context) {
    List<Widget> menuItems = [];
    menuItems.add(
        _menuItem(context, "Edit Profile", Icons.account_circle_outlined, () {
      Navigator.pushNamed(
        context,
        editProfileScreen,
      );
    }));
    menuItems.add(_menuItem(
        context, "Notification", Icons.notifications_outlined, () {}));
    menuItems
        .add(_menuItem(context, "Security", Icons.security_outlined, () {}));
    menuItems.add(
        _menuItem(context, "Invite Friends", Icons.star_border_outlined, () {
      Navigator.pushNamed(
        context,
        inviteFriendsScreen,
      );
    }));

    return Column(
      children: menuItems,
    );
  }

  Widget _menuItem(BuildContext context, String title, IconData icon,
      Function? Function() param3) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: ListTile(
        onTap: param3,
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold),
          // style: TextStyle(
          //     color: tBlack, fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        // forward arrow icon
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
