import 'package:eshkolot_offline/models/subject.dart';

class DragQ{
  late List<String> items=[];
  late List<String> positions=[];
  late List<String> ans=[];
  Map<String,bool> isDropped;


  DragQ(this.items,this.positions,this.isDropped):
    ans=List<String>.generate(items.length, (index) => '');

}