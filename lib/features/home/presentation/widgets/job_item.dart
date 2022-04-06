import 'package:final_project/core/utilities/helpers.dart';
import 'package:final_project/features/home/domain/entities/job.dart';
import 'package:flutter/material.dart';

class JobItem extends StatelessWidget {
  const JobItem({Key? key, required this.job, required this.onTap})
      : super(key: key);
  final Job job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(16),
        width: double.infinity,
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.deepOrangeAccent),
              child: Center(child: Text('${job.id}')),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                if (job.publishedDate == 'No Date')
                  const Text(
                    'No Date',
                    style: TextStyle(color: Colors.grey),
                  )
                else
                  Row(
                    children: [
                      Text(
                        formatTime(dateTime: job.publishedDate),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        formatDate(dateTime: job.publishedDate),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  )
              ],
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
