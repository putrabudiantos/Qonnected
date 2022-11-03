import 'package:get/get.dart';
import 'package:qonnected_app/controller/activity_controller.dart';
import 'package:qonnected_app/controller/coworkers_controller.dart';
import 'package:qonnected_app/controller/init_controller.dart';


class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InitController>(() => InitController());
    Get.lazyPut<ActivityController>(() => ActivityController());
    Get.lazyPut<CoWorkersController>(() => CoWorkersController());
  }
}
