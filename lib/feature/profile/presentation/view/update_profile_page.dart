import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/core/constant/custom_button.dart';
import 'package:real_state/core/constant/custom_textformfield.dart';
import 'package:real_state/feature/profile/domain/entity/profile_entity.dart';
import 'package:real_state/feature/profile/presentation/cubit/profile_cubit.dart';



class UpdateProfilePage extends StatefulWidget {
  final ProfileEntity currentProfile;

  const UpdateProfilePage({super.key, required this.currentProfile});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _locationController;

  // مفاتيح FormFieldKey الخاصة بـ CustomTextformfeild
  final _nameKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _phoneKey = GlobalKey<FormFieldState>();
  final _locationKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.currentProfile.name);
    _emailController = TextEditingController(text: widget.currentProfile.email);
    _phoneController = TextEditingController(text: widget.currentProfile.phone);
    _locationController = TextEditingController(
      text: widget.currentProfile.location,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileCubit>().updateProfile(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            location: _locationController.text.trim(),
            phone: _phoneController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Information'),
        centerTitle: true,
      ),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is UpdateProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully'),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.pop(context);

            context.read<ProfileCubit>().getProfile();
          } else if (state is UpdateProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                CustomTextformfeild(
                  formFieldKey: _nameKey,
                  controller: _nameController,
                  labelText: 'Full Name',
                  hintText: 'Enter your name',
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

               
                CustomTextformfeild(
                  formFieldKey: _emailKey,
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

              
                CustomTextformfeild(
                  formFieldKey: _phoneKey,
                  controller: _phoneController,
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone_outlined),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

              
                CustomTextformfeild(
                  formFieldKey: _locationKey,
                  controller: _locationController,
                  labelText: 'Location',
                  hintText: 'Enter your location',
                  keyboardType: TextInputType.streetAddress,
                  prefixIcon: const Icon(Icons.location_on_outlined),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

               
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    final isLoading = state is UpdateProfileLoading;

                    return CustomButton(
                      data: 'Save Changes',
                      isLoading: isLoading,
                      onTap: _onSave,
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
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}