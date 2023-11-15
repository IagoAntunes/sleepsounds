import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sleepsounds/src/features/playerSound/presenter/controller/player_sound_controller.dart';

class PlayerSoundPage extends StatefulWidget {
  PlayerSoundPage({super.key});

  @override
  State<PlayerSoundPage> createState() => _PlayerSoundPageState();
}

class _PlayerSoundPageState extends State<PlayerSoundPage>
    with TickerProviderStateMixin {
  PlayerSoundController playerSoundController = PlayerSoundController();
  final player = AudioPlayer();

  late AnimationController _animationController;
  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    player.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: MediaQuery.sizeOf(context).height * 0.4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                "S",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const Text("Sound Name"),
            const Text(
              "Sound Name",
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: ValueListenableBuilder(
                valueListenable: playerSoundController.isPlaying,
                builder: (context, value, child) {
                  return IconButton(
                    icon: AnimatedIcon(
                        progress: _animationController,
                        icon: AnimatedIcons.play_pause),
                    onPressed: () async {
                      if (!playerSoundController.isPlaying.value) {
                        _animationController.forward();
                        if (playerSoundController.fistPlay) {
                          playerSoundController.fistPlay = false;
                          await player.play(AssetSource('mp3/sound_1.mp3'));
                        } else {
                          await player.resume();
                        }
                        playerSoundController.isPlaying.value = true;
                      } else {
                        _animationController.reverse();
                        playerSoundController.isPlaying.value = false;
                        await player.pause();
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
