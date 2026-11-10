import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Better Composition',
      'description':
          'Master professional composition techniques with live visual overlays directly in your viewfinder.',
      'image': 'assets/onboarding/composition.png',
    },
    {
      'title': 'Guided Photography',
      'description':
          'Receive real-time alignment and tilt guidance to pose, frame, and capture confident shots.',
      'image': 'assets/onboarding/guidance.png',
    },
    {
      'title': 'Save Your Favorites',
      'description':
          'Bookmark your favorite poses and scene setups for fast, effortless shooting anywhere.',
      'image': 'assets/onboarding/favorites.png',
    }
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _skipOnboarding() {
    context.go('/home');
  }

  void _completeOnboarding() {
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              // Top Bar: Skip button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _skipOnboarding,
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    ),
                  ),
                ),
              ),

              // Page Content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  children: _onboardingData.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxHeight: 220),
                            child: Image.asset(
                              item['image']!,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 48),
                          Text(
                            item['title']!,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.4,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 14),
                          Text(
                            item['description']!,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.45,
                              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 24),

              // Super-flat Page Indicator
              SmoothPageIndicator(
                controller: _pageController,
                count: _onboardingData.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: primaryColor,
                  dotColor: isDark ? Colors.white24 : const Color(0xFFE2E8F0),
                  dotHeight: 6,
                  dotWidth: 6,
                  spacing: 6,
                  expansionFactor: 3.5,
                ),
              ),

              const SizedBox(height: 36),

              // Action Buttons
              SizedBox(
                width: double.infinity,
                height: 50,
                child: _currentPage < _onboardingData.length - 1
                    ? OutlinedButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutCubic,
                          );
                        },
                        child: const Text('Next'),
                      )
                    : ElevatedButton(
                        onPressed: _completeOnboarding,
                        child: const Text('Get Started'),
                      ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
