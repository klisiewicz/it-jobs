import 'package:flutter/material.dart';
import 'package:it_jobs/src/ui/keys.dart';

class ErrorPage extends StatelessWidget {
  final VoidCallback onRetry;

  const ErrorPage({
    Key key,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(Icons.error, size: 64, color: Theme.of(context).errorColor),
          const SizedBox(height: 16),
          Text(
            'Ooops something went wrong...',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 16),
          FlatButton(
            key: Keys.refreshButton,
            onPressed: onRetry,
            child: const Text('Try Again'),
          )
        ],
      ),
    );
  }
}
