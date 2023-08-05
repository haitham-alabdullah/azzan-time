// ignore_for_file: hash_and_equals

class Method {
  final String id;
  final String title;

  Method(this.id, this.title);

  @override
  bool operator ==(Object other) {
    return (other is Method) && other.id == id;
  }

  @override
  String toString() {
    return '$id--$title';
  }

  factory Method.fromStore(String lang) {
    return Method(lang.split('--')[0], lang.split('--')[1]);
  }
}
