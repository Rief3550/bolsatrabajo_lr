import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AppRatingBar extends StatelessWidget {
  final double rating;
  final double size;
  final bool readOnly;
  final ValueChanged<double>? onRatingUpdate;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool showLabel;
  final TextStyle? labelStyle;
  
  const AppRatingBar({
    super.key,
    required this.rating,
    this.size = 20,
    this.readOnly = true,
    this.onRatingUpdate,
    this.activeColor,
    this.inactiveColor,
    this.showLabel = true,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingBar.builder(
          initialRating: rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: size,
          ignoreGestures: readOnly,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: activeColor ?? Colors.amber,
          ),
          unratedColor: inactiveColor ?? Colors.grey.withOpacity(0.3),
          onRatingUpdate: onRatingUpdate ?? (_) {},
        ),
        if (showLabel) ...[
          const SizedBox(height: 4),
          Text(
            '$rating/5',
            style: labelStyle ?? theme.textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}

