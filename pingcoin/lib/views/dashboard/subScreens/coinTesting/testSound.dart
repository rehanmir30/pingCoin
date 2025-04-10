import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:ffmpeg_kit_flutter_full/ffmpeg_kit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pingcoin/constants/colors.dart';
import 'package:pingcoin/controllers/coinController.dart';
import 'package:pingcoin/widgets/ad.dart';
import 'package:pingcoin/widgets/customButton.dart';
import 'package:pingcoin/widgets/customSnackbar.dart';
import 'package:pingcoin/widgets/infoButton.dart';

import '../../../../controllers/authController.dart';
import '../../../../models/coinModel.dart';
import '../../../../services/coinTestingService.dart';

class TestSound extends StatefulWidget {
  CoinModel coinModel;

  TestSound(this.coinModel, {super.key});

  @override
  State<TestSound> createState() => _TestSoundState();
}

class _TestSoundState extends State<TestSound> {
  bool isTesting = false;
  bool isTested = false;
  bool? testPass;

  final FlutterSoundRecord _recorder = FlutterSoundRecord();
  List<double> _amplitudes = [];
  String? _lastRecordingPath;
  int _secondsRemaining = 0;
  late Timer _timer;
  late Timer _amplitudeTimer;

  bool liked = false;
  Icon likeIcon = Icon(
    Icons.favorite_border,
    color: rWhite,
  );

  List<double> soundData = [];
  List<double> _recordedWaveformData = [];

  @override
  void initState() {
    super.initState();
    if (Get.find<AuthController>().userModel!.favorites.contains(widget.coinModel.id)) {
      setState(() {
        likeIcon = Icon(
          Icons.favorite,
          color: rRed,
        );
        liked = true;
      });
    }
    processAudio();
  }

  Future<void> processAudio() async {
    try {
      setState(() {

      });

      final ref = FirebaseStorage.instance.refFromURL(widget.coinModel.coinAudio);
      final tempDir = await getTemporaryDirectory();
      final audioFile = File('${tempDir.path}/temp_audio.mp3');

      await ref.writeToFile(audioFile);

      // Use a simpler FFmpeg command that just analyzes the audio
      final command = '-i "${audioFile.path}" -filter_complex "aformat=channel_layouts=mono,showfreqs=s=600x120" -f null -';

      final session = await FFmpegKit.execute(command);
      final returnCode = await session.getReturnCode();

      if (await returnCode!.isValueError()) {
        final failStackTrace = await session.getFailStackTrace();
        print('FFmpeg failed with: ${await session.getOutput()}');
        print('StackTrace: $failStackTrace');
        throw Exception('FFmpeg processing failed');
      }

      // For now, use mock data since getting actual waveform is complex
      setState(() {
        soundData = List.generate(100, (i) => math.Random().nextDouble() * 0.8 + 0.2);
      });

      await audioFile.delete();
    } catch (e) {
      setState(() {
        // Fallback to mock data
        soundData = List.generate(100, (i) => (math.sin(i / 5) + 1) / 2);
      });
      print('Audio processing error: $e');
    }
  }

  List<double> processRawWaveformData(String rawData) {
    // Implement your logic to parse FFmpeg output
    // This is a placeholder - adjust based on your actual FFmpeg output format

    // For demonstration, return mock data
    return List.generate(100, (i) {
      return (i % 20) / 20.0; // Simple sawtooth pattern
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: GetBuilder<CoinController>(
        builder: (coinController) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: rWhite,
                              )),
                          SizedBox(
                            width: 8,
                          ),
                          SvgPicture.asset(
                            "assets/svgs/logo.svg",
                            width: 40,
                            height: 40,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          SvgPicture.asset(
                            "assets/svgs/logoTextSmall.svg",
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                if (liked) {
                                  coinController.removeFromFavorite(widget.coinModel);
                                  setState(() {
                                    liked = false;
                                    likeIcon = Icon(
                                      Icons.favorite_border,
                                      color: rWhite,
                                    );
                                  });
                                } else {
                                  coinController.addToFavorite(widget.coinModel);
                                  setState(() {
                                    liked = true;
                                    likeIcon = Icon(
                                      Icons.favorite,
                                      color: rRed,
                                    );
                                  });
                                }
                              },
                              child: likeIcon),
                          SizedBox(
                            width: 15,
                          ),
                          InfoButton(),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.share_outlined,
                            color: rWhite,
                          ),
                        ],
                      )
                    ],
                  ).marginSymmetric(horizontal: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(widget.coinModel.coinFront, width: 80, height: 80, fit: BoxFit.fill),
                      Column(
                        children: [
                          Text(
                            "${widget.coinModel.country.substring(0, 5)}",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "${widget.coinModel.name}",
                            style: TextStyle(color: rWhite, fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Image.network(widget.coinModel.coinBack, width: 80, height: 80, fit: BoxFit.fill),
                    ],
                  ).marginOnly(top: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: testPass == null ? rYellow : testPass==true?rGreen:Color(0xffFF5D5D)),
                    child:
                    Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        testPass==null?"TEST SOUND":testPass==true?"Test Pass":"Test Failed",
                                        style: TextStyle(color: rBlack, fontSize: 24, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        testPass==null?"0 out 3 Match Frequencies":testPass==true?"All frequencies matched":"0 out 3 Match Frequencies",
                                        style: TextStyle(color: rBlack, fontSize: 16, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  testPass==null?Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xffB79300)),
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: Colors.transparent, border: Border.all(color: rWhite, width: 5)),
                                    ),
                                  ):testPass==true?Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xff368C2D)),
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset("assets/svgs/tick.svg")
                                  ) :
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xffBE4040)),
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset("assets/svgs/cancel.svg")
                                  )
                                ],
                              ).marginSymmetric(horizontal: 15).marginOnly(top: 12),
                              Container(
                                padding: EdgeInsets.all(16),
                                height: 130,
                                color: rBg,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    //reference audio wave form
                                    CustomPaint(
                                      size: Size(MediaQuery.of(context).size.width, 50),
                                      painter: ReferenceWaveformPainter(soundData),
                                    ),
                                    //TODO:the green waveform is always appearing in same shape, no matter what I am recording.
                                    if (_recordedWaveformData.isNotEmpty)
                                      CustomPaint(
                                        size: Size(MediaQuery.of(context).size.width, 50),
                                        painter: RecordedWaveformPainter(_recordedWaveformData),
                                      ),
                                  ],
                                ),
                              ).marginSymmetric(horizontal: 12, vertical: 12)
                            ],
                          )
                        // : Stack(
                        //     alignment: Alignment.center,
                        //     children: [
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Container(
                        //             width: MediaQuery.of(context).size.width * 0.495,
                        //             height: MediaQuery.of(context).size.height * 0.33,
                        //             color: rGreen,
                        //             alignment: Alignment.centerLeft,
                        //             child: Column(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 Text(
                        //                   "GOOD SOUND",
                        //                   style: TextStyle(color: rBlack, fontSize: 24, fontWeight: FontWeight.bold),
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Expanded(
                        //                         child: Text(
                        //                       "3 out 3 Match Frequencies",
                        //                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        //                     )),
                        //                     Container(
                        //                       width: 40,
                        //                       height: 40,
                        //                       decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xff368C2D)),
                        //                       alignment: Alignment.center,
                        //                       child: SvgPicture.asset("assets/svgs/tick.svg"),
                        //                     )
                        //                   ],
                        //                 )
                        //               ],
                        //             ).marginSymmetric(horizontal: 12),
                        //           ),
                        //           Container(
                        //             width: MediaQuery.of(context).size.width * 0.495,
                        //             height: MediaQuery.of(context).size.height * 0.33,
                        //             color: Color(0xffFF5D5D),
                        //             alignment: Alignment.centerLeft,
                        //             child: Column(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 Text(
                        //                   "BAD WEIGHT",
                        //                   style: TextStyle(color: rBlack, fontSize: 24, fontWeight: FontWeight.bold),
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Expanded(
                        //                         child: Text(
                        //                       "1.10 oz t \n36.34 grams",
                        //                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        //                     )),
                        //                     Container(
                        //                       width: 40,
                        //                       height: 40,
                        //                       decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xffBE4040)),
                        //                       alignment: Alignment.center,
                        //                       child: SvgPicture.asset("assets/svgs/cancel.svg"),
                        //                     )
                        //                   ],
                        //                 )
                        //               ],
                        //             ).marginSymmetric(horizontal: 12),
                        //           )
                        //         ],
                        //       ),
                        //       Positioned(
                        //         bottom: 0,
                        //         child: Container(
                        //           width: MediaQuery.of(context).size.width * 0.95,
                        //           padding: EdgeInsets.all(16),
                        //           height: 130,
                        //           color: rBg,
                        //         ).marginSymmetric(horizontal: 12, vertical: 12),
                        //       )
                        //     ],
                        //   ),
                  ).marginOnly(top: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "⚠ Use at your own risk",
                        style: TextStyle(color: rHint, fontSize: 14),
                      ),
                      CustomButton(
                        label: isTesting == false
                            ? isTested == false
                                ? "Start Testing"
                                : "Test Again"
                            : "Testing...",
                        fail: isTesting == false
                            ? isTested == false
                                ? "Not fail"
                                : "fail"
                            : "not fail",
                        func: startTesting,
                        width: MediaQuery.of(context).size.width * 0.4,
                      )
                    ],
                  ).marginSymmetric(horizontal: 12).marginOnly(top: 14),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    alignment: Alignment.center,
                    child: Visibility(
                        visible: isTesting,
                        child: Column(
                          children: [
                            Text("Listening...", style: TextStyle(color: rWhite)),
                            CustomPaint(
                              painter: WaveformPainter(
                                amplitudes: _amplitudes,
                                color: Color(0xFF6A9B76),
                              ),
                              size: Size(MediaQuery.of(context).size.width - 40, 100),
                            ).marginSymmetric(horizontal: 12),
                          ],
                        )),
                  ),
                  AdWidget().marginSymmetric(horizontal: 30).marginOnly(bottom: 20)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _recorder.dispose();
    _timer.cancel();
    _amplitudeTimer.cancel();
    super.dispose();
  }

  startTesting() async {
    if (!await Permission.microphone.isGranted) {
      await Permission.microphone.request();
      if (!await Permission.microphone.isGranted) {
        CustomSnackbar.show("Error", "Microphone permission denied", isSuccess: false);
        return;
      }
    }

    try {
      // Generate file path
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.aac';

      // Start recording
      await _recorder.start(
        path: path,
        encoder: AudioEncoder.AAC,
      );

      setState(() {
        isTesting = true;
        _amplitudes = List.generate(30, (_) => 0.3); // Initialize with default heights
        _secondsRemaining = 5;
        _lastRecordingPath = path;
      });

      // Simulate waveform with random values instead of using real amplitude
      final random = math.Random();
      _amplitudeTimer = Timer.periodic(Duration(milliseconds: 200), (timer) {
        if (isTesting) {
          setState(() {
            // Generate new random heights for some of the bars each time
            for (int i = 0; i < _amplitudes.length; i++) {
              if (random.nextBool()) {
                // Only change some bars each update for smoother animation
                _amplitudes[i] = 0.3 + random.nextDouble() * 0.7; // Random height between 0.3 and 1.0
              }
            }
          });
        } else {
          timer.cancel();
        }
      });

      // Countdown timer
      _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
        if (_secondsRemaining > 1) {
          setState(() => _secondsRemaining--);
        } else {
          _amplitudeTimer.cancel(); // Cancel amplitude timer
          await _stopRecording();
          timer.cancel();
          final service = AudioCompareService();
          final similarity = await service.compareCoinAudio(
            recordedAacPath: '${path}',
            referenceMp3Url: '${widget.coinModel.coinAudio}',
          );

          print('Match: ${similarity.toStringAsFixed(2)}%');
          if(similarity<double.parse(widget.coinModel.highLevel)){
            setState(() {
              testPass=false;
            });
          }else{
            setState(() {
              testPass=true;
            });
          }
          // CustomSnackbar.show("Match rate", "Coin is ${similarity.toStringAsFixed(2)}% authentic");
        }
      });
    } catch (e) {
      print('Recording error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to start recording')),
      );
    }
  }

  Future<void> _stopRecording() async {
    if (!isTesting) return;
    try {
      await _recorder.stop();
      if (_lastRecordingPath != null) {
        await _processRecordedAudio(_lastRecordingPath!);
      }
      setState(() {
        isTesting = false;
        _secondsRemaining = 0;
      });
    } catch (e) {
      print('Stop recording error: $e');
    }
  }

  Future<void> _processRecordedAudio(String audioPath) async {
    try {
      setState(() {});
      final tempDir = await getTemporaryDirectory();

      // Use FFmpeg to extract raw PCM data
      final rawOutputPath = '${tempDir.path}/waveform.raw';
      final command = '-i "$audioPath" '
          '-filter_complex "aformat=channel_layouts=mono,'
          'compand=gain=-6,showwaves=s=600x120:mode=point" '
          '-map 0:v -c:v rawvideo -f rawvideo -pix_fmt gray - '
          '> "$rawOutputPath"';

      final session = await FFmpegKit.execute(command);
      final returnCode = await session.getReturnCode();

      if (await returnCode!.isValueError()) {
        throw Exception('FFmpeg processing failed');
      }

      // Read and process the raw data
      final rawFile = File(rawOutputPath);
      final bytes = await rawFile.readAsBytes();

      // Convert bytes to waveform values (0.0 to 1.0)
      final waveform = bytes.map((b) => b / 255.0).toList();

      // Downsample if needed (100 points for display)
      final downsampled = _downsampleWaveform(waveform, 100);

      setState(() {
        _recordedWaveformData = downsampled;

      });

      await rawFile.delete();
    } catch (e) {
      print('Recorded audio processing error: $e');
      setState(() {
        // Fallback to mock data that changes with each recording
        _recordedWaveformData = List.generate(100, (i) => math.Random().nextDouble());
      });
    }
  }

  List<double> _downsampleWaveform(List<double> data, int targetLength) {
    if (data.length <= targetLength) return data;

    final step = data.length / targetLength;
    final result = <double>[];

    for (var i = 0; i < targetLength; i++) {
      final start = (i * step).toInt();
      final end = ((i + 1) * step).toInt().clamp(0, data.length);
      final segment = data.sublist(start, end);
      result.add(segment.reduce((a, b) => a > b ? a : b)); // Get peak value
    }

    return result;
  }
}

class WaveformPainter extends CustomPainter {
  final List<double> amplitudes;
  final Color color;

  WaveformPainter({required this.amplitudes, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final barWidth = 12.0;
    final spacing = 5.0;
    final maxBarHeight = size.height * 0.8; // Use 80% of container height

    if (amplitudes.isEmpty) return;

    final totalWidth = amplitudes.length * (barWidth + spacing) - spacing;
    final startX = (size.width - totalWidth) / 2;

    for (int i = 0; i < amplitudes.length; i++) {
      final x = startX + i * (barWidth + spacing);
      final barHeight = (amplitudes[i] * maxBarHeight).clamp(20.0, maxBarHeight); // Minimum height of 20
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, (size.height - barHeight) / 2, barWidth, barHeight),
        Radius.circular(6),
      );
      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(WaveformPainter oldDelegate) {
    return oldDelegate.amplitudes != amplitudes;
  }
}

class ReferenceWaveformPainter extends CustomPainter {
  final List<double> waveformData;

  ReferenceWaveformPainter(this.waveformData);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = rYellow
      ..style = PaintingStyle.fill;

    final centerY = size.height / 2;
    final barWidth = size.width / waveformData.length;

    for (int i = 0; i < waveformData.length; i++) {
      final height = waveformData[i] * size.height * 0.8;
      final left = i * barWidth;

      canvas.drawRect(
        Rect.fromLTWH(left, centerY - height / 2, barWidth * 0.8, height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class RecordedWaveformPainter extends CustomPainter {
  final List<double> waveformData;

  RecordedWaveformPainter(this.waveformData);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final centerY = size.height / 2;
    final barWidth = size.width / waveformData.length;

    for (int i = 0; i < waveformData.length; i++) {
      final height = waveformData[i] * size.height * 0.8;
      final left = i * barWidth;

      canvas.drawRect(
        Rect.fromLTWH(left, centerY - height / 2, barWidth * 0.8, height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
