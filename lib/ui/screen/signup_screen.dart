import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets/blocs/auth/sign_in/sign_in_bloc.dart';
import 'package:pets/blocs/auth/sign_up/sign_up_bloc.dart';
import 'package:pets/ui/screen/home_screen.dart';
import 'package:pets/ui/widget/custom_button.dart';
import 'package:pets/ui/widget/custom_card.dart';
import 'package:pets/ui/widget/custom_input_form_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObscure = true;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (Supabase.instance.client.auth.currentUser != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    });
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1450778869180-41d0601e046e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1886&q=80',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: CustomCard(
                  color: Colors.blue[50],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: BlocProvider<SignUpBloc>(
                      create: (context) => SignUpBloc(),
                      child: BlocConsumer<SignUpBloc, SignUpState>(
                        listener: (context, state) {
                          if (state is SignUpFailureState) {
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                title: Text("Register Failed"),
                                content: Text(
                                  'Please check your email and password and try again.',
                                ),
                              ),
                            );
                          } else if (state is SignUpSuccessState) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return Form(
                            key: _formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                const Center(
                                  child: Branding(),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  height: 40,
                                  thickness: 0.5,
                                ),
                                Text(
                                  'Register',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Enter the details below to register',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomInputFormField(
                                  controller: _emailController,
                                  prefixIcon: Icons.email,
                                  labelText: 'Email',
                                  validator: (value) {
                                    if (value != null &&
                                        value.trim().isNotEmpty) {
                                      return null;
                                    } else {
                                      return "Please enter an email";
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomInputFormField(
                                  controller: _passwordController,
                                  isObscure: isObscure,
                                  labelText: 'Password',
                                  prefixIcon: Icons.lock,
                                  validator: (value) {
                                    if (value != null &&
                                        value.trim().isNotEmpty) {
                                      return null;
                                    } else {
                                      return "Please enter password";
                                    }
                                  },
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      isObscure = !isObscure;
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      isObscure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.pink,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomInputFormField(
                                  controller: _confirmPasswordController,
                                  isObscure: isObscure,
                                  labelText: 'Confirm Password',
                                  prefixIcon: Icons.lock,
                                  validator: (value) {
                                    if (value != null &&
                                        value.trim().isNotEmpty &&
                                        _passwordController.text == value) {
                                      return null;
                                    } else {
                                      return "Password is not matching";
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomInputFormField(
                                  controller: _nameController,
                                  labelText: 'Name',
                                  prefixIcon: Icons.person,
                                  validator: (value) {
                                    if (value != null &&
                                        value.trim().isNotEmpty) {
                                      return null;
                                    } else {
                                      return "Please enter name";
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomInputFormField(
                                  controller: _phoneController,
                                  labelText: 'Phone',
                                  prefixIcon: Icons.phone_android,
                                  validator: (value) {
                                    if (value != null &&
                                        value.trim().isNotEmpty &&
                                        value.length == 10) {
                                      return null;
                                    } else {
                                      return "Please enter phone number";
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                  label: 'Register',
                                  buttonColor: Colors.blue,
                                  labelColor: Colors.white,
                                  isLoading: state is SignInLoadingState,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      // String email =
                                      //     _emailController.text.trim();
                                      // String password =
                                      //     _passwordController.text.trim();
                                      // String phone =
                                      //     _phoneController.text.trim();
                                      // String name = _nameController.text.trim();

                                      // BlocProvider.of<SignUpBloc>(context).add(
                                      //   SignUpEvent(
                                      //     email: email,
                                      //     password: password,
                                      //     name: name,
                                      //     phone: phone,
                                      //   ),
                                      // );
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Branding extends StatelessWidget {
  const Branding({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.pets,
          color: Colors.pink,
          size: 50,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'PetsMart',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
