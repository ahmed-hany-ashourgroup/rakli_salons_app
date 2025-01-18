class ServiceModel {
  String? title;
  String? description;
  num? price;
  ServiceState? state;
  Gender? gender;

  ServiceModel(
      {this.title, this.description, this.price, this.state, this.gender});
}

enum ServiceState { active, inactive }

enum Gender { male, female }
