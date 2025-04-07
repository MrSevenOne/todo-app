class OnboardingModel {
  final String image;
  final String title;
  final String subtitle;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

List<OnboardingModel> onboardingData = [
  OnboardingModel(
    image: 'assets/onboarding/onboarding1.png',
    title: 'Manage your tasks',
    subtitle: 'You can easily manage all of your daily tasks in DoMe for free',
  ),
  OnboardingModel(
    image: 'assets/onboarding/onboarding2.png',
    title: 'Create daily routine',
    subtitle: 'In Uptodo  you can create your personalized routine to stay productive',
  ),
  OnboardingModel(
    image: 'assets/onboarding/onboarding3.png',
    title: 'Orgonaize your tasks',
    subtitle: 'You can organize your daily tasks by adding your tasks into separate categories',
  ),
];
