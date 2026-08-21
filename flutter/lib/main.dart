import 'package:flutter/material.dart';
import 'game.dart';
import 'package:flutter/widget_previews.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //所以完整链路是: 
    //build() 返回 Widget → 
    //Element 把它膨胀成子 Element(继续往下 build,直到碰到 RenderObjectWidget)→ 
    //对应生成/更新 RenderObject → 
    //挂进渲染树 → 
    //布局绘制合成 → 
    //显示到屏幕。
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.center ,
            child: Text('birdle'),
          ),
        ),
        body: Center(
          child:GamePage(),
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget{
    const Tile(this.letter,this.hitType,{super.key});
    final String letter;
    final HitType hitType;

    @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 60.0,
      height: 60,
      duration: Duration(microseconds: 500),
      curve: Curves.bounceIn,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: switch(hitType){
           HitType.hit=> Colors.green,
           HitType.partial=> Colors.yellow,
           HitType.miss=> Colors.grey,
           _=>Colors.white,
        }
      ),
      child: Center(
        child: Text(
          letter.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge
        ),
      ),
    );
  }
}


class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState()=>_GamePageState();

}
class _GamePageState extends State<GamePage>{

  final Game _game = Game();
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        // mainAxisSize:MainAxisSize.min,
        spacing: 5.0,
        children: [
          for(final guess in _game.guesses)
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            spacing: 5.0,
            children: [
              for(final letter in guess)
                Tile(letter.char, letter.type)
            ],
          ),
          GuessInput(
            onSubmmit: (String guess){
              setState(() {
               _game.guess(guess); 
              });
            }
            )
        ],
        
      ),
      );
  }
}

@Preview(name: "GuessInput")
Widget GuessInputPreview(){
  return  GuessInput(onSubmmit: (_) => "A");
}


class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmmit});
  final void Function(String) onSubmmit;
  final TextEditingController _editingController = TextEditingController();
  final FocusNode _focusNode=FocusNode();
  void _submmitGuess() {
    onSubmmit(_editingController.text.trim());
    _editingController.clear();
    _focusNode.requestFocus();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
            maxLength: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(35))
              )
            ),
            controller: _editingController,
            autofocus: true,
            onSubmitted: (_){_submmitGuess();},
          ),
        ),),
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.arrow_circle_up),
          onPressed: _submmitGuess,
        )
      ],
      
    );
  }
}