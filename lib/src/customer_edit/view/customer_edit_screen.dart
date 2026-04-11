import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/common/models/customer_model.dart';
import 'package:gb_lottery_b2b/src/common/services/services_locator.dart';
import 'package:gb_lottery_b2b/src/common/widgets/app_bar_text_with_back.dart';
import 'package:gb_lottery_b2b/src/common/widgets/custom_success_snackbar.dart';
import 'package:gb_lottery_b2b/src/customerslist/repo/customer_list_repository.dart';
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
  bool _isLoading = false;

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
      customer.pincode ?? '',
      customer.address ?? '',
      customer.email ?? ''
    ];

    controllers = List.generate(
      labels.length,
      (index) {
        final ctrl = TextEditingController(text: initialValues[index]);
        if (index == 0) {
          // Listen to name changes to update avatar reactively
          ctrl.addListener(() => setState(() {}));
        }
        return ctrl;
      },
    );
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _handleUpdate() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final name = controllers[0].text.trim();
      final phone = controllers[2].text.trim();
      final pincode = controllers[3].text.trim();
      final address = controllers[4].text.trim();
      final email = controllers[5].text.trim();

      if (name.isEmpty || phone.isEmpty) {
        throw Exception("Name and Phone are mandatory");
      }

      if (phone.length != 10) {
        throw Exception("Phone number must be exactly 10 digits");
      }

      final Map<String, dynamic> data = {
        "name": name,
        "phone": phone,
      };

      // Email is optional in UI, but if provided, it should be valid string
      if (email.isNotEmpty) data["email"] = email;
      if (pincode.isNotEmpty) data["pincode"] = pincode;
      if (address.isNotEmpty) data["address"] = address;

      // Log update action for diagnostics
      debugPrint("CustomerEditScreen::_handleUpdate::Updating ID: ${widget.customer.id} with data: $data");

      await getIt<CustomerListRepository>().updateAgent(
        widget.customer.id,
        data,
      );

      if (mounted) {
        AppSnackBar.show(
          context,
          message: "Customer updated successfully!",
          type: SnackBarType.success,
        );
        context.pop(true); // Return true to trigger list refresh
      }
    } catch (e) {
      debugPrint("CustomerEditScreen::_handleUpdate::Error: $e");
      if (mounted) {
        AppSnackBar.show(
          context,
          message: e.toString().replaceAll("Exception: ", ""),
          type: SnackBarType.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    final String displayName = controllers[0].text.isEmpty ? widget.customer.name : controllers[0].text;

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

                    // Reactive Avatar based on the Name field
                    _buildAvatar(displayName, s),

                    SizedBox(height: s(10)),

                    Text(
                      displayName,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontSize: s(20),
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: s(40)),

                    // Details Card Container
                    _buildDetailsCard(s),

                    SizedBox(height: s(40)),
                    _buildSubmitButton(s),
                    SizedBox(height: s(40)),
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
      padding: EdgeInsets.symmetric(vertical: s(16), horizontal: s(s(12) < 12 ? 12 : 12)),
      decoration: BoxDecoration(
        color: ColorPalette.backgroundDark,
        borderRadius: BorderRadius.circular(s(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(labels.length, (index) {
            final isEditable = labels[index] != 'User ID';
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: s(8)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: s(80),
                        child: Text(
                          "${labels[index]}: ",
                          style: GoogleFonts.dmSans(
                            color: ColorPalette.darktext,
                            fontSize: s(14),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: controllers[index],
                          enabled: isEditable,
                          keyboardType: _getKeyboardType(labels[index]),
                          maxLength: labels[index] == 'Phone' ? 10 : null,
                          inputFormatters: labels[index] == 'Phone' 
                              ? [FilteringTextInputFormatter.digitsOnly] 
                              : null,
                          style: GoogleFonts.dmSans(
                            color: Colors.white.withOpacity(isEditable ? 1.0 : 0.4),
                            fontSize: s(14),
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            counterText: "",
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (index != labels.length - 1)
                  Divider(
                    color: Colors.white.withOpacity(0.05),
                    thickness: 1,
                    height: 1,
                  ),
              ],
            );
          }),
          SizedBox(height: s(12)),
          _buildCopyButton(s),
        ],
      ),
    );
  }

  TextInputType _getKeyboardType(String label) {
    if (label == 'Phone' || label == 'Pincode') return TextInputType.number;
    if (label == 'Email') return TextInputType.emailAddress;
    return TextInputType.text;
  }

  Widget _buildCopyButton(double Function(double) s) {
    return GestureDetector(
      onTap: () {
        String details = "Customer Details:\n";
        for (int i = 0; i < labels.length; i++) {
          details += "${labels[i]}: ${controllers[i].text}\n";
        }
        Clipboard.setData(ClipboardData(text: details)).then((_) {
          if (mounted) {
            AppSnackBar.show(context, message: "Copied to clipboard!", type: SnackBarType.success);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: s(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Copy My Details',
              style: GoogleFonts.dmSans(
                color: ColorPalette.primary,
                fontSize: s(14),
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(Icons.copy, color: ColorPalette.primary, size: s(16)),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String name, double Function(double) s) {
    return Center(
      child: Container(
        width: s(100),
        height: s(100),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: ColorPalette.surface,
          shape: BoxShape.circle,
        ),
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: GoogleFonts.lato(
            color: ColorPalette.primary,
            fontSize: s(40),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(double Function(double) s) {
    return GestureDetector(
      onTap: _handleUpdate,
      child: Container(
        width: double.infinity,
        height: s(50),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: _isLoading ? null : ColorPalette.buttonGradient,
          color: _isLoading ? Colors.grey : null,
          borderRadius: BorderRadius.circular(s(10)),
        ),
        child: _isLoading 
          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
          : Text(
              'Update Profile',
              style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(16), fontWeight: FontWeight.bold),
            ),
      ),
    );
  }
}
