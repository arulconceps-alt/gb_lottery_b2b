import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gb_lottery_b2b/src/add_customer/bloc/add_customer_bloc.dart';
import 'package:gb_lottery_b2b/src/add_customer/view/widgets/add_customer_form_section.dart';
import 'package:gb_lottery_b2b/src/add_customer/view/widgets/add_customer_type_selector.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/common/services/services_locator.dart';
import 'package:gb_lottery_b2b/src/common/widgets/app_bar_with_back.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCustomerPage extends StatelessWidget {
  const AddCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddCustomerBloc>(),
      child: const _AddCustomerPageContent(),
    );
  }
}

class _AddCustomerPageContent extends StatefulWidget {
  const _AddCustomerPageContent();

  @override
  State<_AddCustomerPageContent> createState() => _AddCustomerPageContentState();
}

class _AddCustomerPageContentState extends State<_AddCustomerPageContent> {
  final ScrollController _pageController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return BlocListener<AddCustomerBloc, AddCustomerState>(
      listener: (context, state) {
        if (state.status == AddCustomerStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          context.pop(); // Go back to customer list
        } else if (state.status == AddCustomerStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
          context.read<AddCustomerBloc>().add(const ResetStatus());
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF1C1B20),
        appBar: const AppBarWithBack(),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
          child: _doneButton(s),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: s(20)),
          child: SingleChildScrollView(
            controller: _pageController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: s(28)),
                Text(
                  "Select Customer or Moderator",
                  style: GoogleFonts.dmSans(
                    fontSize: s(18),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    color: ColorPalette.whitetext,
                  ),
                ),
                SizedBox(height: s(21)),
                const AddCustomerTypeSelector(),
                SizedBox(height: s(24)),
                AddCustomerFormSection(controller: _pageController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _doneButton(double Function(double) s) {
    return BlocSelector<AddCustomerBloc, AddCustomerState, AddCustomerStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        final isLoading = status == AddCustomerStatus.loading;
        return GestureDetector(
          onTap: isLoading
              ? null
              : () => context.read<AddCustomerBloc>().add(const SubmitCustomers()),
          child: Container(
            width: double.infinity,
            height: s(50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(s(10)),
              gradient: isLoading ? null : ColorPalette.buttonGradient,
              color: isLoading ? Colors.grey : null,
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      "Done",
                      style: GoogleFonts.dmSans(
                        fontSize: s(16),
                        fontWeight: FontWeight.w700,
                        color: ColorPalette.whitetext,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
