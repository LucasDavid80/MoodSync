import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mood_sync/models/user_model.dart';
import 'package:mood_sync/shared/constants/custom_colors.dart';
import 'package:mood_sync/shared/constants/emotion_constants.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/my_emotion.dart';
import '../../shared/widgets/add_emotion_dialog.dart';

var now = DateTime.now();
var firstDay = DateTime(now.year, now.month - 6, now.day);
var lastDay = DateTime(now.year, now.month + 6, now.day);

class CalendarScreen extends StatefulWidget {
  final User user;
  const CalendarScreen({super.key, required this.user});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  var _itemSelecionado = sentimentos[4];

  var _focusedCalendarDate = DateTime.now().toLocal();
  DateTime? selectedCalendarDate;
  final titleController = TextEditingController();
  final descpController = TextEditingController();

  late Map<DateTime, List<MyEmotion>> mySelectedEvents;

  @override
  void initState() {
    selectedCalendarDate = _focusedCalendarDate;
    mySelectedEvents = {};
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descpController.dispose();
    super.dispose();
  }

  List<MyEmotion> _listOfDayEvents(DateTime dateTime) {
    // Retorna as emoções associadas à data selecionada
    return mySelectedEvents[dateTime] ?? [];
  }

  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder:
          (context) => AddEmotionDialog(
            sentimentos: sentimentos,
            titleController: titleController,
            descpController: descpController,
            itemSelecionado: _itemSelecionado,
            date: selectedCalendarDate!,
            onItemChanged: (novoItemSelecionado) {
              setState(() {
                _itemSelecionado = novoItemSelecionado;
                titleController.text = _itemSelecionado;
              });
            },
            onEmotionAdded: (emotion) {
              setState(() {
                if (mySelectedEvents[selectedCalendarDate] != null) {
                  mySelectedEvents[selectedCalendarDate]?.add(emotion);
                } else {
                  mySelectedEvents[selectedCalendarDate!] = [emotion];
                }
              });
              titleController.clear();
              descpController.clear();
            },
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
              // locale: 'pt_BR',
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
                  });
                }
              },
            ),
          ),
          ..._listOfDayEvents(selectedCalendarDate!).map((myEmotions) {
            debugPrint('Emoção do dia:   ${myEmotions.emocao}');
            debugPrint('Descrição:   ${myEmotions.descricao}');
            return ListTile(
              leading: const Icon(Icons.done, color: Colors.grey),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Emoção do dia:   ${myEmotions.emocao}'),
              ),
              subtitle: Text('Descrição:   ${myEmotions.descricao}'),
            );
          }),
        ],
      ),
    );
  }
}
