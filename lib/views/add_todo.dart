import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/constants/app_color.dart';
import '../common/enum/status_form_enum.dart';
import '../common/widgets/input_widget.dart';
import '../controllers/todo_controller.dart';
import 'card_widget.dart';
import 'submit_form.dart';

class AddTodoList extends GetView<TodoController> {
  const AddTodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    controller.initScrollController();
    return Obx(() {
      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColor.DEFAULT_COLOR,
          appBar: AppBar(
            title: Text(controller.addTodoTitle.value),
            elevation: 0,
            actions: [
              SizedBox.fromSize(
                size: const Size(50, 50),
                child: Material(
                  color: AppColor.DEFAULT_COLOR,
                  child: InkWell(
                    splashColor: AppColor.DEFAULT_COLOR,
                    onTap: () async {
                      Get.bottomSheet(
                          SubmitForm(statusForm: STATUS_FORM_ENUM.ADD));
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.add),
                        Text("Add", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          body: RefreshIndicator(
              onRefresh: () async {
                controller.refreshTodo(showMessage: true);
              },
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: AppColor.DEFAULT_COLOR,
                    ),
                    child: InputWidget(
                      onChanged: (e) async {
                        await controller.filterTodo(e);
                      },
                    ),
                  ),
                  controller.allTodoList.isEmpty
                      ? Expanded(
                          child: Center(
                            child: Text('No data 😢', style: TextStyle(color: AppColor.WHITE)),
                          ),
                        )
                      // ignore: prefer_const_constructors
                      : CardWidget() //* don`t use with const because it`s not rebuild
                ],
              )),
        ),
      );
    });
  }
}
