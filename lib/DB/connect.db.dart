import 'package:mongo_dart/mongo_dart.dart';

void connectDB() async {
  var db = await Db.create('mongodb+srv://andiwillfly:ward121314@cluster0-etaet.mongodb.net/placer_db?retryWrites=true&w=majority');
  await db.open();

  print('DB connected Authors');

  var places = db.collection('places');
  var x = await places.find().toList();

  print(x);
}
