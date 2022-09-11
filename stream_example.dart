import 'dart:async';

class Cake {}

class Order {
  String type;
  Order(this.type);
}

main() {
  final controller = StreamController();
  Order order = new Order('chocolate');
  print(order.type);
  controller.sink.add(order);

  final baker =
      new StreamTransformer.fromHandlers(handleData: (cakeData, sink) {
    if (cakeData == 'chocolate') {
      sink.add(new Cake());
    } else {
      sink.addError('we can not create this cake');
    }
  });

  controller.stream.map((order) => order.type).transform(baker).listen((event) {
    print(event);
  }, onError: (err) => print(err));
}
