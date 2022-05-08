import 'dart:io';

import 'package:attendance_app/pages/Home/report_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelService {
  List<Style> createStyles(Workbook workbook) {
    final Style style = workbook.styles.add('Style');
    style.fontColor = '#308DA2';
    style.fontSize = 28;
    style.bold = true;
    style.borders.bottom.lineStyle = LineStyle.double;
    style.vAlign = VAlignType.center;

    final Style style1 = workbook.styles.add('Style1');
    style1.bold = true;
    style1.fontSize = 12;
    style1.fontColor = '#595959';
    style1.vAlign = VAlignType.center;
    style1.borders.bottom.lineStyle = LineStyle.thin;
    style1.borders.bottom.color = '#A6A6A6';
    style1.borders.right.lineStyle = LineStyle.thin;
    style1.borders.right.color = '#A6A6A6';

    final Style style2 = workbook.styles.add('Style2');
    style2.fontColor = '#595959';
    style2.wrapText = true;
    style2.vAlign = VAlignType.center;
    style2.borders.bottom.lineStyle = LineStyle.thin;
    style2.borders.bottom.color = '#A6A6A6';
    style2.borders.right.lineStyle = LineStyle.thin;
    style2.borders.right.color = '#A6A6A6';
    style2.numberFormat = '_(\$* #,##0_);_(\$* (#,##0);_(\$* "-"_);_(@_)';

    final Style style3 = workbook.styles.add('style3');
    style3.backColor = '#F2F2F2';
    style3.fontColor = '#313F55';
    style3.vAlign = VAlignType.center;
    style3.borders.bottom.lineStyle = LineStyle.thin;
    style3.borders.bottom.color = '#308DA2';
    style3.borders.right.lineStyle = LineStyle.thin;
    style3.borders.right.color = '#A6A6A6';

    final Style style4 = workbook.styles.add('Style4');
    style4.backColor = '#CFEBF1';
    style4.bold = true;
    style4.vAlign = VAlignType.center;
    style4.borders.bottom.lineStyle = LineStyle.medium;
    style4.borders.bottom.color = '#308DA2';
    style4.borders.right.lineStyle = LineStyle.thin;
    style4.borders.right.color = '#A6A6A6';

    final Style style5 = workbook.styles.add('Style5');
    style5.fontSize = 12;
    style5.vAlign = VAlignType.center;
    style5.hAlign = HAlignType.right;
    style5.indent = 1;
    style5.borders.bottom.lineStyle = LineStyle.thick;
    style5.borders.bottom.color = '#308DA2';
    style5.borders.right.lineStyle = LineStyle.thin;
    style5.borders.right.color = '#A6A6A6';
    style5.borders.left.lineStyle = LineStyle.thin;
    style5.borders.left.color = '#A6A6A6';

    final Style style6 = workbook.styles.add('Style6');
    style6.fontColor = '#595959';
    style6.wrapText = true;
    style6.vAlign = VAlignType.center;
    style6.borders.right.lineStyle = LineStyle.thin;
    style6.borders.right.color = '#A6A6A6';
    style6.numberFormat = '_(\$* #,##0_);_(\$* (#,##0);_(\$* "-"_);_(@_)';

    final Style style7 = workbook.styles.add('Style7');
    style7.fontColor = '#595959';
    style7.wrapText = true;
    style7.vAlign = VAlignType.center;
    style7.borders.bottom.lineStyle = LineStyle.thin;
    style7.borders.bottom.color = '#A6A6A6';

    final Style style8 = workbook.styles.add('style8');
    style8.backColor = '#F2F2F2';
    style8.fontColor = '#313F55';
    style8.vAlign = VAlignType.center;
    style8.borders.bottom.lineStyle = LineStyle.thin;
    style8.borders.bottom.color = '#308DA2';
    style8.borders.right.lineStyle = LineStyle.thin;
    style8.borders.right.color = '#A6A6A6';
    style8.numberFormat = '_(\$* #,##0_);_(\$* (#,##0);_(\$* "-"_);_(@_)';

    final Style style9 = workbook.styles.add('style9');
    style9.backColor = '#CFEBF1';
    style9.bold = true;
    style9.vAlign = VAlignType.center;
    style9.borders.bottom.lineStyle = LineStyle.medium;
    style9.borders.bottom.color = '#308DA2';
    style9.borders.right.lineStyle = LineStyle.thin;
    style9.borders.right.color = '#A6A6A6';
    style9.numberFormat = '_(\$* #,##0_);_(\$* (#,##0);_(\$* "-"_);_(@_)';

    return [
      style,
      style1,
      style2,
      style3,
      style4,
      style5,
      style6,
      style7,
      style8,
      style9
    ];
  }

  // Future<String?> getPath() async {
  //   Directory? appDocDir = await getExternalStorageDirectory();

  //   String appDocPath = appDocDir!.path;
  //   Directory(appDocPath).create();
  //   return appDocPath;
  // }

  Future<String?>? addAssetsSheet(Workbook workbook, List<Style> styles,
      List<LogModel?>? logList, String? path) async {
    // Sheet2

    final Worksheet sheet2 = workbook.worksheets.addWithName('Report');
    sheet2.showGridlines = false;

    final Range range1 = sheet2.getRangeByName('A2');
    range1.cellStyle = styles[5];
    range1.text = 'No';

    final Range range2 = sheet2.getRangeByName('B2');
    range2.cellStyle = styles[5];
    range2.text = 'Date';

    final Range range3 = sheet2.getRangeByName('C2');
    range3.cellStyle = styles[5];
    range3.text = 'Time';

    final Range range4 = sheet2.getRangeByName('D2');
    range4.cellStyle = styles[5];
    range4.text = 'Direction';

    final Range range5 = sheet2.getRangeByName('E2');
    range5.cellStyle = styles[5];
    range5.text = 'Place';

    int? i = 3;
    int? index = 1;
    for (var log in logList!) {
      sheet2.getRangeByName('A$i').text = index.toString();
      sheet2.getRangeByName('B$i').text = log?.date;
      sheet2.getRangeByName('C$i').text = log?.time;
      sheet2.getRangeByName('D$i').text = log?.status;
      sheet2.getRangeByName('E$i').text = log?.place;
      i = i! + 1;
      index = index! + 1;
    }

    DateTime time = DateTime.now();

    final List<int> bytes = workbook.saveAsStream();
    File('$path/EmployeeReport${time.millisecondsSinceEpoch}.xlsx').create();
    File('$path/EmployeeReport${time.millisecondsSinceEpoch}.xlsx')
        .writeAsBytes(bytes);
    return "ok";
  }
}
