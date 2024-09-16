import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../models/apiData.dart';
import '../utils/app_color/colors.dart';

class StoryCard extends StatelessWidget {
  final OpenAiData story;
  final FlutterTts flutterTts;
  final OpenAiData? currentlyPlayingStory;
  final Function(OpenAiData) onTogglePlay;

  const StoryCard({
    super.key,
    required this.story,
    required this.flutterTts,
    required this.currentlyPlayingStory,
    required this.onTogglePlay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                story.prompt,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBlue,
                  decoration: TextDecoration.none,
                ),
                softWrap: true,
              ),
            ),
          ),
          Card(
            color: AppColors.darkBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: [
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  color: AppColors.darkGray,
                  margin: EdgeInsets.zero,
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Story",
                          style: TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            currentlyPlayingStory == story
                                ? CupertinoIcons.speaker_2
                                : CupertinoIcons.speaker_slash_fill,
                            color: AppColors.white,
                          ),
                          onPressed: () => onTogglePlay(story),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    story.result,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      color: AppColors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
