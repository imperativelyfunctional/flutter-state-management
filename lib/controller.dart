import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Triple {
  final IconData data;
  final Color inner;
  final Color outer;

  Triple(this.data, this.inner, this.outer);
}

class Controller extends GetxController {
  var icon = 0.obs;

  switchIcon() {
    icon = ((++icon.value) % 4).obs;
  }
}
