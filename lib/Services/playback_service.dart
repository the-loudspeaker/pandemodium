import 'package:just_audio_background/just_audio_background.dart';

class PlayBackService {
  static void initBackgroundAudioService() async {
    await JustAudioBackground.init(
        androidNotificationChannelId: 'pandemonium_bg_channel',
        androidNotificationChannelName: 'Pandemonium',
        androidNotificationOngoing: false,
        androidStopForegroundOnPause: false);
  }
}
