import 'package:fluro/fluro.dart';
import 'package:meetble/view/screens/create_screens/create_screen00.dart';
import 'package:meetble/view/screens/create_screens/error_screen.dart';
import 'package:meetble/view/screens/join_screens/join_screen00.dart';
import 'package:meetble/view/screens/result_screen.dart';

class FRouter {
  static FluroRouter router = FluroRouter();

  static String create = '/create';
  static String meet = '/meet/:id';
  static String join = '/join/:id';
  static String result = '/result/:id';

  static void setupRouter() {
    router.define(create, handler: createHandler, transitionType: TransitionType.none);
    router.define(join, handler: joinHandler, transitionType: TransitionType.none);
    router.define(result, handler: resultHandler, transitionType: TransitionType.none);
    router.notFoundHandler = Handler(handlerFunc: (context, params) => ErrorScreen());
  }

  static Handler createHandler = Handler(
      handlerFunc: (context, params) => CreateScreen00(),
  );

  static Handler joinHandler = Handler(
      handlerFunc: (context, params) {
        return JoinScreen00(meetingId: params['id']![0]);
      },
  );

  static Handler resultHandler = Handler(
      handlerFunc: (context, params) {
        return ResultScreen(meetingId: params['id']![0]);
      },
  );
}