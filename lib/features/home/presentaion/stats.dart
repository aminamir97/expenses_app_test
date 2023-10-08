import 'package:expenses_app/app/assets.dart';
import 'package:expenses_app/app/paddings.dart';
import 'package:expenses_app/app/theme/colors.dart';
import 'package:expenses_app/app/theme/fonts.dart';
import 'package:expenses_app/features/home/controller/expensesController.dart';
import 'package:expenses_app/features/home/models/chartModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  List<ChartDataModel> chartModels = [];

  @override
  void initState() {
    // TODO: implement initState
    chartModels = context.read<ExpensesController>().getWeeklyData();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<ExpensesController>();

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              padding: AppPaddings.smallX,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.homeHeader),
                      alignment: Alignment.topCenter)),
              child: Column(children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Statsitcial Presentation",
                  style: AppFonts.subtitle1,
                ),
                SizedBox(height: 50.h),
                Expanded(
                    child: Container(
                        padding: AppPaddings.small,
                        width: double.maxFinite,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 35,
                              offset: Offset(0, 22),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            // Chart title
                            title: ChartTitle(
                                text: 'Total Expenses for the current week'),
                            // Enable legend
                            legend: const Legend(isVisible: true),
                            series: <ChartSeries<ChartDataModel, String>>[
                              ColumnSeries<ChartDataModel, String>(
                                  dataSource: chartModels,
                                  xValueMapper: (ChartDataModel data, _) =>
                                      data.date,
                                  yValueMapper: (ChartDataModel data, _) =>
                                      data.amount,
                                  name: 'Expenses',
                                  color: AppColors.primary)
                            ])))
              ]),
            )));
  }
}
