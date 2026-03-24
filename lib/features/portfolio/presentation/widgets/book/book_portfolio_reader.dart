import 'package:flutter/material.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/portfolio_profile.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_cover_page.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_motion_inherited.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_paper_content.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_spread_page.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/paint/book_reader_thumb_painter.dart';

/// Swipeable book: cover then editorial spreads (yellow chapter + paper body).
class BookPortfolioReader extends StatefulWidget {
  final PortfolioProfile profile;

  const BookPortfolioReader({super.key, required this.profile});

  @override
  State<BookPortfolioReader> createState() => _BookPortfolioReaderState();
}

class _BookPortfolioReaderState extends State<BookPortfolioReader>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _organicMotion;
  int _pageIndex = 0;

  static const int _pageCount = 6;

  @override
  void initState() {
    super.initState();
    _organicMotion = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat(reverse: true);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _organicMotion.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BookMotionInherited(
      notifier: _organicMotion,
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() => _pageIndex = index);
              },
              children: [
                BookCoverPage(profile: widget.profile),
                BookSpreadPage(
                  chapterLines: const ['About Me'],
                  chapterNumber: '1',
                  paperChild: BookPaperContent.about(context, widget.profile),
                ),
                BookSpreadPage(
                  chapterLines: const ['Skills'],
                  chapterNumber: '2',
                  paperChild: BookPaperContent.skills(
                    context,
                    widget.profile.skills,
                  ),
                ),
                BookSpreadPage(
                  chapterLines: const ['Selected Projects'],
                  chapterNumber: '3',
                  paperChild: BookPaperContent.projects(
                    context,
                    widget.profile.projects,
                  ),
                ),
                BookSpreadPage(
                  chapterLines: const ['Work History'],
                  chapterNumber: '4',
                  paperChild: BookPaperContent.experience(
                    context,
                    widget.profile.experiences,
                  ),
                ),
                BookSpreadPage(
                  chapterLines: const ['Contact'],
                  chapterNumber: '5',
                  paperChild: BookPaperContent.contact(
                    context,
                    widget.profile.socialLinks,
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            minimum: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: AnimatedBuilder(
                animation: _organicMotion,
                builder: (BuildContext context, Widget? _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(_pageCount, (int i) {
                      final bool active = i == _pageIndex;
                      return GestureDetector(
                        key: ValueKey<String>('book_page_dot_$i'),
                        onTap: () {
                          _pageController.animateToPage(
                            i,
                            duration: const Duration(milliseconds: 320),
                            curve: Curves.easeOutCubic,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 8,
                          ),
                          child: CustomPaint(
                            size: Size(active ? 30 : 12, 12),
                            painter: BookReaderThumbPainter(
                              active: active,
                              phase: _organicMotion.value,
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
