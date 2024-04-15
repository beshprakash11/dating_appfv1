import 'package:dating_appfv1/models/person.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Rx<List<Person>> usersProfileList = Rx<List<Person>>([]);
  List<Person> get allUsersProfileList => usersProfileList.value;

  @override
  void onInit() {
    super.onInit();
  }
}
