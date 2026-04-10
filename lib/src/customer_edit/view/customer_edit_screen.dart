import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/common/models/customer_model.dart';
import 'package:gb_lottery_b2b/src/common/widgets/app_bar_text_with_back.dart';
import 'package:gb_lottery_b2b/src/common/widgets/custom_success_snackbar.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerEditScreen extends StatefulWidget {
  final CustomerModel customer;

  const CustomerEditScreen({super.key, required this.customer});

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

    final customer = widget.customer;
    final initialValues = [
      customer.name,
      customer.id,
      customer.phone,
      customer.pincode,
      customer.address ?? '',
      customer.email ?? ''
    ];

    controllers = List.generate(
      labels.length,
      (index) => TextEditingController(text: initialValues[index]),
    );
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF1C1B20),
      appBar: const AppBarTextWithBack(title: "Customer Edit"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: s(16)),
                child: Column(
                  children: [
                    SizedBox(height: s(50)),

                    // Profile Image Section
                    _buildName(s),

                    SizedBox(height: s(10)),

                    Text(
                      widget.customer.name,
                      style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontSize: s(20),
                        fontWeight: FontWeight.w500,
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
      padding: EdgeInsets.symmetric(vertical: s(16), horizontal: s(12)),
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
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.16,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: controllers[index],
                          enabled: labels[index] != 'User ID', // User ID is usually read-only
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
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
          GestureDetector(
            onTap: () {
              String details = "";
              for (int i = 0; i < labels.length; i++) {
                details += "${labels[i]}: ${controllers[i].text}\n";
              }
              Clipboard.setData(ClipboardData(text: details)).then((_) {
                if (mounted) {
                  AppSnackBar.show(
                    context,
                    message: "Customer details copied successfully!",
                    type: SnackBarType.success,
                  );
                }
              });
            },
            child: Row(
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
          color: ColorPalette.backgroundDark,
          shape: OvalBorder(),
        ),
        child: SizedBox(
          width: s(25),
          height: s(46),
          child: Center(
            child: Text(
              widget.customer.name.isNotEmpty 
                  ? widget.customer.name[0].toUpperCase()
                  : '?',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: s(38.4),
                fontWeight: FontWeight.w500,
                height: 1.0,
                letterSpacing: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(double Function(double) s) {
    return GestureDetector(
      onTap: () {
        // Here you would typically dispatch an update event to a Bloc
        context.pop();
      },
      child: Container(
        width: double.infinity,
        height: s(54),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)]),
          borderRadius: BorderRadius.circular(s(8)),
        ),
        child: Text(
          'Submit',
          style: GoogleFonts.dmSans(
              color: Colors.white, fontSize: s(18), fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
