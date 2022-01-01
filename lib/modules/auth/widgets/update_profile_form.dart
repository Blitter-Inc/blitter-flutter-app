import 'package:flutter/material.dart';

import '../../auth/widgets/avatar.dart';
import '../../home/screens/dashboard_screen.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/translucent_text_form_field_container.dart';

class UpdateProfileForm extends StatefulWidget {
  const UpdateProfileForm({Key? key}) : super(key: key);

  @override
  _UpdateProfileFormState createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _bioController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.only(top: 85),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            const Avatar(),
            const SizedBox(height: 45),
            TranslucentTextFormFieldContainer(
              paddingHorizontal: 5,
              child: TextFormField(
                controller: _nameController,
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
                controller: _emailController,
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
            const SizedBox(height: 20),
            TranslucentTextFormFieldContainer(
              paddingHorizontal: 5,
              child: TextFormField(
                controller: _bioController,
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
              onPressed: () {
                Navigator.of(context).popAndPushNamed(DashboardScreen.route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
