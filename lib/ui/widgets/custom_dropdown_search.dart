import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

class CustomDropdownSearch<T> extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?>? onChanged;
  final Color color;
  final Color outlineColor;
  final String Function(T)? itemAsString;
  final String? Function(T?)? validator;

  const CustomDropdownSearch({
    Key? key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.itemAsString,
    this.color = backgroundColor,
    this.outlineColor = mainGreyColor,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: outlineColor,
      ),
      borderRadius: BorderRadius.circular(6),
    );

    return DropdownSearch<T>(
      items: items,
      selectedItem: selectedItem,
      onChanged: onChanged,
      popupProps: const PopupProps.menu(
        showSearchBox: true,
      ),
      itemAsString: itemAsString,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          fillColor: color,
          filled: true,
          hintText: hintText,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder.copyWith(
            borderSide: const BorderSide(
              color: mainColor,
              width: 1.5,
            ),
          ),
          errorBorder: outlineInputBorder.copyWith(
            borderSide: const BorderSide(
              color: dangerColor,
            ),
          ),
          focusedErrorBorder: outlineInputBorder.copyWith(
            borderSide: const BorderSide(
              color: dangerColor,
              width: 1.5,
            ),
          ),
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
