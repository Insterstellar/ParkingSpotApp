import 'dart:async';

void startTime(Duration duration){
  int addSeconds=1;

  Timer.periodic(Duration(seconds: 1), (timer) {

      int seconds =duration.inSeconds-addSeconds;
      duration= Duration(seconds: seconds);
     // hoursStr = (duration.inHours).toString().padLeft(2, '0');
      //minutesStr = (duration.inMinutes % 60).toString().padLeft(2, '0');
     // secondsStr = (seconds % 60).toString().padLeft(2, '0');
      if(duration.inHours==0 && duration.inMinutes==0){
        duration=Duration(seconds: 0);

        timer.cancel();
      }



  });

}