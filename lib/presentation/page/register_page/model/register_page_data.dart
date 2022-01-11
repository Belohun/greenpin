import 'package:greenpin/presentation/page/register_page/model/register_page_enum.dart';
import 'package:greenpin/presentation/page/register_page/model/second_step_data.dart';

import 'first_step_data.dart';

class RegisterPageData {
  const RegisterPageData({
    required this.pages,
    required this.isValid,
    required this.currentPage,
    required this.firstStepData,
    required this.secondStepData,
    required this.isLoading,
  });

  final List<RegisterPageEnum> pages;
  final bool isLoading;
  final bool isValid;
  final RegisterPageEnum currentPage;
  final FirstStepData firstStepData;
  final SecondStepData secondStepData;

  factory RegisterPageData.initData(RegisterPageEnum currentPage) =>
      RegisterPageData(
        isLoading: false,
        pages: RegisterPageEnum.values,
        isValid: false,
        currentPage: currentPage,
        firstStepData: const FirstStepData(siteAgreementAccepted: false),
        secondStepData: SecondStepData.empty(),
      );

  int get currentIndex => pages.indexOf(currentPage);

  bool get isOnFirstPage => pages.first == currentPage;

  RegisterPageData copyWith({
    List<RegisterPageEnum>? pages,
    bool? isValid,
    RegisterPageEnum? currentPage,
    FirstStepData? firstStepData,
    SecondStepData? secondStepData,
    bool? isLoading,
  }) =>
      RegisterPageData(
        isLoading: isLoading ?? this.isLoading,
        pages: pages ?? this.pages,
        isValid: isValid ?? this.isValid,
        currentPage: currentPage ?? this.currentPage,
        firstStepData: firstStepData ?? this.firstStepData,
        secondStepData: secondStepData ?? this.secondStepData,
      );

  RegisterPageData validate(bool Function(RegisterPageData data) validator) =>
      copyWith(isValid: validator(this));
}
