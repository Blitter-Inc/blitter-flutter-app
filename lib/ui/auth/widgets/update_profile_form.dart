import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

import 'package:blitter_flutter_app/data/blocs.dart';
import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/data/repositories.dart';
import 'package:blitter_flutter_app/data/types.dart';
import 'package:blitter_flutter_app/ui/shared.dart';
import './avatar.dart';

class UpdateProfileForm extends StatefulWidget {
  final AsyncCallback initializeHandler;

  const UpdateProfileForm({
    Key? key,
    required this.initializeHandler,
  }) : super(key: key);

  @override
  _UpdateProfileFormState createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _upiController;
  late TextEditingController _bioController;
  late String? avatar;
  late File selectedAvatar;
  bool avatarSelectorMode = false;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _upiController = TextEditingController();
    _bioController = TextEditingController();
    super.initState();
  }

  Future _pickImage() async {
    try {
      final image = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (image == null) return;
      setState(() {
        avatarSelectorMode = true;
        selectedAvatar = File(image.files.single.path!);
      });
    } on Exception catch (e) {
      print('Failed to pick image: $e');
    }
  }

  ImageProvider? _getImage() {
    if (avatarSelectorMode) {
      return FileImage(selectedAvatar);
    } else if (avatar != null) {
      return NetworkImage(avatar!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = context.read<AuthBloc>().state.user;
    avatar = userState?.avatar;

    return Form(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 85, bottom: 20),
        child: Column(
          children: [
            Avatar(
                getImage: _getImage,
                pickImage: _pickImage,
                name: userState?.name),
            const SizedBox(height: 45),
            TranslucentTextFormFieldContainer(
              paddingHorizontal: 5,
              child: TextFormField(
                controller: _nameController..text = userState?.name ?? '',
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  label: const Text('Name'),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TranslucentTextFormFieldContainer(
              paddingHorizontal: 5,
              child: TextFormField(
                controller: _emailController..text = userState?.email ?? '',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  label: const Text('Email'),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TranslucentTextFormFieldContainer(
              paddingHorizontal: 5,
              child: TextFormField(
                controller: _upiController..text = userState?.upi ?? '',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  label: const Text('VPA (UPI Address for payments)'),
                  prefixIcon: Icon(
                    Icons.location_on_sharp,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TranslucentTextFormFieldContainer(
              paddingHorizontal: 5,
              child: TextFormField(
                controller: _bioController..text = userState?.bio ?? '',
                textCapitalization: TextCapitalization.sentences,
                maxLines: 3,
                decoration: InputDecoration(
                  label: const Text('Bio'),
                  prefixIcon: Icon(
                    Icons.info,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            GradientButton(
              title: ' Submit ',
              onPressed: () async {
                context.read<APIRepository>().authState =
                    context.read<AuthBloc>().state;
                final JsonMap payload = {
                  'name': _nameController.text,
                  'email': _emailController.text,
                  'upi': _upiController.text,
                  'bio': _bioController.text,
                };
                if (avatarSelectorMode) {
                  payload['avatar'] = selectedAvatar.path;
                }
                final cubit = context.read<SigninCubit>();
                cubit.setProfileDataJson(payload);
                await widget.initializeHandler();
              },
            ),
          ],
        ),
      ),
    );
  }
}
