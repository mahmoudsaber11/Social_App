import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_app/social_user_model.dart';

class UserProfileScreen extends StatelessWidget {
  final SocialUserModel userModel;

  const UserProfileScreen({Key? key, required this.userModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          // backgroundColor: context.themeMode.colorScheme.background,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 220,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: <Widget>[
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(userModel.cover!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          radius: 54,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(userModel.image!),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    userModel.name!,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    userModel.bio!,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        buildProfileData(context, 0, "Posts"),
                        buildProfileData(context, 0, "Photos"),
                        buildProfileData(context, 0, "Followers"),
                        buildProfileData(context, 0, "Following"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildProfileData(BuildContext context, int count, String label) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            "$count",
            //    style: bodyLarge,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            // style: caption,
          ),
        ],
      ),
    );
  }
}
