import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? hintText;
  final bool autofocus;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;
  final String? errorText;
  final Color? fillColor;
  final bool isDense;
  final double borderRadius;
  final bool showCursor;
  final int? maxLength;
  final bool expands;
  final TextAlignVertical? textAlignVertical;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final bool autocorrect;
  final bool enableSuggestions;
  final TextInputAction? textInputAction;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final bool obscureText;
  final String obscuringCharacter;
  final Widget? counter;
  final Widget? prefix;
  final Widget? suffix;
  final String? prefixText;
  final String? suffixText;
  final TextStyle? prefixStyle;
  final TextStyle? suffixStyle;
  final bool showBorder;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters,
    this.readOnly = false,
    this.onTap,
    this.hintText,
    this.autofocus = false,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding,
    this.enabled = true,
    this.errorText,
    this.fillColor,
    this.isDense = false,
    this.borderRadius = 12.0,
    this.showCursor = true,
    this.maxLength,
    this.expands = false,
    this.textAlignVertical,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.textInputAction,
    this.strutStyle,
    this.textDirection,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.counter,
    this.prefix,
    this.suffix,
    this.prefixText,
    this.suffixText,
    this.prefixStyle,
    this.suffixStyle,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return TextFormField(
      controller: controller,
      obscureText: isPassword || obscureText,
      obscuringCharacter: obscuringCharacter,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      onTap: onTap,
      autofocus: autofocus,
      focusNode: focusNode,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      textCapitalization: textCapitalization,
      enabled: enabled,
      maxLength: maxLength,
      expands: expands,
      textAlignVertical: textAlignVertical,
      style: style ?? theme.textTheme.bodyMedium,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      textInputAction: textInputAction,
      strutStyle: strutStyle,
      textDirection: textDirection,
      showCursor: showCursor,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        errorText: errorText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : prefix,
        suffixIcon: suffixIcon ?? suffix,
        filled: true,
        fillColor: fillColor ?? theme.inputDecorationTheme.fillColor,
        isDense: isDense,
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        labelStyle: labelStyle ?? theme.inputDecorationTheme.labelStyle,
        hintStyle: hintStyle ?? theme.inputDecorationTheme.hintStyle,
        errorStyle: errorStyle ?? theme.inputDecorationTheme.errorStyle,
        counter: counter,
        prefixText: prefixText,
        suffixText: suffixText,
        prefixStyle: prefixStyle,
        suffixStyle: suffixStyle,
        border: showBorder 
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: theme.dividerColor),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide.none,
              ),
        enabledBorder: showBorder 
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: theme.dividerColor),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide.none,
              ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: theme.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: theme.disabledColor.withOpacity(0.2)),
        ),
      ),
    );
  }
}

