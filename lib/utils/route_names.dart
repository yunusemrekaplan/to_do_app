enum RouteName {
  initial,
  splash,
  home,
  profile,
  login,
  register,
  addTask,
  detailTask,
}

extension RouteNamesExtension on RouteName {
  String get name {
    switch (this) {
      case RouteName.initial:
        return '/initial';
      case RouteName.splash:
        return '/splash';
      case RouteName.home:
        return '/home';
      case RouteName.login:
        return '/login';
      case RouteName.register:
        return '/register';
      case RouteName.profile:
        return '/profile';
      case RouteName.addTask:
        return '/addTask';
      case RouteName.detailTask:
        return '/detailTask';
    }
  }
}
