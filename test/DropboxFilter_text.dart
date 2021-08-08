//https://www.dropbox.com/s/lrcxctdc1oac89r/Ibrahim%20Shaglil%20RF%20Resume%201.0.pdf?dl=1
// /.+?(?=dropbox.com)dropbox.com\/.+?(?=dl=)dl=1/gmi
import 'package:flutter_test/flutter_test.dart';

main() {
  var regex = r"https://www.dropbox.com/\S+?(?=dl=)dl=1";
  test("check if regex return false when string is random", () {
    var testString = "avlkjbvlafdv";
    var result = RegExp(regex).hasMatch(testString);
    expect(result, false);
  });
  test("check if regex return false when string is random url", () {
    var testString =
        "https://www.flaticon.com/search/2?word=error%20mobile&license=all&style=all&order_by=4&type=icon&k=1628258946037";
    var result = RegExp(regex).hasMatch(testString);
    expect(result, false);
  });
  test("check if regex return false when string has white space", () {
    var testString =
        "https://www.dropbox.com/s/lrcxctdc1 oac89r/Ibrahim%20Sh aglil%20RF%20Re sume%201.0 .pdf?dl=1";
    var result = RegExp(regex).hasMatch(testString);
    expect(result, false);
  });
  test("check if regex return false when string is dropbox and not direct link",
      () {
    var testString =
        "https://www.dropbox.com/s/lrcxctdc1oac89r/Ibrahim%20Shaglil%20RF%20Resume%201.0.pdf?dl=0";
    var result = RegExp(regex).hasMatch(testString);
    expect(result, false);
  });
  test("check if regex return false when string is null", () {
    var testString = null;
    var result = RegExp(regex).hasMatch(testString);
    expect(result, false);
  });
  test("check if regex return true when string is dropbox and direct link", () {
    var testString = "https://www.dropbox.com/s/8i1vv76racw7z6r/1.txt?dl=1";
    var result = RegExp(regex).hasMatch(testString);
    expect(result, true);
  });
}
