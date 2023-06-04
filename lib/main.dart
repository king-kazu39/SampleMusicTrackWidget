import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const int minCounter = 0;
  static const int maxCounter = 2;
  int _counter = minCounter;

  void _incrementCounter() {
    setState(() {
      if (_counter != maxCounter) {
        _counter++;
        return;
      }
      _counter = minCounter;
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            height: 60,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TrackName(
                  trackId: musics[_counter].id,
                  text: musics[_counter].trackName,
                  height: 30,
                  maxWidth: MediaQuery.of(context).size.width - 50,
                ),
                Text(
                  musics[_counter].artistName,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'increment',
        child: const Icon(Icons.track_changes_outlined),
      ),
    );
  }
}

class TrackName extends StatelessWidget {
  final int trackId;
  final String text;
  final double height;
  final double maxWidth;

  const TrackName({
    super.key,
    required this.trackId,
    required this.text,
    required this.height,
    required this.maxWidth,
  });

  bool isOverFlowed({
    required String text,
    required TextStyle style,
    required double maxWidth,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(
        minWidth: 0,
        maxWidth: maxWidth,
      );
    return textPainter.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(fontSize: 20);

    if (!isOverFlowed(text: text, style: style, maxWidth: maxWidth)) {
      return Text(text, style: style);
    }

    return BasicMarquee(
      height: height,
      text: text,
      trackId: trackId.toString(),
      style: style,
    );
  }
}

class BasicMarquee extends StatelessWidget {
  final double height;
  final String text;
  final String trackId;
  final TextStyle style;

  const BasicMarquee({
    super.key,
    required this.height,
    required this.text,
    required this.trackId,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            child: Marquee(
              key: Key(trackId),
              text: text,
              style: style,
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 90.0,
              startAfter: const Duration(seconds: 1),
              pauseAfterRound: const Duration(seconds: 1),
            ),
          ),
        ],
      ),
    );
  }
}

class MyMusic {
  final int id;
  final String trackName;
  final String artistName;

  const MyMusic({
    required this.id,
    required this.trackName,
    required this.artistName,
  });
}

const List<MyMusic> musics = [
  MyMusic(
    id: 1,
    trackName:
        '鈴懸の木の道で「君の微笑みを夢に見る」と言ってしまったら僕たちの関係はどう変わってしまうのか、僕なりに何日か考えた上でのやや気恥ずかしい結論のようなもの',
    artistName: 'AKB48',
  ),
  MyMusic(
    id: 2,
    trackName:
        'それでも暮らしは続くから 全てを 今 忘れてしまう為には 全てを 今 知っている事が条件で 僕にはとても無理だから 一つずつ忘れて行く為に 愛する人達と手を取り 分け合って せめて思い出さないように 暮らしを続けて行くのです',
    artistName: 'BEGIN',
  ),
  MyMusic(
    id: 3,
    trackName: 'み',
    artistName: 'きゃりーぱみゅぱみゅ',
  ),
];
