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
      fieldHintText: "dd/MM/yyyy",
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      initialDate: state.value,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    ).then((value) => state.didChange(value));
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: AppBarWidget(
        isBackButtonVisible: true,
        title: S.current.addEvent,
      ),
      child: Padding(
        padding: EdgeInsets.all(TekSpacings().p8),
        child: FormBuilder(
          key: _formKey,
          initialValue: {
            EventFormKey.$name: S.current.newEvent,
            EventFormKey.$date: DateTime.now(),
          },
          child: Column(
            children: [
              TekInput(
                name: EventFormKey.$name,
                hintText: S.current.eventName,
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0),
                  ),
                  borderSide: BorderSide(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0),
                  ),
                  borderSide: BorderSide(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                onTap: () {},
              ),
              TekInput(
                name: EventFormKey.$note,
                hintText: S.current.note,
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                  borderSide: BorderSide(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                  borderSide: BorderSide(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
              ),
              TekVSpace.mainSpace,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: context.colorScheme.onBackground),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.fromLTRB(TekSpacings().p8, 0, TekSpacings().p8, 0),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.date_range_outlined,
                          color: TekColors().red,
                        ),
                        TekHSpace.p4,
                        Text(S.current.date),
                      ],
                    ),
                    Expanded(
                      flex: 0,
                      child: FormBuilderField<DateTime>(
                        name: EventFormKey.$date,
                        builder: (FormFieldState<DateTime> state) {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: context.colorScheme.onBackground),
                              borderRadius: BorderRadius.circular(4),
                              color: TekColors().greyOpacity06,
                            ),
                            padding: EdgeInsets.fromLTRB(TekSpacings().p4, 0, TekSpacings().p4, 0),
                            child: TekButtonInkwell(
                              onPressed: () => _showDatePicker(context, state),
                              child: TekTypography(
                                text: DateFormat("dd/MM/yyyy").format(
                                  state.value ?? DateTime.now(),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: context.colorScheme.onBackground),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.fromLTRB(TekSpacings().p8, 0, TekSpacings().p8, 0),
                height: 40,
                child: Row(
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
                      }
                    ),
                  ],
                ),
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
