import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../home_page/home_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ListaWidget extends StatefulWidget {
  ListaWidget({Key key}) : super(key: key);

  @override
  _ListaWidgetState createState() => _ListaWidgetState();
}

class _ListaWidgetState extends State<ListaWidget> {
  DateTimeRange calendarSelectedDay;
  final pageViewController = PageController();
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController textController3;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    textController1 = TextEditingController(text: '0-100');
    textController2 = TextEditingController(text: '0');
    textController3 = TextEditingController(text: '000');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFFDC3D06),
          automaticallyImplyLeading: false,
          actions: [
            FFButtonWidget(
              onPressed: () async {
                await Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.topToBottom,
                    duration: Duration(milliseconds: 100),
                    reverseDuration: Duration(milliseconds: 100),
                    child: HomePageWidget(),
                  ),
                );
              },
              text: 'Button',
              options: FFButtonOptions(
                width: 130,
                height: 40,
                color: Color(0xFFDC3D06),
                textStyle: FlutterFlowTheme.subtitle2.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 12,
              ),
            )
          ],
          centerTitle: true,
          elevation: 4,
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
            ),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Color(0xFFF5F5F5),
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Color(0xFFF5F5F5),
                    child: Container(
                      height: 200,
                      child: Container(
                        width: double.infinity,
                        height: 500,
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                              child: PageView(
                                controller: pageViewController,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Image.network(
                                    'https://picsum.photos/seed/700/600',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  Image.network(
                                    'https://picsum.photos/seed/31/600',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  Image.network(
                                    'https://picsum.photos/seed/99/600',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.contain,
                                  )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment(0, 1),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: SmoothPageIndicator(
                                  controller: pageViewController,
                                  count: 3,
                                  axisDirection: Axis.horizontal,
                                  onDotClicked: (i) {
                                    pageViewController.animateToPage(
                                      i,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  },
                                  effect: ExpandingDotsEffect(
                                    expansionFactor: 2,
                                    spacing: 8,
                                    radius: 16,
                                    dotWidth: 16,
                                    dotHeight: 16,
                                    dotColor: Color(0xFF9E9E9E),
                                    activeDotColor: Color(0xFF3F51B5),
                                    paintStyle: PaintingStyle.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FlutterFlowCalendar(
                    color: FlutterFlowTheme.primaryColor,
                    weekFormat: false,
                    weekStartsMonday: false,
                    onChange: (DateTimeRange newSelectedDate) {
                      setState(() => calendarSelectedDay = newSelectedDate);
                    },
                    titleStyle: TextStyle(),
                    dayOfWeekStyle: TextStyle(),
                    dateStyle: TextStyle(),
                    selectedDateStyle: TextStyle(),
                    inactiveDateStyle: TextStyle(),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 600,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              StreamBuilder<List<DadosRecord>>(
                                stream: queryDadosRecord(
                                  singleRecord: true,
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  List<DadosRecord> textFieldDadosRecordList =
                                      snapshot.data;
                                  // Customize what your widget looks like with no query results.
                                  if (snapshot.data.isEmpty) {
                                    return Container(
                                      height: 100,
                                      child: Center(
                                        child: Text('No results.'),
                                      ),
                                    );
                                  }
                                  final textFieldDadosRecord =
                                      textFieldDadosRecordList.first;
                                  return TextFormField(
                                    controller: textController1,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'digite um numero de 0 a 100',
                                      labelStyle:
                                          FlutterFlowTheme.title2.override(
                                        fontFamily: 'Roboto',
                                        color: Colors.black,
                                      ),
                                      hintText: '[Some hint text...]',
                                      hintStyle:
                                          FlutterFlowTheme.title2.override(
                                        fontFamily: 'Roboto',
                                        color: Colors.black,
                                      ),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.account_tree,
                                        color: Color(0xFFDC3D06),
                                        size: 30,
                                      ),
                                    ),
                                    style: FlutterFlowTheme.title2.override(
                                      fontFamily: 'Roboto',
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.number,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'é necessário digitar um valor';
                                      }
                                      if (val.length < 1) {
                                        return 'necessário um caracter';
                                      }
                                      return null;
                                    },
                                  );
                                },
                              ),
                              TextFormField(
                                controller: textController2,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'digite outro numero',
                                  labelStyle: FlutterFlowTheme.title2.override(
                                    fontFamily: 'Poppins',
                                  ),
                                  hintText: 'de 0 a 100',
                                  hintStyle: FlutterFlowTheme.title2.override(
                                    fontFamily: 'Poppins',
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.account_tree_outlined,
                                  ),
                                ),
                                style: FlutterFlowTheme.title2.override(
                                  fontFamily: 'Poppins',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              TextFormField(
                                controller: textController3,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: '[Some hint text...]',
                                  hintStyle: FlutterFlowTheme.title1.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFFE91E63),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.threesixty,
                                  ),
                                ),
                                style: FlutterFlowTheme.title1.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFE91E63),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              FFButtonWidget(
                                onPressed: () {
                                  print('Button pressed ...');
                                },
                                text: 'Button',
                                options: FFButtonOptions(
                                  width: 130,
                                  height: 40,
                                  color: FlutterFlowTheme.primaryColor,
                                  textStyle:
                                      FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 12,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
