import 'package:flutter/material.dart';
import 'package:themoviedb/utils/images.dart';

class MovieScreenCastWidget extends StatelessWidget {
  const MovieScreenCastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Top Billed Cast',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
          ),
          SizedBox(
            height: 250,
            child: Scrollbar(
              child: ListView.builder(
                  itemCount: 10,
                  itemExtent: 120,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.black.withOpacity(0.2)),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: Offset(0, 2))
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            children: [
                              Image(
                                image: AppImages.actor,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Jennifer Lopez',
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Mother',
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 14),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child:
                TextButton(onPressed: () {}, child: Text('Full Cast & Crew')),
          )
        ],
      ),
    );
  }
}
