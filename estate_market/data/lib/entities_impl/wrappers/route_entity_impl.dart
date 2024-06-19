import 'package:gem_kit/routing.dart';
import 'package:domain/entities/wrappers/route_entity.dart';

class RouteEntityImpl implements RouteEntity {
  final Route ref;

  RouteEntityImpl({required this.ref});

  @override
  String getMapLabel() {
    final totalDistance = ref.timeDistance.unrestrictedDistanceM + ref.timeDistance.restrictedDistanceM;
    final totalDuration = ref.timeDistance.unrestrictedTimeS + ref.timeDistance.restrictedTimeS;

    return '${_convertDistance(totalDistance)} \n${_convertDuration(totalDuration)}';
  }

  String _convertDistance(int meters) {
    if (meters >= 1000) {
      double kilometers = meters / 1000;
      return '${kilometers.toStringAsFixed(1)} km';
    } else {
      return '${meters.toString()} m';
    }
  }

  String _convertDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;

    String hoursText = (hours > 0) ? '$hours h ' : '';
    String minutesText = '$minutes min';

    return hoursText + minutesText;
  }
}
