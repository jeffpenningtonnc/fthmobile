import 'package:flutter/material.dart';
import '../../Services/event_service.dart';

class SubscribeIcon extends StatefulWidget {
  const SubscribeIcon(Key key, this.organizationId, this.subscribed) : super(key: key);

  final int organizationId;
  final bool subscribed;

  @override
  _SubscribeIconState createState() => _SubscribeIconState();
}

class _SubscribeIconState extends State<SubscribeIcon> {
  bool _subscribed = false;

  @override
  void initState() {
    super.initState();
    _subscribed = widget.subscribed;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.favorite),
      color: _subscribed ? Colors.red : Colors.grey,
      onPressed: () {
        setState(() {
          _subscribed = !_subscribed;
          EventService.subscribeToOrganization(widget.organizationId, _subscribed);
        });
      },
    );
  }
}
