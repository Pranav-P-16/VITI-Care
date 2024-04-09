import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class RequestCleaning extends StatefulWidget {
  @override
  _RequestCleaningState createState() => _RequestCleaningState();
}

class _RequestCleaningState extends State<RequestCleaning> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _roomNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Room Cleaning'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Room Number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your room number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _roomNumber = value!;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Send request to worker's app
                    sendRequestToWorker(_name, _roomNumber);
                  }
                },
                child: Text('Request Cleaning'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendRequestToWorker(String name, String roomNumber) {
    // Send request to worker's app using Firebase Cloud Messaging
    // You will need to replace 'worker-device-token' with the device token of the worker's device
    final message = {
      'notification': {
        'title': 'New Cleaning Request',
        'body': '$name has requested cleaning for room $roomNumber',
      },
      'data': {
        'name': name,
        'roomNumber': roomNumber,
      },
      'to': 'worker-device-token',
    };
    FirebaseMessaging.instance.sendMessage();
  }
}