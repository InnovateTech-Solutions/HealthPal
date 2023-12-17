class NuserModel {
  late String name;
  late String nat;
  late int age;

  NuserModel({required this.name, required this.age, required this.nat});

  tojson() {
    return {'Name': name, 'nat': nat, 'age': age};
  }
}
