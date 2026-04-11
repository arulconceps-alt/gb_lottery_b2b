import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/common/widgets/app_bar_text_with_back.dart';
import 'package:gb_lottery_b2b/src/profile/bloc/profile_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late Map<String, TextEditingController> controllerMap;

  final List<String> labels = [
    'Name',
    'User ID',
    'Phone',
    'Pincode',
    'Address',
    'Email',
  ];

  @override
  void initState() {
    super.initState();
    final user = context.read<ProfileBloc>().state.user;

    controllerMap = {
      'Name': TextEditingController(text: user.name),
      'User ID': TextEditingController(text: user.id),
      'Phone': TextEditingController(text: user.phone),
      'Pincode': TextEditingController(text: ""),
      'Address': TextEditingController(text: ""),
      'Email': TextEditingController(text: user.email),
    };
  }

  @override
  void dispose() {
    for (var controller in controllerMap.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.updateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')),
          );
          context.pop();
        } else if (state.status == ProfileStatus.failure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF1C1B20),
        appBar: const AppBarTextWithBack(title: "Profile"),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: s(16)),
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      final user = state.user;
                      final initial = user.name.isNotEmpty
                          ? user.name[0].toUpperCase()
                          : "?";

                      return Column(
                        children: [
                          SizedBox(height: s(50)),
                          _buildProfileImage(s, initial),
                          SizedBox(height: s(12)),
                          Text(
                            user.name.isEmpty ? "Dealer" : user.name,
                            style: GoogleFonts.dmSans(
                              color: Colors.white,
                              fontSize: s(20),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: s(40)),
                          _buildDetailsCard(s),
                          SizedBox(height: s(107)),
                          _buildSubmitButton(
                            s,
                            state.status == ProfileStatus.updating,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(double Function(double) s, String initial) {
    return Center(
      child: Container(
        width: s(80),
        height: s(80),
        decoration: const ShapeDecoration(
          shape: OvalBorder(),
          color: ColorPalette.backgroundDark,
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                initial,
                style: GoogleFonts.dmSans(
                  fontSize: 28,
                  color: ColorPalette.whitetext,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: s(24),
                height: s(24),
                decoration: const BoxDecoration(
                  gradient: ColorPalette.buttonGradient,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(s(4)),
                  child: Image.asset(
                    "assets/images/profile/edit_icon.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard(double Function(double) s) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: s(16), horizontal: s(12)),
      decoration: BoxDecoration(
        color: ColorPalette.backgroundDark,
        borderRadius: BorderRadius.circular(s(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...labels.map((label) {
            final isEditable = label != 'User ID';
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: s(4)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "$label : ",
                        style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: s(16),
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.16,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: controllerMap[label],
                          enabled: isEditable,
                          style: GoogleFonts.dmSans(
                            color: isEditable ? Colors.white : Colors.grey,
                            fontSize: s(16),
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white.withOpacity(0.10),
                  thickness: 1,
                  height: s(10),
                ),
              ],
            );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Copy My Details',
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: s(16),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(s(8)),
                child: Image.asset(
                  "assets/images/profile/copy.png",
                  width: s(20),
                  height: s(20),
                  color: Colors.white,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(double Function(double) s, bool isUpdating) {
    return GestureDetector(
      onTap: isUpdating
          ? null
          : () {
              context.read<ProfileBloc>().add(
                UpdateProfile(
                  name: controllerMap['Name']!.text,
                  email: controllerMap['Email']!.text,
                  phone: controllerMap['Phone']!.text,
                ),
              );
            },
      child: Container(
        width: double.infinity,
        height: s(54),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
          ),
          borderRadius: BorderRadius.circular(s(8)),
        ),
        child: isUpdating
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                'Submit',
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: s(18),
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
