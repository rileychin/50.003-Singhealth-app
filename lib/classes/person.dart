class Person {

  //basic features and functions for classes
  String name,email,id;

  Person(name,email,id){
    this.name = name;
    this.email = email;
    this.id = id;
  }

  String getName() {
    return this.name;
  }

  String getEmail() {
    return this.email;
  }

  String getId() {
    return this.id;
  }


}