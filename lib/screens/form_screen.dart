import 'package:fithub_v1/layout/main_layout.dart';
import 'package:fithub_v1/providers/form_controller.dart';
import 'package:fithub_v1/widgets/training_info_form_form_1_widget.dart';
import 'package:fithub_v1/widgets/form_progress_bar_widget.dart';
import 'package:fithub_v1/widgets/height_weight_heart_rate_form.dart';
import 'package:fithub_v1/widgets/interview_completion_widget.dart';
import 'package:fithub_v1/widgets/name_email_form.dart';
import 'package:fithub_v1/widgets/questions_view_widget.dart';
import 'package:fithub_v1/widgets/thank_you_widget.dart';
import 'package:fithub_v1/widgets/training_info_form_form_2_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FormController formController = Get.put(FormController());

    return MainLayout(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Obx(() {
          final int currentIndex = formController.currentWidgetIndex.value;
          final WidgetWithImage currentWidgetWithImage =
              _getWidgetWithImageForIndex(currentIndex);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentIndex < formController.totalWidgets)
                FormProgressBarWidget(formController: formController),
              const SizedBox(height: 20),
              QuestionsViewWidget(
                image: currentWidgetWithImage.image,
                child: currentWidgetWithImage.child,
              ),
              const SizedBox(height: 20),
            ],
          );
        }),
      ),
    );
  }

  WidgetWithImage _getWidgetWithImageForIndex(int index) {
    final List<WidgetWithImage> widgetsWithImages = [
      WidgetWithImage(
        child: const NameEmailForm(),
        image: 'assets/images/form/undraw_Profile_data_re_v81r.png',
      ),
      WidgetWithImage(
        child: const HeightWeightHeartRateForm(),
        image: 'assets/images/form/undraw_Personal_data_re_ihde.png',
      ),
      WidgetWithImage(
        child: const TrainingInfoForm1(),
        image: 'assets/images/form/undraw_track_and_field_33qn.png',
      ),
      WidgetWithImage(
        child: const TrainingInfoForm2(),
        image: 'assets/images/form/undraw_Check_boxes_re_v40f.png',
      ),
      WidgetWithImage(
        child: const InterviewCompletionWidget(),
        image: 'assets/images/form/undraw_Letter_re_8m03.png',
      ),
      WidgetWithImage(
        child: const ThankYouWidget(),
        image: 'assets/images/form/undraw_Time_management_re_tk5w.png',
      ),
    ];

    return widgetsWithImages[index < widgetsWithImages.length ? index : 0];
  }
}

class WidgetWithImage {
  final Widget child;
  final String image;

  WidgetWithImage({required this.child, required this.image});
}


/*
class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FormController formController = Get.put(FormController());

    return MainLayout(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Obx(() {
          final int currentIndex = formController.currentWidgetIndex.value;
          final Widget currentChild = _getChildForIndex(currentIndex);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentIndex < formController.totalWidgets)
                FormProgressBarWidget(formController: formController),
              const SizedBox(height: 20),
              QuestionsViewWidget(
                image: _getImageForIndex(currentIndex),
                child: currentChild,
              ),
              const SizedBox(height: 20),
            ],
          );
        }),
      ),
    );
  }

  String _getImageForIndex(int index) {
    switch (index) {
      case 0:
        return 'assets/images/form/undraw_Profile_data_re_v81r.png';
      case 1:
        return 'assets/images/form/undraw_Personal_data_re_ihde.png';
      case 2:
        return 'assets/images/form/undraw_Letter_re_8m03.png';
      case 3:
        return 'assets/images/form/undraw_Timeline_re_aw6g.png';
      default:
        return 'assets/images/form/undraw_Personal_data_re_ihde.png';
    }
  }

  Widget _getChildForIndex(int index) {
    switch (index) {
      case 0:
        return const NameEmailForm();
      case 1:
        return const HeightWeightHeartRateForm();
      case 2:
        return const TrainingInfoForm1();
      case 3:
        return const TrainingInfoForm2();
      case 4:
        return const InterviewCompletionWidget();
      case 5:
        return const ThankYouWidget();
      default:
        return const NameEmailForm();
    }
  }
}

*/
/*
class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FormController formController = Get.put(FormController());

    return MainLayout(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final int currentIndex = formController.currentQuestionIndex.value;
          final Widget currentChild = _getChildForIndex(currentIndex);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentIndex < formController.totalQuestions)
                FormProgressBarWidget(formController: formController),
              const SizedBox(height: 20),
              QuestionsViewWidget(
                image: _getImageForIndex(currentIndex),
                child: currentChild,
              ),
              const SizedBox(height: 20),
            ],
          );
        }),
      ),
    );
  }

  String _getImageForIndex(int index) {
    switch (index) {
      case 0:
        return 'assets/images/form/undraw_Profile_data_re_v81r.png';
      case 1:
        return 'assets/images/form/undraw_Personal_data_re_ihde.png';
      case 2:
        return 'assets/images/form/undraw_Letter_re_8m03.png';
      case 3:
        return 'assets/images/form/undraw_Timeline_re_aw6g.png';
      default:
        return 'assets/images/form/undraw_Personal_data_re_ihde.png';
    }
  }

  Widget _getChildForIndex(int index) {
    switch (index) {
      case 0:
        return const NameEmailForm();
      case 1:
        return const HeightWeightHeartRateForm();
      case 2:
        return const TrainingInfoForm1();
      case 3:
        return const TrainingInfoForm2();
      case 4:
        return const InterviewCompletionWidget();
      case 5:
        return const ThankYouWidget();
      default:
        return const NameEmailForm();
    }
  }
}

*/


/*
class FormScreen extends StatelessWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FormController formController = Get.put(FormController());

    return MainLayout(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final int currentIndex = formController.currentQuestionIndex.value;
          final Widget currentChild = _getChildForIndex(currentIndex);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentIndex < 3)
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      width: (MediaQuery.of(context).size.width - 32) *
                          (formController.currentQuestionIndex.value /
                              formController.totalQuestions),
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              QuestionsViewWidget(
                image: _getImageForIndex(currentIndex),
                child: currentChild,
              ),
              const SizedBox(height: 20),
            ],
          );
        }),
      ),
    );
  }

  String _getImageForIndex(int index) {
    // Devuelve la imagen correspondiente al índice
    switch (index) {
      case 0:
        return 'assets/images/form/undraw_Profile_data_re_v81r.png';
      case 1:
        return 'assets/images/form/undraw_Personal_data_re_ihde.png';
      case 2:
        return 'assets/images/form/undraw_Letter_re_8m03.png';
      case 3:
        return 'assets/images/form/undraw_Timeline_re_aw6g.png';
      default:
        return 'assets/images/form/undraw_Personal_data_re_ihde.png';
    }
  }

  Widget _getChildForIndex(int index) {
    switch (index) {
      case 0:
        return const NameEmailForm();
      case 1:
        return const HeightWeightHeartRateForm();
      case 2:
        return const InterviewCompletionWidget();
      case 3:
        return const ThankYouWidget();
      default:
        return const NameEmailForm();
    }
  }
}
*/



/*
class FormScreen extends StatelessWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FormController formController = Get.put(FormController());

    return MainLayout(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final int currentIndex = formController.currentQuestionIndex.value;
          final Widget currentChild = _getChildForIndex(currentIndex);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    width: (MediaQuery.of(context).size.width - 32) *
                        (formController.currentQuestionIndex.value /
                            formController.totalQuestions),
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              QuestionsViewWidget(
                image: _getImageForIndex(currentIndex),
                child: currentChild,
              ),
              const SizedBox(height: 20),
            ],
          );
        }),
      ),
    );
  }

  String _getImageForIndex(int index) {
    // Devuelve la imagen correspondiente al índice
    switch (index) {
      case 0:
        return 'assets/images/form/undraw_Profile_data_re_v81r.png';
      case 1:
        return 'assets/images/form/undraw_Personal_data_re_ihde.png';
      case 2:
        return 'assets/images/form/undraw_Letter_re_8m03.png';
      case 3:
        return 'assets/images/form/undraw_Timeline_re_aw6g.png';
      default:
        return 'assets/images/form/undraw_Personal_data_re_ihde.png';
    }
  }

  Widget _getChildForIndex(int index) {
    switch (index) {
      case 0:
        return const InterviewCompletionWidget(); //NameEmailForm();
      case 1:
        return const HeightWeightHeartRateForm();
      case 2:
        return const InterviewCompletionWidget();
      default:
        return const NameEmailForm();
    }
  }
}
*/


/*
class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FormController formController = Get.put(FormController());

    return MainLayout(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final int currentIndex = formController.currentQuestionIndex.value;
          final Widget currentChild = _getChildForIndex(currentIndex);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    width: (MediaQuery.of(context).size.width - 32) *
                        (formController.currentQuestionIndex.value /
                            formController.totalQuestions),
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              QuestionsViewWidget(
                image: _getImageForIndex(currentIndex),
                child: currentChild,
              ),
              const SizedBox(height: 20),
            ],
          );
        }),
      ),
    );
  }

  String _getImageForIndex(int index) {
    // Devuelve la imagen correspondiente al índice
    switch (index) {
      case 0:
        return 'assets/images/form/undraw_Profile_data_re_v81r.png';
      case 1:
        return 'assets/images/form/undraw_Personal_data_re_ihde.png';
      case 2:
        return 'assets/images/form/undraw_Letter_re_8m03.png';
      case 3:
        return 'assets/images/form/undraw_Personal_data_re_ihde.png';
      default:
        return 'assets/images/form/undraw_Personal_data_re_ihde.png';
    }
  }

  Widget _getChildForIndex(int index) {
    switch (index) {
      case 0:
        return const NameEmailForm();
      case 1:
        return const HeightWeightHeartRateForm();
      default:
        return const NameEmailForm();
    }
  }
}

*/

/*import 'package:fithub_v1/layout/main_layout.dart';
import 'package:fithub_v1/providers/form_controller.dart';
import 'package:fithub_v1/widgets/height_weight_heart_rate_form.dart';
import 'package:fithub_v1/widgets/name_email_form.dart';
import 'package:fithub_v1/widgets/questions_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FormController formController = Get.put(FormController());

    return MainLayout(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final int currentIndex = formController.currentQuestionIndex.value;
          final Widget currentChild = _getChildForIndex(currentIndex);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    width: (MediaQuery.of(context).size.width - 32) *
                        (formController.currentQuestionIndex.value /
                            formController.totalQuestions),
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              QuestionsViewWidget(
                image: _getImageForIndex(currentIndex),
                child: currentChild,
              ),
              const SizedBox(height: 20),
            ],
          );
        }),
      ),
    );
  }

  String _getImageForIndex(int index) {
    // Devuelve la imagen correspondiente al índice
    switch (index) {
      case 0:
        return 'assets/images/form/undraw_Profile_data_re_v81r.png';
      case 1:
        return 'assets/images/form/undraw_Personal_file_re_5joy.png';
      case 2:
        return 'assets/images/form/undraw_Personal_file_re_5joy.png';
      case 3:
        return 'assets/images/form/undraw_Personal_file_re_5joy.png';
      default:
        return 'assets/images/form/undraw_Personal_file_re_5joy.png';
    }
  }

  Widget _getChildForIndex(int index) {
    // Devuelve el widget correspondiente al índice
    switch (index) {
      case 0:
        return const NameEmailForm();
      case 1:
        return const HeightWeightHeartRateForm();
      default:
        return const NameEmailForm();
    }
  }
}

*/
