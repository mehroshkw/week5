import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Example',
      // Set the app's theme, including the font family and text theme
      theme: ThemeData(
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          bodyText2: TextStyle(fontSize: 16),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    // Listen for changes to the text field's input and validate it
    _controller.addListener(_validateInput);
  }

  void _validateInput() {
    // Update the button's enabled state based on the text field's input
    setState(() {
      _isButtonEnabled = _controller.text.isNotEmpty;
    });
  }

  void _onButtonPressed() {
    // Show a snackbar when the button is pressed
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Button pressed!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the app bar, including actions with icons and tooltips
      appBar: AppBar(
        title: const Text('Flutter Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {},
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            tooltip: 'Search',
          ),
        ],
      ),
      body: FocusTraversalGroup(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Add a text field for user input
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter some text',
                ),
              ),
              const SizedBox(height: 16),
              // Add a button that's only enabled if the text field is not empty
              ElevatedButton(
                onPressed: _isButtonEnabled ? _onButtonPressed : null,
                child: const Text('Press me'),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GestureDetector(
                  // Detect a tap gesture on the container and show a snackbar
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Gesture detected!'),
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      // Add a gradient background to the container
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.green],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      // Add a box shadow to the container
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Gesture detector',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: CustomScrollView(
                  //add custom slivers
                  slivers: [
                    SliverAppBar(
                      title: const Text('Sliver app bar'),
                      floating: true,
                      snap: true,
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) => ListTile(
                          leading: CircleAvatar(
                            child: Text('$index'),
                          ),
                          title: Text('List item $index'),
                        ),
                        childCount: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
