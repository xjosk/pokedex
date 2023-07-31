extension Capitalize on String {
  String get capitalizeFirstWord =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
}
