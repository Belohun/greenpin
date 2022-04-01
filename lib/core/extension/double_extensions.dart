extension NullableDoubleExtension on double? {
  String safeFormattedString({
    int? fractionsDigits,
    bool? fractionsAlwaysVisible,
  }) {
    if (this == null) {
      return '';
    }
    return this!.formattedPriceString(fractionsDigits: fractionsDigits);
  }
}

extension DoubleExtension on double {
  String roundedStringWithSpaces({int spaceInterval = 3}) {
    final roundedString = round().toStringAsFixed(0);

    final buffer = StringBuffer();
    for (var i = roundedString.length - 1; i >= 0; i--) {
      buffer.write(roundedString[i]);

      final position = roundedString.length - i;

      if (i != 0 && position % spaceInterval == 0) {
        buffer.write(' ');
      }
    }
    return buffer.toString().split('').reversed.join('');
  }

  String formattedPriceString({
    int? fractionsDigits,
    bool? fractionsAlwaysVisible,
  }) {
    final containsZeroFractions = ceil() == floor();
    if (containsZeroFractions && fractionsAlwaysVisible != true) {
      return toStringAsFixed(0);
    }
    final localizatedString = toStringAsFixed(fractionsDigits ?? 2).replaceAll('.', ',');
    return '$localizatedString zł'; //TODO change if new currencies added
  }
}
