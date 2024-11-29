import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // top half with background image
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/snowy-tree.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // bottom half with dark background and transformed text
          Expanded(
            flex: 1,
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              child: Center(
                child: Transform.rotate(
                  angle: 0.1, //rotation like in example transformation
                  child: Text(
                    'Jay\'s Flutter Navigation App',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
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
