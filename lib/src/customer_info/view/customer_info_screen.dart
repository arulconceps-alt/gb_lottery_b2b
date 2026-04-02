
import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/common/widgets/appbar_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerEditScreen extends StatefulWidget {
  const CustomerEditScreen({super.key});

  @override
  State<CustomerEditScreen> createState() => _CustomerEditScreenState();
}

class _CustomerEditScreenState extends State<CustomerEditScreen> {
  late List<TextEditingController> controllers;

final List<String> labels = [
  'Name',
  'User ID',
  'Phone',
  'Pincode',
  'Address',
  'Email'
];

@override
void initState() {
  super.initState();

  final initialValues = [
    'Baranee',
    '',
    '',
    '',
    '',
    ''
  ];

  controllers = List.generate(
    labels.length,
    (index) => TextEditingController(text: initialValues[index]),
  );
}
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Scaffold(
        backgroundColor: const Color(0xFF1C1B20),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(s(60) + MediaQuery.of(context).padding.top),
        child: AppbarWidget(s: s, title: "Customer Edit", showBack: true),
      ),
      // SafeArea prevents the Submit button from hitting the device navigation bar
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                //physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: s(16)),
                child: Column(
                  children: [
                    SizedBox(height: s(50)), // Top spacing from Figma

                    // Profile Image Section
                    _buildName(s),

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

                    SizedBox(height: s(107)),
                      _buildSubmitButton(s),
                      SizedBox(height: s(20)),
                  ],
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
    padding: EdgeInsets.all(s(16)),
    decoration: BoxDecoration(
      color: ColorPalette.backgroundDark,
      borderRadius: BorderRadius.circular(s(20)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(labels.length, (index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: s(4)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${labels[index]} : ",
                      style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontSize: s(16),
                        letterSpacing: 0.16,
                      ),
                    ),

                    Expanded(
                      child: TextField(
                        controller: controllers[index],
                        maxLines: labels[index] == "Address" ? 1 : 1,
                        style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: s(16),
                        ),
                        decoration: InputDecoration(
                          // hintText: "Enter ${labels[index]}",
                          // hintStyle: GoogleFonts.dmSans(
                          //   color: Colors.white.withOpacity(0.5),
                          //   fontSize: s(16),
                          // ),
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
                height: s(20),
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
              ),
            ),
            Image.asset(
              "assets/images/profile/copy_icon.webp",
              width: s(20),
              height: s(20),
              color: Colors.white,
            ),
          ],
        ),
      ],
    ),
  );
}
  Widget _buildName(double Function(double) s) {
    return Center(
      child: Container(
        width: s(80),
        height: s(80),
        alignment: Alignment.center,
        decoration: const ShapeDecoration(
          color:  ColorPalette.backgroundDark,
          shape: OvalBorder(),
        ),
        child: SizedBox(
          // Fixed dimensions from your Figma specs
          width: s(25),
          height: s(46),
          child: Center(
            child: Text(
              'B',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: s(38.4), // Exact size from your specs
                fontWeight: FontWeight.w500, // Medium / 500
                height: 1.0, // Line height 100%
                letterSpacing: 0, // Letter spacing 0%
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildSubmitButton(double Function(double) s) {
    return Container(
      width: double.infinity,
      height: s(54),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)]),
        borderRadius: BorderRadius.circular(s(8)),
      ),
      child: Text(
        'Submit',
        style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(18), fontWeight: FontWeight.w600),
      ),
    );
  }
}
