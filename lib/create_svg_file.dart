import 'dart:io';

// run 
// dart path_to_this_file
// example: dart lib/create_svg_file.dart
// to create svg_name_constant.dart

void main() {
  // Replace '/path/to/your/folder' with the actual path to your folder
  String folderPath = 'assets/images/svg';

  // Get a list of FileSystemEntity objects representing items in the folder
  List<FileSystemEntity> items = Directory(folderPath).listSync();

  // Filter out only files
  List<File> files = items.whereType<File>().toList();

  List<String> filenames = files.map((e) => e.uri.pathSegments.last).toList();

  List<String> fieldnames = filenames.map((e) => "static String ${_snakeToCamel(e).split('.')[0]} = '${e}';").toList();

  String svgClassContent = "class SVGName {" + "\n";


  // Print the file names
  for (String name in fieldnames) {
    svgClassContent = svgClassContent + "  $name\n";
  }

  svgClassContent = svgClassContent + "}";

  _writeToFile('lib/core/constants/svg_name_constant.dart', svgClassContent);
}

String _snakeToCamel(String snakeCase) {
  List<String> parts = snakeCase.split('_');
  String camelCase = parts.first + parts.skip(1).map((e) => '${e[0].toUpperCase()}${e.substring(1)}').join();
  return camelCase;
}

void _writeToFile(String filePath, String content) {
  File file = File(filePath);

  // Open the file in write mode (creates the file if it doesn't exist)
  RandomAccessFile openedFile = file.openSync(mode: FileMode.write);

  // Write content to the file
  openedFile.writeStringSync(content);

  // Close the file
  openedFile.closeSync();
}
