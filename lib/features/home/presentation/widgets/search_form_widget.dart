import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/export.dart';

class SearchFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController cityController;
  final bool isConnected;
  final VoidCallback onSearch;
  final Function({required bool isOffline}) showNoInternetMessage;

  const SearchFormWidget({
    super.key,
    required this.formKey,
    required this.cityController,
    required this.isConnected,
    required this.onSearch,
    required this.showNoInternetMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: cityController,
            hintText: 'Enter City Name',
            prefixIcon: Icons.location_city,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z\s]'),
              ),
            ],
            validator: (value) => Validator.displayCityValidator(value),
          ),
          verticalSpace(16),
          CustomTextButton(
            height: 50.h,
            background: isConnected ? AppColor.primaryColor : Colors.grey,
            customBorderRadius: BorderRadius.circular(15.r),
            onPressed: isConnected
                ? onSearch
                : () => showNoInternetMessage(isOffline: true),
            text: 'Search',
            customTextStyle: AppStyle.font18_600Weight.copyWith(
              color: Colors.white,
            ),
            isUpperCase: false,
          )
        ],
      ),
    );
  }
}
