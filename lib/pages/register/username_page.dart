import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:scribble/bloc/username/username_bloc.dart';
import 'package:scribble/utils/auth.dart';
import 'package:scribble/widgets/custom_button.dart';
import 'package:scribble/widgets/custom_text_field.dart';
import 'package:scribble/injection_container.dart';
import 'package:scribble/utils/constants.dart';

class UsernamePage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final UsernameBloc bloc = sl<UsernameBloc>();
  final Widget initialChild = const Text(
    "Let's start!",
    style: TextStyle(
      fontFamily: geologicaMedium,
      fontSize: 19,
      color: Colors.white,
    )
  );

  UsernamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: const EdgeInsets.all(15),
          color: Colors.black87,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Username", style: TextStyle(color: Colors.white, fontSize: 23), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: "Type in an username",
                  controller: controller,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                CustomButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    bloc.add(
                      SetUsernameOfUser(
                        number: Authentication.instance.auth.currentUser!.phoneNumber!,
                        username: controller.text
                      )
                    );
                  },
                  backgroundColor: Colors.purple.shade500,
                  child: BlocBuilder(
                    bloc: bloc,
                    builder: (BuildContext context, UsernameState state) {
                      if (state is UsernameLoading) {
                        return const Center(child: CupertinoActivityIndicator(color: Colors.white));
                      } else if (state is UsernameSetError) {
                        WidgetsBinding.instance.addPostFrameCallback((_){
                          Get.snackbar(
                            "Error",
                            state.message,
                            colorText: Colors.white,
                            icon: const Icon(Icons.warning_amber, color: Colors.red)
                          );
                        });

                        return initialChild;
                      } else if (state is UsernameSetSuccess) {
                        Get.snackbar(
                          "Success!",
                          "You are ready to go!",
                          colorText: Colors.white,
                          icon: const Icon(Icons.verified_outlined, color: Colors.green)
                        );

                        return initialChild;
                      }

                      return initialChild;
                    }
                  ),
                )
              ]
            )
          ),
        ),
      ),
    );
  }
}
