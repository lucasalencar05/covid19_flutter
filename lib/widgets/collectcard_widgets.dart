import 'package:flutter/material.dart';

import '../data/api.dart';

class CollectCard extends StatelessWidget {
  final String text;
  final int stats;
  final Color color;
  final IconData icon;

  CollectCard({
    @required this.color,
    @required this.icon,
    @required this.text,
    @required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 6.0,
        child: Container(
          margin: const EdgeInsets.all(22.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      text,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey[500]
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      stats.toString().replaceAllMapped(reg, mathFunc),
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    icon,
                    size: 80.0,
                    color: color,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
