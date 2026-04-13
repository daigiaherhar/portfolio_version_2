import 'package:flutter/material.dart';
import 'package:portfolio_version_2/core/router/app_section_route.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/portfolio_profile.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_cover_page.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_motion_inherited.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_paper_about.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_paper_contact.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_paper_experience.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_paper_projects.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_paper_skills.dart';
import 'package:portfolio_version_2/core/theme/const_colors.dart';
import 'package:portfolio_version_2/core/theme/const_sizes.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_spread_page.dart';

/// Swipeable book: vertical [PageView] (cover + spreads).
class BookPortfolioReader extends StatefulWidget {
  final PortfolioProfile profile;
  final AppSectionRoute currentSection;
  final ValueChanged<AppSectionRoute> onSectionChanged;

  const BookPortfolioReader({
    super.key,
    required this.profile,
    required this.currentSection,
    required this.onSectionChanged,
  });

  @override
  State<BookPortfolioReader> createState() => _BookPortfolioReaderState();
}

class _BookPortfolioReaderState extends State<BookPortfolioReader>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _organicMotion;
  late int _pageIndex;
  bool _ignorePageChange = false;

  static const int _pageCount = 6;

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.currentSection.pageIndex;
    _organicMotion = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat(reverse: true);
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _organicMotion.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BookPortfolioReader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentSection != widget.currentSection) {
      _syncToSection(widget.currentSection);
    }
  }

  void _syncToSection(AppSectionRoute section) {
    final int targetPage = section.pageIndex;
    if (_pageIndex == targetPage) {
      return;
    }
    _ignorePageChange = true;
    setState(() => _pageIndex = targetPage);
    if (!_pageController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        _pageController.jumpToPage(targetPage);
      });
      return;
    }
    _pageController.animateToPage(
      targetPage,
      duration: const Duration(milliseconds: 380),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BookMotionInherited(
      notifier: _organicMotion,
      child: Row(
        children: [
          Expanded(
            child: PageView(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              onPageChanged: (int index) {
                final AppSectionRoute nextSection =
                    AppSectionRoute.fromPageIndex(index);
                if (_ignorePageChange) {
                  _ignorePageChange = false;
                  if (_pageIndex != index) {
                    setState(() => _pageIndex = index);
                  }
                  return;
                }
                setState(() => _pageIndex = index);
                if (nextSection != widget.currentSection) {
                  widget.onSectionChanged(nextSection);
                }
              },
              children: [
                BookCoverPage(profile: widget.profile),
                BookSpreadPage(
                  chapterLines: const ['About Me'],
                  chapterNumber: '1',
                  paperChild: BookPaperAbout(profile: widget.profile),
                ),
                BookSpreadPage(
                  chapterLines: const ['Skills'],
                  chapterNumber: '2',
                  paperChild: BookPaperSkills(skills: widget.profile.skills),
                  // colorsPager: Colors.white.withValues(alpha: 0.4),
                ),
                BookSpreadPage(
                  chapterLines: const ['Selected Projects'],
                  chapterNumber: '3',
                  paddingPaper: EdgeInsets.only(
                    top: ConstSizes.s16,
                    bottom: ConstSizes.s16,
                    right: ConstSizes.s16,
                  ),

                  paperChild: BookPaperProjects(
                    projects: widget.profile.projects,
                  ),
                ),
                BookSpreadPage(
                  chapterLines: const ['Work History'],
                  chapterNumber: '4',
                  paperChild: BookPaperExperience(
                    experiences: widget.profile.experiences,
                  ),
                ),
                BookSpreadPage(
                  chapterLines: const ['Contact'],
                  chapterNumber: '5',
                  paperChild: BookPaperContact(
                    links: widget.profile.socialLinks,
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            minimum: const EdgeInsets.only(bottom: ConstSizes.s8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: ConstSizes.s12, vertical: ConstSizes.s10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(ConstSizes.s32),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 0.5,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: ConstSizes.s12, horizontal: ConstSizes.s6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(_pageCount, (int i) {
                    final bool active = i == _pageIndex;
                    return GestureDetector(
                      key: ValueKey<String>('book_page_dot_$i'),
                      onTap: () {
                        _pageController.animateToPage(
                          i,
                          duration: const Duration(milliseconds: 380),
                          curve: Curves.easeOutCubic,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: ConstSizes.s8,
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 280),
                          curve: Curves.easeOutCubic,
                          width: active ? ConstSizes.s10 : ConstSizes.s8,
                          height: active ? ConstSizes.s24 : ConstSizes.s8,
                          decoration: BoxDecoration(
                            color: active 
                              ? ConstColors.yellow 
                              : Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(ConstSizes.s6),
                            boxShadow: active ? [
                              BoxShadow(
                                color: ConstColors.yellow.withValues(alpha: 0.3),
                                blurRadius: 8,
                                spreadRadius: 1,
                              )
                            ] : [],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
