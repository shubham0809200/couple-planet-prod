part of 'match_screen_view.dart';

class _MatchScreenMobile extends StatelessWidget {
  final MatchScreenViewModel viewModel;

  const _MatchScreenMobile({Key? key, required this.viewModel})
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
                  return Center(
                      child: Text("ConnectionState.done ${viewModel.title} ",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),));
                }
                return const Center(child: CircularProgressIndicator());
              }));
    });
  }
}
