import 'dart:io';

// run
// dart path_to_this_file
// example: dart lib/create_svg_file.dart
// to create svg_name_constant.dart

void main() {
  String folderPath = 'assets/images/svg';

  List<FileSystemEntity> items = Directory(folderPath).listSync();

  List<File> files = items.whereType<File>().toList();

  List<String> filenames = files.map((e) => e.uri.pathSegments.last).toList();

  List<String> fieldnames = filenames
      .map((e) => "static const String ${_snakeToCamel(e).split('.')[0]} = '$e';")
      .toList();

  fieldnames.sort((a, b) => a.compareTo(b));

  String svgClassContent = "class SVGName {" + "\n";

  for (String name in fieldnames) {
    svgClassContent = svgClassContent + "  $name\n";
  }

  svgClassContent = svgClassContent + "}";

  _writeToFile('lib/core/constants/svg_name_constant.dart', svgClassContent);
}

String _snakeToCamel(String snakeCase) {
  List<String> parts = snakeCase.split('_');

  String camelCase = parts.first +
      parts.skip(1).map((e) => '${e[0].toUpperCase()}${e.substring(1)}').join();

  return camelCase;
}

void _writeToFile(String filePath, String content) {
  File file = File(filePath);

  RandomAccessFile openedFile = file.openSync(mode: FileMode.write);

  openedFile.writeStringSync(content);

  openedFile.closeSync();
}
