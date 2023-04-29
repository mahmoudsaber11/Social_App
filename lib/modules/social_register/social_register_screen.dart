import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/social_register/cubit/cubit.dart';
import 'package:social_app/modules/social_register/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';

import 'package:social_app/shared/network/local/cache_helper.dart';

// ignore: must_be_immutable
class ShopRegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  ShopRegisterScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    String uId = '';

    return BlocProvider(
        create: (context) => SocialRegisterCubit(),
        child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
          listener: (context, state) {
            if (state is SocialCreateUserErrorState) {
              showToast(text: state.error, state: ToastStates.ERROR);
            }
            if (state is SocialCreateUserSuccessState) {
              CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
              ).then((value) async {
                SocialCubit.get(context).getUserData(uId);
                showToast(
                  text: 'Welcome in Social App',
                  state: ToastStates.SUCCESS,
                );
                navigateAndFinish(context, const SocialLayout(0));
              });
            }
          },
          builder: (context, state) {
            return Scaffold(
                body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.dark,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF1f1f1f),
                      Color(0xFF141414),
                      Color(0xFF0d0d0d),
                      Color(0xFF0a0a0a),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'REGISTER',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          color: Colors.deepOrange,
                                        ),
                                  ),
                                  Text(
                                    'register now to communicate with friends',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.orange),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: bxDecorationStyle,
                                    child: TextFormField(
                                      style: const TextStyle(
                                        color: Colors.orange,
                                      ),
                                      controller: nameController,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Invalid name!';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'User Name',
                                          labelStyle: lblStyle,
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: Colors.deepOrange,
                                          )),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: bxDecorationStyle,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !value.contains('@')) {
                                          return 'Invalid email!';
                                        }
                                        return null;
                                      },
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      style: const TextStyle(
                                        color: Colors.orange,
                                      ),
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Email Address',
                                          labelStyle: lblStyle,
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Colors.deepOrange,
                                          )),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: bxDecorationStyle,
                                    height: 70,
                                    child: TextFormField(
                                      controller: passwordController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      style: const TextStyle(
                                        color: Colors.orange,
                                      ),
                                      decoration: InputDecoration(
                                        suffix: IconButton(
                                          onPressed: () {
                                            SocialRegisterCubit.get(context)
                                                .changePasswordVisibility();
                                          },
                                          icon: Icon(
                                            SocialRegisterCubit.get(context)
                                                .suffix,
                                            color: Colors.deepOrange,
                                          ),
                                        ),
                                        border: const OutlineInputBorder(),
                                        labelText: 'Password',
                                        labelStyle: lblStyle,
                                        prefixIcon: const Icon(
                                          Icons.lock,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Invalid password!';
                                        }
                                        return null;
                                      },
                                      obscureText:
                                          SocialRegisterCubit.get(context)
                                              .isPassword,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: bxDecorationStyle,
                                    height: 70,
                                    child: TextFormField(
                                      controller: confirmPasswordController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      style: const TextStyle(
                                        color: Colors.orange,
                                      ),
                                      decoration: InputDecoration(
                                        suffix: IconButton(
                                          onPressed: () {
                                            SocialRegisterCubit.get(context)
                                                .changePasswordVisibility();
                                          },
                                          icon: Icon(
                                            SocialRegisterCubit.get(context)
                                                .suffix,
                                            color: Colors.deepOrange,
                                          ),
                                        ),
                                        border: const OutlineInputBorder(),
                                        labelText: 'Confirm Password',
                                        labelStyle: lblStyle,
                                        prefixIcon: const Icon(
                                          Icons.lock,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Invalid password!';
                                        }
                                        return null;
                                      },
                                      obscureText: true,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: bxDecorationStyle,
                                    child: TextFormField(
                                      style: const TextStyle(
                                        color: Colors.orange,
                                      ),
                                      controller: phoneController,
                                      keyboardType: TextInputType.phone,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Invalid phone!';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Phone',
                                          labelStyle: lblStyle,
                                          prefixIcon: Icon(
                                            Icons.phone,
                                            color: Colors.deepOrange,
                                          )),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  ConditionalBuilder(
                                    condition:
                                        state is! SocialRegisterLoadingState,
                                    builder: (context) => defaultButton(
                                      function: (() {
                                        if (formKey.currentState!.validate()) {
                                          SocialRegisterCubit.get(context)
                                              .userRegister(
                                                  name: nameController.text,
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text,
                                                  phone: phoneController.text);
                                        }
                                      }),
                                      text: 'register',
                                    ),
                                    fallback: (context) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          },
        ));
  }
}
