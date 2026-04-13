/// Book vertical sections; index matches [BookPortfolioReader] [PageView] order.
enum AppSectionRoute {
  cover(0, '/'),
  about(1, '/about'),
  skills(2, '/skills'),
  projects(3, '/projects'),
  experience(4, '/experience'),
  contact(5, '/contact');

  const AppSectionRoute(this.pageIndex, this.path);

  final int pageIndex;
  final String path;

  static AppSectionRoute fromPageIndex(int index) {
    return AppSectionRoute.values.firstWhere(
      (AppSectionRoute e) => e.pageIndex == index,
    );
  }
}
