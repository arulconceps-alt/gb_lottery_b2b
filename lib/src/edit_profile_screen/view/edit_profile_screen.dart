import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/common/widgets/appbar_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF0F1116),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(s(60) + MediaQuery.of(context).padding.top),
        child: AppbarWidget(s: s, title: "Profile", showBack: true),
      ),
      // SafeArea prevents the Submit button from hitting the device navigation bar
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: s(16)),
                child: Column(
                  children: [
                    SizedBox(height: s(50)), // Top spacing from Figma

                    // Profile Image Section
                    _buildProfileImage(s),

                    SizedBox(height: s(12)),

                    Text(
                      'Baranee',
                      style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontSize: s(20),
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: s(40)),

                    // Details Card
                    _buildDetailsCard(s),

                    // Extra space to ensure scrolling feels natural
                    SizedBox(height: s(20)),
                  ],
                ),
              ),
            ),

            // Submit Button pinned to the bottom
            _buildSubmitButton(context,s),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard(double Function(double) s) {
    final labels = ['Name : Baranee', 'Your ID :', 'Phone :', 'Pincode :', 'Address :', 'Email :'];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(s(16)),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(s(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Map the list to add Dividers between ALL items including the last one
          ...labels.map((label) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: s(4)),
                child: Text(
                  label,
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: s(16),
                    letterSpacing: 0.16,
                  ),
                ),
              ),
              Divider(color: Colors.white.withOpacity(0.10), thickness: 1, height: s(20)),
            ],
          )),

          // "Copy My Details" Row now has a divider above it automatically from the loop
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Copy My Details',
                style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(16)),
              ),
              Image.asset(
                "assets/images/profile/copy_icon.webp",
                width: s(20), height: s(20), color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildProfileImage(double Function(double) s) {
    return Center(
      child: Container(
        // Width and Height from Figma: 83.44px
        width: s(83.44),
        height: s(83.44),
        decoration: ShapeDecoration(
          shape: const OvalBorder(),
          // Radial Gradient overlay as per design specs
          gradient: RadialGradient(
            center: const Alignment(0.5, 0.5),
            radius: 0.68,
            colors: [
              Colors.white.withValues(alpha: 0),
              Colors.white.withValues(alpha: 0.5),
            ],
          ),
          image: const DecorationImage(
            image: AssetImage("assets/images/profile/avatar_img.webp"),
            fit: BoxFit.cover,
          ),
        ),
        // Alignment for the blue edit icon
        alignment: Alignment.bottomRight,
        child: Container(
          width: s(24),
          height: s(24),
          decoration: const BoxDecoration(
            color: Color(0xFF005AC1), // Brand blue
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(s(4)),
            child: Image.asset(
              "assets/images/profile/edit_icon.webp",
              width: s(16),
              height: s(16),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildSubmitButton(BuildContext context, double Function(double) s) {
    return Padding(
      padding: EdgeInsets.fromLTRB(s(16), s(10), s(16), s(20)),
      child: GestureDetector(
        onTap: () {
          // Navigates to the Customer Info screen
          context.push("/customer_info");
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
          child: Text(
            'Submit',
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: s(18),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
