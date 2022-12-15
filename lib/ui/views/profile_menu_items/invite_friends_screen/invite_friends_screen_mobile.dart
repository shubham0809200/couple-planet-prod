part of 'invite_friends_screen_view.dart';

class _InviteFriendsScreenMobile extends StatelessWidget {
  final InviteFriendsScreenViewModel viewModel;

  const _InviteFriendsScreenMobile({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'InviteFriendsScreenView',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0),
        body: _bodyWidget(context));
  }

  _bodyWidget(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: viewModel.getContacts(),
            builder: ((context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text("Something went wrong"));
              } else if (snapshot.data == null) {
                return const Center(child: Text("Loading..."));
              }

              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Contact contact = snapshot.data[index];
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        radius: 20,
                        child: Icon(Icons.person,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      title: Text(contact.displayName,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary)),
                      subtitle: Text(contact.phones.first,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary)),
                      trailing: ButtonTheme(
                        minWidth: 50.0,
                        height: 30.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text("Invite",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          onPressed: () {
                            // launch(
                            //   "sms:${contact.phones.first}"
                            //   "?body=Hello Friend, I came across this amazing appliation called 'couple planet' you mmust try to meet new peoples and make new friends. Download the app from the link below. \nwww.facebook.com",
                            // );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            })));
  }
}

class ContactList extends HookViewModelWidget<InviteFriendsScreenViewModel> {
  final Map<String, dynamic> contact;

  const ContactList({Key? key, required this.contact}) : super(key: key);

  @override
  Widget buildViewModelWidget(
      BuildContext context, InviteFriendsScreenViewModel viewModel) {
    return ListView.builder(
        itemCount: contact.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(contact[index].displayName),
              onTap: () {
                // viewModel.sendInvite(contact.phones![index].value!);
              });
        });
  }
}
