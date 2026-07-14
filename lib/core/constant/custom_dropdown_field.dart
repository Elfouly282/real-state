import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import '../../../../../core/utils/app_colors.dart';
import 'custom_textformfield.dart';

class CustomDropdownField extends StatefulWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final double? width;
  final Widget? icon;
  final FormFieldValidator<String>? validator;
  final String? hintText;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.width,
    this.icon,
    this.validator,
    this.hintText,
  });

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.value ?? '';
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 1.sw,
      child: GestureDetector(
        onTap: () => _showDropdown(),
        child: AbsorbPointer(
          child: CustomTextformfeild(
            controller: _textEditingController,
            keyboardType: TextInputType.text,
            validator: widget.validator,
            formFieldKey: widget.key,
            labelText: widget.label,
            hintText: widget.hintText ?? 'Select an option',
            borderRadius: 48.r,
            // suffixIcon:
            //     widget.icon ??
            //     Icon(
            //       Icons.arrow_drop_down,
            //       size: 24.w,
            //     ),
            onChanged: (value) {
              // This will be called when the text changes, but we handle the main logic in _showDropdown
            },
          ),
        ),
      ),
    );
  }

  void _showDropdown() async {
    List<SelectedListItem<String>> dropdownItems = widget.items
        .map((item) => SelectedListItem<String>(data: item))
        .toList();

    await DropDownState<String>(
      dropDown: DropDown<String>(
        data: dropdownItems,
        isDismissible: true,
        bottomSheetTitle: Text(
          widget.label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
        submitButtonText: 'Done',
        submitButtonStyle: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        clearButtonText: 'Clear',
        enableMultipleSelection: false,
        onSelected: (selectedItems) {
          if (selectedItems.isNotEmpty) {
            setState(() {
              _textEditingController.text = selectedItems.first.data;
            });
            widget.onChanged(selectedItems.first.data);
          } else {
            setState(() {
              _textEditingController.text = '';
            });
            widget.onChanged(null);
          }
        },
      ),
    ).showModal(context);
  }
}
