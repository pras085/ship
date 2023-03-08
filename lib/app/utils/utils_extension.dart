extension StringExtension on String {
  String capital() {
    String result = "";
    final s = this.split(" ");
    for (var o in s) {
      result += "${o[0].toUpperCase()}${o.substring(1).toLowerCase()}";
    }
    return result;
  }
}

extension ListExtension on List {

  String implode() {
    String result = "";
    for (int i=0;i<this.length;i++) {
      result += "${this[i]}";
      if (i!=this.length-1) result += ", ";
    }
    return result;
  }

}