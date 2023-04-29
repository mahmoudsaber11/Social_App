import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_app/post_model.dart';
import 'package:social_app/shared/components/components.dart';

// ignore: must_be_immutable
class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  var now = TimeOfDay.now();
  String? postId;
  PostModel? postModel;

  NewPostScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var socialUserModel = SocialCubit.get(context).socialUserModel;
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Create Post', actions: [
            TextButton(
                onPressed: () {
                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createPost(
                      name: socialUserModel!.name,
                      postText: textController.text,
                      image: socialUserModel.image,
                      date: now.toString(),
                    );
                  } else {
                    SocialCubit.get(context).uploadPost(
                        postText: textController.text, date: now.toString());
                  }
                },
                child: const Text('POST'))
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  const SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage:
                          NetworkImage('${socialUserModel!.image}'),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text('${socialUserModel.name}'),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                        hintText: 'what is on your mind ...',
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(alignment: AlignmentDirectional.topEnd, children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                              image: FileImage(
                                  SocialCubit.get(context).postImage!),
                              fit: BoxFit.cover)),
                    ),
                    IconButton(
                      onPressed: () {
                        SocialCubit.get(context).removePostImage();
                      },
                      icon: CircleAvatar(
                          //  backgroundColor: Colors.grey[400],
                          radius: 13,
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.grey[300],
                          )),
                    ),
                  ]),
                const SizedBox(
                  height: 29.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.image),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('add photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {}, child: const Text('# tags')),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
