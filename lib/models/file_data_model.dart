import 'dart:typed_data';

class FileDataModel {
  final String name;
  final int bytes;
  Uint8List? data;
  String? url;
  String? text;

  FileDataModel({
    required this.name,
    required this.bytes,
    this.data,
    this.url,
    this.text,
  });

  String get size {
    final kb = bytes / 1024;
    final mb = kb / 1024;
    return mb > 1
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
  }

  FileDataModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        bytes = json['bytes'],
        url = json['url'],
        text = json['text'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'bytes': bytes,
        'url': url,
        'text': text,
      };

  @override
  String toString() {
    return 'FileDataModel{name: $name, bytes: $bytes, url: $url}';
  }
}
