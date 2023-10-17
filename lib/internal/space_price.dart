class SpacePrice {
  static String getSpacePrice(int price) {
    String temp = price.toString();
    if (temp.length == 6) {
      temp = temp.substring(0, 3) + " " + temp.substring(3, 6);
    } else if (temp.length == 5) {
      temp = temp.substring(0, 2) + " " + temp.substring(2, 5);
    } else if (temp.length == 4) {
      temp = temp.substring(0, 1) + " " + temp.substring(1, 4);
    }
    return temp;
  }
}
