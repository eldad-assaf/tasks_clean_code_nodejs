import 'package:flutter/material.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/datasources/local/app_database.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/user_model.dart';
import 'package:store_flutter_clean_code_nodejs/injection_container.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AppDatabase _appDatabase;

  @override
  void initState() {
    _appDatabase = sl<AppDatabase>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: StreamBuilder<UserModel?>(
        stream:
            _appDatabase.userDao.userStreamForAuthState(UserModel.fixedUserId),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.active) {
            if (userSnapshot.data == null) {
              return Container(
                color: Colors.amber,
              );
            } else {
              return Container(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person_3),
                      title: Text(
                        'username:' + ' ' + userSnapshot.data!.name.toString(),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text(
                        'email:' + ' ' + userSnapshot.data!.email.toString(),
                      ),
                    )
                  ],
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Profile'),
    );
  }
}
