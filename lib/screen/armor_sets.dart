import 'package:brachydium_searcher/bloc/cubits.dart';
import 'package:brachydium_searcher/data/equipment.dart';
import 'package:brachydium_searcher/screen/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArmorSetsPageMobile extends StatefulWidget {
  const ArmorSetsPageMobile({super.key, required this.mobile});

  final bool mobile;

  @override
  State<ArmorSetsPageMobile> createState() => _ArmorSetsPageMobileState();
}

class _ArmorSetsPageMobileState extends State<ArmorSetsPageMobile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArmorSetCubit, Map<String, ArmorSet>>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(8),
          constraints: BoxConstraints(maxWidth: 600),
          child: ListView(
            children: [for (var e in state.entries) _armorSetTile(context, e.key, e.value)],
          ),
        );
      },
    );
  }

  Widget _armorSetTile(BuildContext context, String name, ArmorSet set) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () => ArmorSetPage.show(context, widget.mobile, set, false),
        child: Container(
          height: 48,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white24),
          child: Row(
            children: [
              Expanded(
                  child: Center(
                      child: Text(
                name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ))),
              IconButton(onPressed: () => context.read<ArmorSetCubit>().removeSet(name), icon: Icon(Icons.delete))
            ],
          ), // show additional info like weapon, element
        ),
      ),
    );
  }
}

class ArmorSetPage {
  ArmorSetPage._();

  static void show(BuildContext context, bool mobile, ArmorSet set, bool withSaveButton) {
    if (mobile) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => SimplePage(
                body: ArmorSetPageMobile(
                  set: set,
                  withSaveButton: withSaveButton,
                ),
                title: 'Armor Set View',
              )));
      return;
    }
    showDialog(context: context, builder: (ctx) => ArmorSetPage.armorSetDialog(ctx, set, withSaveButton));
  }

  static Dialog armorSetDialog(BuildContext context, ArmorSet set, bool withSaveButton) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: 750, maxHeight: withSaveButton ? 505 : /*475*/ 505, minWidth: 400, minHeight: 200),
          child: Row(
            children: [
              Expanded(
                flex: 10,
                child: Column(
                  children: [
                    ArmorSetPage.equipment(
                        context, EquipmentPiece(equipment: All.dummyWeapon, decorations: set.weaponDecos)),
                    ArmorSetPage.equipment(context, set.pieces[0]),
                    ArmorSetPage.equipment(context, set.pieces[1]),
                    ArmorSetPage.equipment(context, set.pieces[2]),
                    ArmorSetPage.equipment(context, set.pieces[3]),
                    ArmorSetPage.equipment(context, set.pieces[4]),
                    ArmorSetPage.charm(context, set.charm),
                    if (withSaveButton) ArmorSetPage.saveButton(context, set)
                  ],
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16), color: Colors.white.withAlpha(40)),
                            padding: const EdgeInsets.all(8),
                            child: ListView(
                              children: [
                                Center(
                                  child: Text(
                                    'Skills',
                                    style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w600),
                                  ),
                                ),
                                ...ArmorSetPage.buildSkills(set)
                              ],
                            ),
                          ),
                        ),
                      ),
                      //ArmorSetPage.legend()
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  static Widget equipment(BuildContext context, EquipmentPiece eq) {
    String name;
    if (eq.equipment == All.dummyArmor) {
      name = 'Empty';
    } else if (eq.equipment == All.dummyWeapon) {
      name = '';
    } else {
      name = eq.equipment.localizedName;
    }
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white.withAlpha(40)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 5,
              child: Text(
                eq.equipment.part.localizedName,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              )),
          // TODO replace with icon
          Expanded(flex: 15, child: Text(name)),
          Expanded(flex: 1, child: slotSizes(eq.equipment)),
          // TODO replace with icons (rive)
          Expanded(flex: 15, child: decos(eq.equipment, eq.decorations))
        ],
      ),
    );
  }

  static Widget slotSizes(Equipment eq) {
    if (eq is SlottedEquipment) {
      var seq = eq as SlottedEquipment;
      TextStyle style = const TextStyle(fontSize: 12);
      return Column(
        children: [
          Text(
            seq.primarySlotSize == 0 ? '-' : seq.primarySlotSize.toString(),
            style: style,
          ),
          Text(
            seq.secondarySlotSize == 0 ? '-' : seq.secondarySlotSize.toString(),
            style: style,
          ),
          Text(
            seq.ternarySlotSize == 0 ? '-' : seq.ternarySlotSize.toString(),
            style: style,
          ),
        ],
      );
    }
    return const Text('-');
  }

  static Widget decos(Equipment eq, List<Deco?> decos) {
    TextStyle style = const TextStyle(fontSize: 12);
    return Column(
      children: [
        Text(decos[0] == null ? '-' : decos[0]!.localizedName, style: style),
        Text(decos[1] == null ? '-' : decos[1]!.localizedName, style: style),
        Text(decos[2] == null ? '-' : decos[2]!.localizedName, style: style),
      ],
    );
  }

  static Widget charm(BuildContext context, Charm charm) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white.withAlpha(40)),
      child: Row(
        children: [
          Expanded(
              flex: 5,
              child: Text(charm.part.localizedName, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
          Expanded(flex: 15, child: Text(charm.localizedName)),
          const Spacer(
            flex: 1,
          ),
          const Spacer(
            flex: 15,
          )
        ],
      ),
    );
  }

  static List<Widget> buildSkills(ArmorSet armorSet) {
    var l = armorSet.calculateSkills(removeNonFullBonus: true, removeOverlevel: false);
    return [
      ...[l.where((s) => s.value.category == SkillCategory.weapon).map(_skillText)]
          .firstWhere((e) => e.isNotEmpty, orElse: () => [_skillIssue('weapon')]),
      Divider(height: 4, color: Colors.white),
      ...[l.where((s) => s.value.category == SkillCategory.armor).map(_skillText)]
          .firstWhere((e) => e.isNotEmpty, orElse: () => [_skillIssue('armor')]),
      Divider(
        height: 4,
        color: Colors.white,
      ),
      ...[
        l
            .where((s) => s.value.category == SkillCategory.setBonus || s.value.category == SkillCategory.groupBonus)
            .map(_skillText)
      ].firstWhere((e) => e.isNotEmpty, orElse: () => [_skillIssue('bonus')]),
    ];
  }

  static Widget _skillText(Leveled<SkillTemplate> skill) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        skill.value.localize(skill.level, capAtMax: false),
        style: TextStyle(color: skill.value.getColor(skill.level)),
      ),
    );
  }

  static Widget _skillIssue(String category) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        'No $category skills',
        style: TextStyle(color: Colors.white70),
      ),
    );
  }

  static Widget legendPiece(Color color, String text) {
    return Row(children: [
      Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.only(right: 4),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: color)),
      Text(text)
    ]);
  }

  static Widget legend() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white.withAlpha(40)),
      child: Column(
        children: [
          Center(
            child: Text(
              'Legend',
              style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w600),
            ),
          ),
          legendPiece(Colors.blue.shade300, 'Maxed Skill'),
          legendPiece(Colors.white70, 'Activated Skill'),
          //legendPiece(Colors.red.shade300, 'Unactivated Bonus Skill'),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  '(+X)',
                  style: TextStyle(color: Colors.blue.shade300),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4, bottom: 4),
                child: Text('Overleveled Skill'),
              )
            ],
          )
        ],
      ),
    );
  }

  static Widget saveButton(BuildContext context, ArmorSet set) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
      child: MaterialButton(
        onPressed: () => showDialog(
            context: context,
            builder: (context) {
              var controller = TextEditingController();
              return AlertDialog(
                title: Text('Save armor set with name'),
                content: TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText: 'Armor set name', icon: Icon(Icons.edit)),
                ),
                actions: [
                  MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      context.read<ArmorSetCubit>().addSet(controller.text, set);
                      Navigator.pop(context);
                    },
                    color: Colors.deepPurple.shade500,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Text('Save'),
                  )
                ],
              );
            }),
        height: 32,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.deepPurple.shade500,
        child: Text('Save armor set'),
      ),
    );
  }
}

class ArmorSetPageMobile extends StatelessWidget {
  const ArmorSetPageMobile({super.key, required this.set, required this.withSaveButton});

  final ArmorSet set;
  final bool withSaveButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ArmorSetPage.equipment(
                    context, EquipmentPiece(equipment: All.dummyWeapon, decorations: set.weaponDecos)),
                ArmorSetPage.equipment(context, set.pieces[0]),
                ArmorSetPage.equipment(context, set.pieces[1]),
                ArmorSetPage.equipment(context, set.pieces[2]),
                ArmorSetPage.equipment(context, set.pieces[3]),
                ArmorSetPage.equipment(context, set.pieces[4]),
                ArmorSetPage.charm(context, set.charm),
                const Divider(),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white.withAlpha(40)),
                  padding: const EdgeInsets.all(8),
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Skills',
                          style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w600),
                        ),
                      ),
                      ...ArmorSetPage.buildSkills(set)
                    ],
                  ),
                ),
                ArmorSetPage.legend()
              ],
            ),
          ),
          if (withSaveButton) ArmorSetPage.saveButton(context, set)
        ],
      ),
    );
  }
}
