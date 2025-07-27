import 'dart:html';
import 'dart:async';

final announceDate = DateTime.parse('2022-03-19T00:00:00');

late SpanElement daysValue;
late SpanElement hoursValue;
late SpanElement minutesValue;
late SpanElement secondsValue;

void main() {
  //шрифт
  final fontLink =
      LinkElement()
        ..rel = 'stylesheet'
        ..href =
            'https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap';
  document.head!.append(fontLink);

  fontLink.onLoad.listen((_) {
    setupUI();
    updateTimer();
    Timer.periodic(Duration(seconds: 1), (_) => updateTimer());
  });
}

void setupUI() {
  //видео бэкграунд
  final videoBg =
      VideoElement()
        ..src = '/bg1.mp4'
        ..autoplay = true
        ..loop = true
        ..muted = true
        ..style.position = 'fixed'
        ..style.top = '0'
        ..style.left = '0'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = 'cover'
        ..style.zIndex = '-1'
        ..style.pointerEvents = 'none';

  document.body!.append(videoBg);

  //счётчик
  daysValue = SpanElement();
  hoursValue = SpanElement();
  minutesValue = SpanElement();
  secondsValue = SpanElement();

  final container =
      DivElement()
        ..style.display = 'flex'
        ..style.justifyContent = 'center'
        ..style.gap = '20px'
        ..style.padding = '30px'
        // ..style.backgroundColor = '#ffffff33'
        ..style.backgroundColor = '#00000088'
        ..style.borderRadius = '20px'
        ..style.setProperty('backdrop-filter', 'blur(12px)')
        ..style.boxShadow = '0 4px 20px rgba(0,0,0,0.2)'
        ..style.zIndex = '1'
        ..append(createTimeBlock('Дней', daysValue))
        ..append(createTimeBlock('Часов', hoursValue))
        ..append(createTimeBlock('Минут', minutesValue))
        ..append(createTimeBlock('Секунд', secondsValue));

  document.body!
    ..style.margin = '0'
    ..style.height = '100vh'
    ..style.overflow = 'hidden'
    ..style.display = 'flex'
    ..style.alignItems = 'center'
    ..style.justifyContent = 'center'
    ..children.add(container);
}

DivElement createTimeBlock(String label, SpanElement valueElement) {
  final column =
      DivElement()
        ..style.display = 'flex'
        ..style.flexDirection = 'column'
        ..style.alignItems = 'center'
        ..style.padding = '10px'
        ..style.minWidth = '80px';

  valueElement
    ..text = '00'
    ..style.fontSize = '48px'
    ..style.fontFamily = "'Bebas Neue', sans-serif"
    ..style.color = '#fff';

  final labelElement =
      SpanElement()
        ..text = label
        ..style.marginTop = '4px'
        ..style.fontSize = '14px'
        ..style.color = '#eee'
        ..style.fontFamily = 'sans-serif';

  column
    ..append(valueElement)
    ..append(labelElement);
  return column;
}

void updateTimer() {
  final now = DateTime.now();
  final diff = now.difference(announceDate);

  final days = diff.inDays;
  final hours = diff.inHours % 24;
  final minutes = diff.inMinutes % 60;
  final seconds = diff.inSeconds % 60;

  daysValue.text = '$days';
  hoursValue.text = hours.toString().padLeft(2, '0');
  minutesValue.text = minutes.toString().padLeft(2, '0');
  secondsValue.text = seconds.toString().padLeft(2, '0');
}
