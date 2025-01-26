import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:perplexity_clone/services/chat_web_service.dart';
import 'package:perplexity_clone/theme/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AnswerSection extends StatefulWidget {
  const AnswerSection({super.key});

  @override
  State<AnswerSection> createState() => _AnswerSectionState();
}

class _AnswerSectionState extends State<AnswerSection> {
  bool isLoading = true;
  String fullResponse = '''
As of the latest update in the highly anticipated AI model showdown between **Deepseek R1** and **OpenAI O1**, the competition stands at a fascinating juncture. The event, held at the **Global AI Summit Arena** on **October 15, 2024**, has drawn significant attention from tech enthusiasts and industry experts worldwide.

---

## Competition Overview
- **Opening Round**: Deepseek R1 and OpenAI O1 were pitted against each other in a series of tasks designed to test their capabilities in natural language processing, problem-solving, and creative generation.
- **Initial Performance**: 
  - **Deepseek R1** showcased exceptional efficiency in **real-time data processing** and **contextual understanding**, scoring high in tasks requiring rapid adaptation.
  - **OpenAI O1** demonstrated its strength in **creative content generation** and **complex reasoning**, particularly excelling in tasks involving abstract thinking and long-form content creation.

---

## Task Highlights
- **Task 1: Real-Time Query Resolution**:
  - Deepseek R1 outperformed OpenAI O1, delivering faster and more accurate responses to user queries, particularly in technical and analytical domains.
  - OpenAI O1, while slightly slower, provided more detailed and nuanced answers, especially in open-ended questions.

- **Task 2: Creative Storytelling**:
  - OpenAI O1 took the lead in this round, crafting a compelling narrative with rich character development and emotional depth.
  - Deepseek R1 produced a concise and engaging story but was noted for its focus on logical consistency over creative flair.

- **Task 3: Problem-Solving in Unstructured Scenarios**:
  - Both models performed admirably, but Deepseek R1 edged ahead with its ability to quickly identify patterns and propose actionable solutions.
  - OpenAI O1, while thorough, took longer to process and respond to the unstructured data.

---

## Current Standings
- **Deepseek R1**: Leading in **efficiency** and **technical accuracy**, with a strong showing in tasks requiring speed and precision.
- **OpenAI O1**: Dominating in **creativity** and **depth of response**, particularly in tasks demanding abstract thinking and long-form content generation.

---

## Key Observations
- **Strengths**:
  - Deepseek R1: Speed, adaptability, and technical prowess.
  - OpenAI O1: Creativity, depth, and nuanced understanding.
- **Weaknesses**:
  - Deepseek R1: Slightly less emphasis on emotional and creative depth.
  - OpenAI O1: Slower response times in time-sensitive tasks.

---

## Next Steps
The competition will continue with additional rounds focusing on **multimodal capabilities** (image and text integration), **ethical decision-making**, and **user interaction simulations**. Both models are expected to push their limits further, with the outcome remaining uncertain.

The AI community eagerly awaits the next phase of this groundbreaking showdown, as both Deepseek R1 and OpenAI O1 continue to redefine the boundaries of artificial intelligence.[1][2][4]
''';

  @override
  void initState() {
    super.initState();
    ChatWebService().contentStream.listen((data) {
      if (isLoading) {
        fullResponse = "";
      }
      setState(() {
        fullResponse += data['data'];
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Perplexity',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Skeletonizer(
          enabled: isLoading,
          child: Markdown(
            data: fullResponse,
            shrinkWrap: true,
            styleSheet:
                MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
              codeblockDecoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              code: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
