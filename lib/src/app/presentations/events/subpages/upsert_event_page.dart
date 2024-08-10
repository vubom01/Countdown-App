import 'package:countdown/src/app/presentations/widgets/app_bar.dart';
import 'package:countdown/src/core/base_widget/base_view.dart';
import 'package:countdown/src/core/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:tekflat_design/tekflat_design.dart';

class UpsertEventPage extends StatefulWidget {
  const UpsertEventPage({super.key});

  @override
  State<UpsertEventPage> createState() => _UpsertEventPageState();
}

class _UpsertEventPageState extends State<UpsertEventPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool _isSelectTime = false;

  void _showDatePicker(BuildContext context, FormFieldState<DateTime> state) {
    showDatePicker(
      context: context,
      fieldHintText: TekDateTimeFormatter().dateFormatter,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      initialDate: state.value,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    ).then((value) => state.didChange(value));
  }

  void _showTimePicker(BuildContext context, FormFieldState<DateTime> state) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(state.value ?? DateTime.now()),
    ).then((value) => state.didChange(DateTime(value!.hour, value.minute)));
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: AppBarWidget(
        isBackButtonVisible: true,
        title: S.current.addEvent,
        iconColor: TekColors().primary,
        actions: [
          TekButton(
            text: S.current.done,
            size: TekButtonSize.medium,
            textColor: TekColors().primary,
            hoverColor: null,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(TekSpacings().p24),
        child: FormBuilder(
          key: _formKey,
          initialValue: {
            EventFormKey.$name: S.current.newEvent,
            EventFormKey.$date: DateTime.now(),
            EventFormKey.$time: DateFormat(TekDateTimeFormatter().timeFormatter).parse("09:00"),
          },
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: TekColors().greyOpacity02,
                ),
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                child: Column(
                  children: [
                    TekInput(
                      name: EventFormKey.$name,
                      hintText: S.current.eventName,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.transparent,
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    ),
                    TekDivider(color: TekColors().greyOpacity02),
                    TekInput(
                      name: EventFormKey.$note,
                      hintText: S.current.note,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.transparent,
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    ),
                  ],
                ),
              ),
              TekVSpace.mainSpace,
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: TekColors().greyOpacity02,
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: TekColors().red,
                            ),
                            TekHSpace.p4,
                            Text(S.current.date),
                          ],
                        ),
                        FormBuilderField<DateTime>(
                          name: EventFormKey.$date,
                          builder: (FormFieldState<DateTime> state) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: context.colorScheme.background,
                              ),
                              padding:
                                  EdgeInsets.fromLTRB(TekSpacings().p4, 0, TekSpacings().p4, 0),
                              child: TekButtonInkwell(
                                onPressed: () => _showDatePicker(context, state),
                                child: TekTypography(
                                  text: DateFormat(TekDateTimeFormatter().dateFormatter).format(
                                    state.value ?? DateTime.now(),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const TekVSpace(10),
                    TekDivider(color: TekColors().greyOpacity02),
                    const TekVSpace(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_outlined,
                              color: TekColors().blue,
                            ),
                            TekHSpace.p4,
                            Text(S.current.time),
                          ],
                        ),
                        AdvancedSwitch(
                          width: 44,
                          height: 22,
                          initialValue: _isSelectTime,
                          activeColor: TekColors().primary,
                          onChanged: (value) {
                            setState(() {
                              _isSelectTime = value;
                            });
                          },
                        ),
                      ],
                    ),
                    if (_isSelectTime) ...[
                      const TekVSpace(10),
                      TekDivider(color: TekColors().greyOpacity02),
                      const TekVSpace(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FormBuilderField<DateTime>(
                            name: EventFormKey.$time,
                            builder: (FormFieldState<DateTime> state) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: context.colorScheme.background,
                                ),
                                padding:
                                    EdgeInsets.fromLTRB(TekSpacings().p4, 0, TekSpacings().p4, 0),
                                child: TekButtonInkwell(
                                  onPressed: () => _showTimePicker(context, state),
                                  child: TekTypography(
                                    text: DateFormat(TekDateTimeFormatter().timeFormatter).format(
                                      state.value ?? DateTime.now(),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              TekVSpace.mainSpace,
              TekButton(
                text: S.current.done,
                type: TekButtonType.primary,
                width: double.infinity,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EventFormKey {
  static const String $name = "name";
  static const String $note = "note";
  static const String $date = "date";
  static const String $time = "time";
}
