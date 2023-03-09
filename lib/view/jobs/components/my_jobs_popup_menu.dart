import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/view/jobs/components/my_jobs_helper.dart';
import 'package:qixer/view/jobs/edit_job_page.dart';
import 'package:qixer/view/utils/const_strings.dart';

class MyJobsPopupMenu extends StatelessWidget {
  const MyJobsPopupMenu({
    Key? key,
    required this.jobId,
    required this.imageLink,
    required this.jobIndex,
  }) : super(key: key);

  final jobId;
  final imageLink;
  final jobIndex;

  @override
  Widget build(BuildContext context) {
    List popupMenuList = [ConstString.edit, ConstString.delete];

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Consumer<AppStringService>(
          builder: (context, ln, child) => PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              for (int i = 0; i < popupMenuList.length; i++)
                PopupMenuItem(
                  onTap: () {
                    Future.delayed(Duration.zero, () {
                      navigate(i, context, jobId, imageLink, jobIndex);
                    });
                  },
                  child: Text(ln.getString(popupMenuList[i])),
                ),
            ],
          ),
        )
      ],
    );
  }

  navigate(int i, BuildContext context, jobId, imageLink, jobIndex) {
    if (i == 0) {
      return Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => EditJobPage(
            jobIndex: jobIndex,
            jobId: jobId,
          ),
        ),
      );
    } else if (i == 1) {
      MyJobsHelper().deletePopup(context, index: jobIndex, jobId: jobId);
    }
  }
}
