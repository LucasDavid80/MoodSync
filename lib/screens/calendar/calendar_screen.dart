import 'package:flutter/material.dart';
import 'package:mood_sync/shared/constants/custom_colors.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/my_events.dart';

var now = DateTime.now();
var firstDay = DateTime(now.year, now.month - 6, now.day);
var lastDay = DateTime(now.year, now.month + 6, now.day);

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  String nomeCidade = "";
  final _sentimentos = [
    '1 - Arrasado 😭',
    '3 - Frustrado 😕',
    '2 - Muito Triste ☹️',
    '4 - Cansado 😐',
    '5 - Indiferente 🤔',
    '6 - Satisfeito 😊',
    '7 - Tranquilo 🙂',
    '8 - Alegre 😀',
    '9 - Muito Feliz 😃',
    '10 - Radiante 🤩',
  ];
  var _itemSelecionado = '5 - Indiferente 🤔';

  var _focusedCalendarDate = DateTime.now().toLocal();
  DateTime? selectedCalendarDate;
  final titleController = TextEditingController();
  final descpController = TextEditingController();

  late Map<DateTime, List<MyEvents>> mySelectedEvents;

  @override
  void initState() {
    selectedCalendarDate = _focusedCalendarDate;
    // print('selectedCalendarDate: $selectedCalendarDate');
    mySelectedEvents = {};
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descpController.dispose();
    super.dispose();
  }

  List<MyEvents> _listOfDayEvents(DateTime dateTime) {
    return mySelectedEvents[dateTime] ?? [];
  }

  // void _dropDownItemSelected(String novoItem) {
  //   setState(() {
  //     _itemSelecionado = novoItem;
  //   });
  // }

  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('New Event'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  items:
                      _sentimentos.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                  onChanged: (String? novoItemSelecionado) {
                    // _dropDownItemSelected(novoItemSelecionado!);
                    setState(() {
                      _itemSelecionado = novoItemSelecionado!;
                      // print('selectedCalendarDate: $selectedCalendarDate');
                    });
                    titleController.text = _itemSelecionado;
                  },
                  value: _itemSelecionado,
                ),
                // buildTextField(
                //     controller: titleController, hint: 'Enter Title'),
                const SizedBox(height: 20.0),
                buildTextField(
                  controller: descpController,
                  hint: 'Enter Description',
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                child: const Text('Add'),
                onPressed: () {
                  if (titleController.text.isEmpty &&
                      descpController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter title & description'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                    //Navigator.pop(context);
                    return;
                  } else {
                    setState(() {
                      // print('selectedCalendarDate: $selectedCalendarDate');
                      if (mySelectedEvents[selectedCalendarDate] != null) {
                        mySelectedEvents[selectedCalendarDate]?.add(
                          MyEvents(
                            eventTitle: titleController.text,
                            eventDescp: descpController.text,
                          ),
                        );
                      } else {
                        mySelectedEvents[selectedCalendarDate!] = [
                          MyEvents(
                            eventTitle: titleController.text,
                            eventDescp: descpController.text,
                          ),
                        ];
                      }
                    });

                    titleController.clear();
                    descpController.clear();

                    Navigator.pop(context);
                    return;
                  }
                },
              ),
            ],
          ),
    );
  }

  Widget buildTextField({
    String? hint,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: hint ?? '',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Icon(Icons.add, color: Colors.white),
        backgroundColor: CustomColors().getActivePrimaryButtonColor(),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              side: BorderSide(color: Colors.black.withOpacity(0.1), width: .5),
            ),
            child: TableCalendar(
              locale: 'pt_BR',
              focusedDay: _focusedCalendarDate,
              firstDay: firstDay,
              lastDay: lastDay,
              calendarFormat: CalendarFormat.month,
              availableCalendarFormats: const {
                CalendarFormat.month: 'mês',
                CalendarFormat.week: 'semana',
                CalendarFormat.twoWeeks: '2 semanas',
              },
              headerStyle: HeaderStyle(
                leftChevronIcon: const Icon(
                  Icons.chevron_left,
                  size: 24,
                  color: Colors.black54,
                ),
                rightChevronIcon: const Icon(
                  Icons.chevron_right,
                  size: 24,
                  color: Colors.black54,
                ),
                headerPadding: EdgeInsets.zero,
                formatButtonVisible: false,
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: CustomColors().getActivePrimaryButtonColor(),
                  shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(15),
                ),
                formatButtonTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                titleTextStyle: TextStyle(
                  color: CustomColors().getActivePrimaryButtonColor(),
                ),
                titleCentered: true,
                titleTextFormatter: (date, locale) {
                  String month;
                  switch (date.month) {
                    case DateTime.january:
                      month = "Janeiro";
                      break;
                    case DateTime.february:
                      month = "Fevereiro";
                      break;
                    case DateTime.march:
                      month = "Março";
                      break;
                    case DateTime.april:
                      month = "Abril";
                      break;
                    case DateTime.may:
                      month = "Maio";
                      break;
                    case DateTime.june:
                      month = "Junho";
                      break;
                    case DateTime.july:
                      month = "Julho";
                      break;
                    case DateTime.august:
                      month = "Agosto";
                      break;
                    case DateTime.september:
                      month = "Setembro";
                      break;
                    case DateTime.october:
                      month = "Outubro";
                      break;
                    case DateTime.november:
                      month = "Novembro";
                      break;
                    case DateTime.december:
                      month = "Dezembro";
                      break;
                    default:
                      month = "Error";
                  }
                  return "$month ${date.year}";
                },
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Colors.red),
              ),
              calendarStyle: CalendarStyle(
                rangeEndDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                rangeHighlightColor: Colors.transparent,
                selectedDecoration: BoxDecoration(
                  color: CustomColors().getActivePrimaryButtonColor(),
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: const TextStyle(color: Color(0xFFEEE6E2)),
                todayDecoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                todayTextStyle: TextStyle(
                  color: CustomColors().getActivePrimaryButtonColor(),
                ),

                //modificando os dias da semana
                defaultDecoration: const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                defaultTextStyle: TextStyle(
                  color: CustomColors().getActivePrimaryButtonColor(),
                ),

                //modificando os finais de semana
                weekendDecoration: const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: TextStyle(
                  color: CustomColors().getActivePrimaryButtonColor(),
                ),
              ),
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  String text;
                  if (day.weekday == DateTime.sunday) {
                    text = 'Dom';
                  } else if (day.weekday == DateTime.monday) {
                    text = 'Seg';
                  } else if (day.weekday == DateTime.tuesday) {
                    text = 'Ter';
                  } else if (day.weekday == DateTime.wednesday) {
                    text = 'Qua';
                  } else if (day.weekday == DateTime.thursday) {
                    text = 'Qui';
                  } else if (day.weekday == DateTime.friday) {
                    text = 'Sex';
                  } else if (day.weekday == DateTime.saturday) {
                    text = 'Sáb';
                  } else {
                    text = 'err';
                  }
                  return Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: CustomColors().getActivePrimaryButtonColor(),
                      ),
                    ),
                  );
                },
              ),
              selectedDayPredicate: (currentSelectedDate) {
                // conforme a documentação 'selectedDayPredicate' precisa determinar
                // dia selecionado atual
                return (isSameDay(selectedCalendarDate!, currentSelectedDate));
              },
              onDaySelected: (selectedDay, focusedDay) {
                // conforme a documentação
                if (!isSameDay(selectedCalendarDate, selectedDay)) {
                  setState(() {
                    selectedCalendarDate = selectedDay;
                    _focusedCalendarDate = focusedDay;
                    // print('selectedCalendarDate: $selectedCalendarDate');
                  });
                }
              },
            ),
          ),
          ..._listOfDayEvents(selectedCalendarDate!).map(
            (myEvents) => ListTile(
              leading: const Icon(Icons.done, color: Colors.grey),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Emoção do dia:   ${myEvents.eventTitle}'),
              ),
              subtitle: Text('Descrição:   ${myEvents.eventDescp}'),
            ),
          ),
        ],
      ),
    );
  }
}
