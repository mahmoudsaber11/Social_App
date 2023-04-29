import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_app/social_user_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';

import '/layout/cubit/cubit.dart';
import '/layout/cubit/states.dart';
import '/modules/users/user_profile_screen.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users!.isNotEmpty,
          builder: (context) {
            return GridView.builder(
              itemBuilder: (context, index) {
                return buildUserItem(
                  context: context,
                  userModel: SocialCubit.get(context).users![index],
                );
              },
              itemCount: SocialCubit.get(context).users!.length,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              scrollDirection: Axis.vertical,
              reverse: false,
              primary: true,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              dragStartBehavior: DragStartBehavior.start,
              clipBehavior: Clip.hardEdge,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisExtent: 220,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
                childAspectRatio: 3 / 2,
              ),
            );
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(color: defaultColor),
          ),
        );
      },
    );
  }

  Widget buildUserItem({
    required BuildContext context,
    required SocialUserModel userModel,
  }) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          UserProfileScreen(userModel: userModel),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: defaultColor.withOpacity(0.6),
        elevation: 10,
        shadowColor: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 45.5,
              child: CircleAvatar(
                backgroundImage: NetworkImage(userModel.image!),
                radius: 45.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              userModel.name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.touch_app,
                  color: Colors.white,
                  size: 22,
                ),
                const SizedBox(width: 5),
                Text(
                  "Visit",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
