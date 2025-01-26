import 'package:flutter/material.dart';
import 'package:perplexity_clone/services/chat_web_service.dart';
import 'package:perplexity_clone/theme/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SourcesSection extends StatefulWidget {
  const SourcesSection({super.key});

  @override
  State<SourcesSection> createState() => _SourcesSectionState();
}

class _SourcesSectionState extends State<SourcesSection> {
  bool isLoading = true;
  List searchResults = [
    {
      'title': 'DeepSeek R1 vs. OpenAI o1: Which AI Model Suits You Best?',
      'url':
          'https://medium.com/@vijaygadhave2014/deepseek-r1-vs-openai-o1-which-ai-model-suits-you-best-26cadc4bb937#:~:text=Competitive%20Programming%20(Codeforces%20Percentile)%3A,handling%20algorithmic%20and%20coding%20challenges.',
    },
    {
      'title': 'DeepSeek R1 vs OpenAI o1: Which One is Faster, Cheaper and Smarter?',
      'url':
          'https://www.analyticsvidhya.com/blog/2025/01/deepseek-r1-vs-openai-o1/',
    },
    {
      'title': 'DeepSeek R1 vs OpenAI o1 : The AI Underdog That’s Eating OpenAI’s Lunch',
      'url':
          'https://medium.com/@cognidownunder/deepseek-r1-vs-openai-o1-the-ai-underdog-thats-eating-openai-s-lunch-7cb72eac8458',
    },
  ];

  @override
  void initState() {
    super.initState();
    ChatWebService().searchResultStream.listen((data) {
      setState(() {
        searchResults = data['data'];
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.source_outlined,
              color: Colors.white70,
            ),
            SizedBox(width: 8),
            Text(
              "Sources",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        Skeletonizer(
          enabled: isLoading,
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: searchResults.map((res) {
              return Container(
                width: 150,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      res['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      res['url'],
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
