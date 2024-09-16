import 'package:ai_story/view/widget/custom_story_ui.dart';
import 'package:ai_story/view/widget/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../api/open_ai.dart';
import '../../models/apiData.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<OpenAiData> _dataList = [];
  bool _isLoading = false;
  final FlutterTts _flutterTts = FlutterTts();
  OpenAiData? _currentlyPlayingStory;

  @override
  void initState() {
    super.initState();
    _initTts();
    _controller.addListener(_onTextChanged);
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage("en-IN");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);

    _flutterTts.setCompletionHandler(() {
      setState(() {
        _currentlyPlayingStory = null;
      });
    });
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  Future<void> _addDataToList() async {
    if (_controller.text.isNotEmpty && !_isLoading) {
      setState(() {
        _isLoading = true;
      });

      String userInput = _controller.text;

      try {
        OpenAiData? data = await postRequest(userInput);

        if (data != null) {
          setState(() {
            OpenAiData newData = OpenAiData(
              prompt: userInput,
              result: data.result,
              status: data.status,
              serverCode: data.serverCode,
            );
            _dataList.insert(0, newData);
            _controller.clear();
          });
        } else {
          print('Error: No data received from API');
        }
      } catch (error) {
        print('Error fetching data: $error');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _togglePlayState(OpenAiData story) async {
    if (_currentlyPlayingStory == story) {
      await _flutterTts.stop();
      setState(() {
        _currentlyPlayingStory = null;
      });
    } else {
      await _flutterTts.stop();
      await _flutterTts.speak(story.result);
      setState(() {
        _currentlyPlayingStory = story;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("AI Story"),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _dataList.isEmpty
                  ? const Center(
                      child: Text(
                        'No data yet',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _dataList.length,
                      itemBuilder: (context, index) {
                        OpenAiData story = _dataList[index];
                        return StoryCard(
                          story: story,
                          flutterTts: _flutterTts,
                          currentlyPlayingStory: _currentlyPlayingStory,
                          onTogglePlay: _togglePlayState,
                        );
                      },
                    ),
            ),
            CustomInputField(
              controller: _controller,
              isLoading: _isLoading,
              onSend: _addDataToList,
            ),
          ],
        ),
      ),
    );
  }
}
