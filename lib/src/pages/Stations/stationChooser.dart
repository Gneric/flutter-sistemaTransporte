import 'package:flutter/material.dart';

void chooseStation(context) {

  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: GridView.count(
                crossAxisCount: 4,
                children: List.generate(12, (index) {
                  return Center(
                    child: Text('Item $index',style: Theme.of(context).textTheme.headline),
                  );
                }),
              ),
            ),
          )
        );
      }
  );
}
