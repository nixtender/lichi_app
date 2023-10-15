class HexColor {
  // String valueColor;

  // HexColor(this.valueColor);

  static getIntColor(String valueColor) {
    int value = int.parse(valueColor, radix: 16);
    value |= 0xFF000000;
    return value;
  }
}
