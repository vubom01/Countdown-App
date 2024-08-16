import 'package:bottom_picker/bottom_picker.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:countdown/src/app/data/data_sources/locals/event_local.dart';
import 'package:countdown/src/app/presentations/events/events_controller.dart';
import 'package:countdown/src/app/presentations/widgets/app_bar.dart';
import 'package:countdown/src/core/base_widget/base_view.dart';
import 'package:countdown/src/core/constants/datetimes.dart';
import 'package:countdown/src/core/l10n/generated/l10n.dart';
import 'package:countdown/src/core/styles/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tekflat_design/tekflat_design.dart';

class UpsertEventPage extends StatefulWidget {
  final EventLocal? event;

  const UpsertEventPage({super.key, this.event});

  @override
  State<UpsertEventPage> createState() => _UpsertEventPageState();
}

class _UpsertEventPageState extends State<UpsertEventPage> {
  EventsController get _controller => EventsController.to;

  final _formKey = GlobalKey<FormBuilderState>();

  bool _isSelectTime = false;

  @override
  void initState() {
    super.initState();
    if (widget.event?.time != null) {
      _isSelectTime = true;
    }
  }

  void _showDatePicker(BuildContext context, FormFieldState<DateTime> state) {
    final config = CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.single,
      cancelButtonTextStyle: TextStyle(
        fontSize: TekFontSizes().s12,
        color: TekColors().primary,
      ),
      okButtonTextStyle: TextStyle(
        fontSize: TekFontSizes().s12,
        color: TekColors().primary,
      ),
      selectedDayHighlightColor: TekColors().primary,
    );
    showCalendarDatePicker2Dialog(
      context: context,
      config: config,
      dialogSize: const Size(325, 100),
      borderRadius: BorderRadius.circular(15),
      value: [state.value],
    ).then((values) {
      if (values != null && values.isNotEmpty) {
        state.didChange(values[0]);
      }
    });
  }

  void _showTimePicker(BuildContext context, FormFieldState<DateTime> state) {
    BottomPicker.time(
      pickerTitle: const Text(''),
      pickerTextStyle: TextStyle(
        fontFamily: TekFonts().display,
        fontSize: TekFontSizes().s16,
        color: context.colorScheme.onSurface,
      ),
      initialTime: Time(hours: state.value!.hour, minutes: state.value!.minute),
      use24hFormat: true,
      buttonSingleColor: TekColors().primary,
      backgroundColor: context.colorScheme.onBackground,
      closeIconColor: context.colorScheme.onSurface,
      onSubmit: (value) {
        state.didChange(value);
      },
    ).show(context);
  }

  void _onUpsertEvent() {
    String name = _formKey.currentState!.fields[EventFormKey.$name]?.value ?? S.current.newEvent;
    String? note = _formKey.currentState!.fields[EventFormKey.$note]?.value;
    String date = DateFormat(DateTimeFormatters.dateFormat)
        .format(_formKey.currentState!.fields[EventFormKey.$date]?.value);
    String? time = _isSelectTime
        ? DateFormat(DateTimeFormatters.timeFormat)
            .format(_formKey.currentState!.fields[EventFormKey.$time]?.value)
        : null;

    name = name.isEmpty ? "New event" : name;
    note = (note == null || note.isEmpty) ? null : note;

    if (widget.event?.id != null) {
      _controller
          .upsertEvent(
        EventLocal()
          ..id = widget.event?.id ?? 0
          ..name = name
          ..note = note
          ..date = date
          ..time = time,
      )
          .then((value) {
        context.popNavigator();
      });
    }

    if (widget.event?.id == null) {
      _controller
          .upsertEvent(
        EventLocal()
          ..name = name
          ..note = note
          ..date = date
          ..time = time,
      )
          .then((value) {
        context.popNavigator();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: AppBarWidget(
        title: widget.event == null ? S.current.addEvent : S.current.updateEvent,
        leading: Align(
          alignment: Alignment.centerRight,
          child: TekButtonInkwell(
            onPressed: () => context.popNavigator(),
            text: S.current.cancel,
            textColor: TekColors().primary,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: TekSpacings().p8),
            child: TekButtonInkwell(
              onPressed: _onUpsertEvent,
              text: S.current.done,
              textColor: TekColors().primary,
            ),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(TekSpacings().p24),
        child: FormBuilder(
          key: _formKey,
          initialValue: {
            EventFormKey.$name: widget.event?.name,
            EventFormKey.$note: widget.event?.note,
            EventFormKey.$date: DateFormat(DateTimeFormatters.dateFormat).parse(
              widget.event?.date ??
                  DateFormat(DateTimeFormatters.dateFormat).format(DateTime.now()),
            ),
            EventFormKey.$time: DateFormat(DateTimeFormatters.timeFormat).parse(
              widget.event?.time ?? "09:00",
            ),
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
                            SvgPicture.asset(
                              AppSvgIcons.calendarMultiColor,
                              width: 20,
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
                                borderRadius: BorderRadius.circular(8),
                                color: context.colorScheme.background,
                              ),
                              padding:
                                  EdgeInsets.fromLTRB(TekSpacings().p4, 0, TekSpacings().p4, 0),
                              child: TekButtonInkwell(
                                onPressed: () => _showDatePicker(context, state),
                                child: TekTypography(
                                  text: DateFormat(DateTimeFormatters.dateFormat).format(
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
                            SvgPicture.asset(
                              AppSvgIcons.clockMultiColor,
                              width: 20,
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
                                  borderRadius: BorderRadius.circular(8),
                                  color: context.colorScheme.background,
                                ),
                                padding:
                                    EdgeInsets.fromLTRB(TekSpacings().p4, 0, TekSpacings().p4, 0),
                                child: TekButtonInkwell(
                                  onPressed: () => _showTimePicker(context, state),
                                  child: TekTypography(
                                    text: DateFormat(DateTimeFormatters.timeFormat).format(
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
                onPressed: _onUpsertEvent,
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
