import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/core/constant/custom_button.dart';
import 'package:real_state/core/constant/custom_textformfield.dart';
import 'package:real_state/feature/profile/presentation/cubit/profile_cubit.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _currentPasswordKey = GlobalKey<FormFieldState>();
  final _newPasswordKey = GlobalKey<FormFieldState>();
  final _confirmPasswordKey = GlobalKey<FormFieldState>();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onChangePasswordPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileCubit>().changePassword(
        currentPassword: _currentPasswordController.text.trim(),
        newPassword: _newPasswordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password'), centerTitle: true),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
            context.read<ProfileCubit>().getProfile();
          } else if (state is ChangePasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is ChangePasswordLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),

                  CustomTextformfeild(
                    formFieldKey: _currentPasswordKey,
                    controller: _currentPasswordController,
                    labelText: 'Current Password',
                    hintText: 'Enter current password',
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(Icons.lock_outline),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your current password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  CustomTextformfeild(
                    formFieldKey: _newPasswordKey,
                    controller: _newPasswordController,
                    labelText: 'New Password',
                    hintText: 'Enter new password',
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(Icons.lock_reset),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a new password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  CustomTextformfeild(
                    formFieldKey: _confirmPasswordKey,
                    controller: _confirmPasswordController,
                    labelText: 'Confirm New Password',
                    hintText: 'Confirm new password',
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(Icons.check_circle_outline),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your new password';
                      }
                      if (value != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 35),

                  CustomButton(
                    data: 'Update Password',
                    isLoading: isLoading,
                    onTap: _onChangePasswordPressed,
                    fontSize: 16, 
                    txtcolor: Colors.white,
                    color:  const Color(
                      0xFF1597A8,
                    ),
                    bordercolor: const Color(
                      0xFF1597A8,
                    ),
                    width: double.infinity,
                    height: 54, 
                    borderRadius: 16,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
