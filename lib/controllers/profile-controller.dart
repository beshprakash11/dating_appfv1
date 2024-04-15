import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_appfv1/models/person.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Rx<List<Person>> usersProfileList = Rx<List<Person>>([]);
  List<Person> get allUsersProfileList => usersProfileList.value;

  @override
  void onInit() {
    super.onInit();
    usersProfileList.bindStream(
      FirebaseFirestore.instance
          .collection("users")
          .where("uid",
              isNotEqualTo: FirebaseAuth
                  .instance.currentUser!.uid) //does not take my own id
          .snapshots()
          .map(
        (QuerySnapshot querySnapshot) {
          List<Person> profliesList = [];
          for (var eachProfile in querySnapshot.docs) {
            profliesList.add(Person.formDataSnapshot(eachProfile));
          }
          return profliesList;
        },
      ), // user data
    );
  }
}
