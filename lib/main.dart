import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _slideAnimation = Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0)).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caça Rato'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SlideTransition(
            position: _slideAnimation,
            child: Container(
              width: 500,
              height: 500,
              color: Colors.green,
              child: Center(
                child: Image.asset("assets/imagens/cacaRato.jpg"),
              ),
            ),
          ),
          SizedBox(height: 50),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SecondScreen(_controller)));
            },
            child: Hero(
              tag: 'hero-animation',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Não clique',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  final AnimationController controller;

  const SecondScreen(this.controller);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool _isElevated = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eu te avisei 😡😡😡😡😡'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'hero-animation',
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isElevated = !_isElevated;
                  });
                },
                child: AnimatedPhysicalModel(
                  duration: Duration(seconds: 1),
                  shape: BoxShape.rectangle,
                  elevation: _isElevated ? 100 : 0,
                  color: Colors.blue,
                  shadowColor: const Color.fromARGB(255, 255, 0, 0),
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      Container(
                        width: 300,
                        height: 200,
                        child: Center(
                          child: Image.asset("assets/imagens/canalha.png"),
                        ),
                      ),
                      SlideTransition(
                        position: widget.controller.drive(Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -1))),
                        child: Container(
                          width: 200,
                          height: 200,
                          child: Center(
                            child: Image.asset("/imagens/gatoEstranhoFudido.jpg"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
