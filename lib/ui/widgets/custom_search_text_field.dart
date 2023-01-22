import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../app/themes/app_colors.dart';
import '../../utils/debounce.dart';
import 'custom_textfield_outline.dart';

class CustomSearchTextField extends HookWidget {
  final String? hintText;
  final String? labelText;
  final ValueChanged<String>? onSearch;
  final Function(String)? onFieldSubmitted;
  final Function()? onClear;
  final bool autoFocus;
  final Duration duration;

  const CustomSearchTextField({
    super.key,
    this.onSearch,
    this.hintText,
    this.labelText,
    this.onFieldSubmitted,
    this.onClear,
    this.autoFocus = false,
    this.duration = const Duration(milliseconds: 1000),
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final focusNode = useFocusNode();

    final debounce = Debounce(duration);
    final showClearButton = useState(false);

    useEffect(() {
      controller.addListener(() {
        if (controller.text.isNotEmpty) {
          showClearButton.value = true;
        } else {
          showClearButton.value = false;
          onSearch?.call(controller.text);
          onClear?.call();
          return;
        }

        debounce.call(() {
          if (controller.text.isNotEmpty) onSearch?.call(controller.text);
        });
      });

      if (autoFocus) focusNode.requestFocus();

      return;
    }, []);

    return CustomTextFieldOutline(
      controller: controller,
      focusNode: focusNode,
      hintText: hintText,
      outlineColor: mainColor,
      textInputAction: TextInputAction.search,
      prefixIcon: const SizedBox.shrink(
        child: Center(child: Icon(Icons.search)),
      ),
      suffixIcon: showClearButton.value
          ? IconButton(
              icon: const Icon(
                Icons.clear,
                color: mainColor,
              ),
              onPressed: () {
                controller.clear();
              },
            )
          : null,
    );
  }
}
