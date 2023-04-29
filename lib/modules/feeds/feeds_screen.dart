import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_app/post_model.dart';
import 'package:social_app/models/social_app/social_user_model.dart';
import 'package:social_app/modules/comments_screen.dart';
import 'package:social_app/shared/components/components.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialUserModel? userModel = SocialCubit.get(context).socialUserModel;
        return ConditionalBuilder(
          condition: //SocialCubit.get(context).posts.isNotEmpty, //&&
              SocialCubit.get(context).socialUserModel != null,
          builder: (context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.all(8.0),
                    elevation: 5,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(children: [
                      const Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/full-shot-woman-reading-with-smartphone_23-2149629602.jpg?size=626&ext=jpg&ga=GA1.2.773475287.1678416458&semt=ais'),
                        height: 200,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.white),
                        ),
                      )
                    ]),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) => buildPostItem(
                          SocialCubit.get(context).posts[index],
                          userModel!,
                          context,
                          index)),
                      separatorBuilder: ((context, index) => const SizedBox(
                            height: 8,
                          )),
                      itemCount: SocialCubit.get(context).posts.length),
                  const SizedBox(
                    height: 8,
                  )
                ],
              ),
            );
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildPostItem(
          PostModel model, SocialUserModel userModel, context, index) =>
      Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      '${model.image}',
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: const TextStyle(height: 1.4),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16,
                            )
                          ],
                        ),
                        Text('${model.date}',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(height: 1.4))
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 16,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: const TextStyle(fontSize: 10),
              ),
              // ignore: sized_box_for_whitespace
              Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      // ignore: sized_box_for_whitespace
                      child: Container(
                        height: 25,
                        child: MaterialButton(
                          onPressed: () {},
                          height: 25.0,
                          minWidth: 1.0,
                          child: const Text(
                            '# software',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (model.postImage != '')
                Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                        image: NetworkImage('${model.postImage}'),
                        fit: BoxFit.cover),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.heart_broken,
                              size: 16,
                              color: Colors.deepOrange,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${model.likes}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        navigateTo(
                            context,
                            CommentsScreen(
                              likes: model.likes,
                              postId: model.postId,
                              postUid: model.uId,
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.chat,
                              size: 16,
                              color: Colors.orange,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${model.comments} ',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          navigateTo(
                            context,
                            CommentsScreen(
                              likes: model.likes,
                              postId: model.postId,
                              postUid: model.uId,
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage:
                                  NetworkImage('${userModel.image}'),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Write a comment ...',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // SocialCubit.get(context).postsId[index];
                        SocialUserModel? postUser =
                            SocialCubit.get(context).socialUserModel;
                        await SocialCubit.get(context).likedByMe(
                            postUser: postUser,
                            context: context,
                            postModel: model,
                            postId: model.postId);
                      },
                      child: Row(children: [
                        const Icon(
                          Icons.heart_broken,
                          color: Colors.deepOrange,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ]),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.share_outlined,
                            color: Colors.green[300],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Share',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
