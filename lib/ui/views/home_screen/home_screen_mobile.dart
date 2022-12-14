part of 'home_screen_view.dart';

class _HomeScreenMobile extends StatelessWidget {
  final HomeScreenViewModel viewModel;

  const _HomeScreenMobile({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(viewModel.title),
      // ),
      body: viewModel.pages[viewModel.pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  GNav buildMyNavBar(BuildContext context) {
    return GNav(
        gap: 10,
        textStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        tabs: const [
          GButton(
            icon: Icons.ac_unit_rounded,
            text: 'Home',
          ),
          GButton(
            icon: Icons.how_to_reg_sharp,
            text: 'Match',
          ),
          GButton(
            icon: Icons.chat_bubble,
            text: 'Chat',
          ),
          GButton(
            icon: Icons.account_circle,
            text: 'Profile',
          ),
        ],
        selectedIndex: viewModel.pageIndex,
        onTabChange: (index) {
          viewModel.updatePageIndex(index);
        });
  }
}
