import 'package:brachydium_searcher/screen/widgets/autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';

import '../../data/equipment.dart';

class ArmorEditor extends StatefulWidget {
  const ArmorEditor({super.key});

  @override
  State<ArmorEditor> createState() => _ArmorEditorState();
}

class _ArmorEditorState extends State<ArmorEditor> {
  List<Widget> _buildArmorList(BuildContext ctx) {
    List<Widget> widgets = [];
    for (var armor in All.armorList.reversed) {
      //if (armor.rarity == 11) {
      widgets.add(toWidget(armor, ctx));
      widgets.add(const Divider());
      //}
    }
    widgets.removeLast();
    return widgets;
  }

  Widget toWidget(Armor armor, BuildContext context) {
    var slots = armor.primarySlotSize == 0 ? ' - ' : ' ${armor.primarySlotSize} ';
    if (armor.secondarySlotSize > 0) slots += '${armor.secondarySlotSize} ';
    if (armor.ternarySlotSize > 0) slots += '${armor.ternarySlotSize} ';
    return InkWell(
      onTap: () => {showDialog(context: context, builder: (context) => openDialog(armor, context))},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(armor.name),
          ),
          Expanded(child: Text('${armor.rarity}')),
          Expanded(
              child: Text(
            slots,
          )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (armor.primary == All.undefined)
                  const Text('')
                else
                  Text('${armor.primary.name} + ${armor.primaryLv}'),
                if (armor.secondary != null) Text('${armor.secondary!.name} + ${armor.secondaryLv}'),
                if (armor.ternary != null) Text('${armor.ternary!.name} + ${armor.ternaryLv}'),
              ],
            ),
          ),
          Expanded(child: armor.groupBonus != null ? Text(armor.groupBonus!.name) : const Text('')),
          Expanded(child: armor.setBonus != null ? Text(armor.setBonus!.name) : const Text(''))
        ],
      ),
    );
  }

  Dialog openDialog(Armor armor, BuildContext context) {
    Skill? skill1 = armor.primary, skill2 = armor.secondary, skill3 = armor.ternary;
    int level1 = armor.primaryLv, level2 = armor.secondaryLv, level3 = armor.ternaryLv;
    BonusSkill? groupBonus = armor.groupBonus;
    BonusSkill? setBonus = armor.setBonus;
    int rarity = armor.rarity;
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 550),
        child: StatefulBuilder(builder: (context, setSubState) {
          return Column(
            children: [
              Text(armor.name),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Rarity:  ',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Expanded(
                    child: SpinBox(
                      min: All.minRarity.toDouble(),
                      max: All.maxRarity.toDouble(),
                      value: rarity.toDouble(),
                      onChanged: (val) {
                        setSubState(() {
                          rarity = val.toInt();
                        });
                      },
                    ),
                  )
                ],
              ),
              const Text("1st Skill"),
              _makeTextField(setSubState, () => skill1, (skill) => skill1 = skill, () => level1, (lv) => level1 = lv),
              const Text("2nd Skill"),
              _makeTextField(setSubState, () => skill2, (skill) => skill2 = skill, () => level2, (lv) => level2 = lv),
              const Text("3rd Skill"),
              _makeTextField(setSubState, () => skill3, (skill) => skill3 = skill, () => level3, (lv) => level3 = lv),
              const Divider(),
              const Text("Group Bonus"),
              _makeArmorBonusTextField(setSubState, () => groupBonus, (skill) => groupBonus = skill, SkillCategory.groupBonus),
              const Text("Set Bonus"),
              _makeArmorBonusTextField(setSubState, () => setBonus, (skill) => setBonus = skill, SkillCategory.setBonus),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: Colors.grey.shade800,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  MaterialButton(
                    color: Colors.green.shade700,
                    onPressed: () {
                      if (skill2 == All.undefined) skill2 = null;
                      if (skill3 == All.undefined) skill3 = null;
                      if (skill1 == null || skill1 == All.undefined) {
                        if (skill2 != null) {
                          if (skill3 != null) {
                            skill1 = skill2;
                            level1 = level2;
                            skill2 = skill3;
                            level2 = level3;
                            skill3 = null;
                            level3 = 0;
                          } else {
                            skill1 = skill2;
                            level1 = level2;
                            skill2 = null;
                            level2 = 0;
                          }
                        } else {
                          if (skill3 != null) {
                            skill1 = skill3;
                            level1 = level3;
                            skill3 = null;
                            level3 = 0;
                          } else {
                            skill1 = All.undefined;
                            level1 = 0;
                          }
                        }
                      } else if (skill2 == null && skill3 != null) {
                        skill2 = skill3;
                        level2 = level3;
                        skill3 = null;
                        level3 = 0;
                      }
                      Armor newArmor = armor.copyWith(
                          primary: skill1!,
                          secondary: skill2,
                          ternary: skill3,
                          groupBonus: groupBonus,
                          setBonus: setBonus,
                          primaryLv: level1,
                          secondaryLv: level2,
                          ternaryLv: level3,
                          rarity: rarity);
                      setState(() {
                        All.replaceArmor(armor, newArmor);
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Confirm'),
                  )
                ],
              )
            ],
          );
        }),
      ),
    );
  }

  Row _makeTextField<T>(StateSetter setState, Skill? Function() getter, void Function(Skill?) setter,
      int Function() lvlGetter, void Function(int) lvlSetter) {
    var current = getter();
    return Row(
      children: [
        Expanded(
          flex: 20,
          child: CustomAutocomplete(
              optionsBuilder: (value) {
                var t = value.text.toLowerCase();
                var l = All.skills.where((skill) => skill.name.toLowerCase().contains(t)).toList();
                l.sort((a, b) {
                  var sa = a.name.toLowerCase().startsWith(t);
                  var sb = b.name.toLowerCase().startsWith(t);
                  if (sa == sb) return 0;
                  if (sa && !sb) return -1;
                  return 1;
                });
                return l;
              },
              displayStringForOption: (skill) => skill.name,
              onSelected: (value) {
                setState(() {
                  setter(value);
                  lvlSetter(1);
                });
              },
              initialValue: current != null && current != All.undefined
                  ? TextEditingValue(
                      text: current.name, selection: TextSelection.collapsed(offset: current.name.length))
                  : null),
        ),
        const Spacer(),
        Expanded(
          flex: 6,
          child: SpinBox(
            min: (current != null && current != All.undefined ? 1.0 : 0.0),
            max: (current != null && current != All.undefined ? current.maxLevel.toDouble() : 0.0),
            value: lvlGetter().toDouble(),
            onChanged: (val) {
              setState(() {
                lvlSetter(val.toInt());
              });
            },
          ),
        ),
        Expanded(
            flex: 2,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    setter(All.undefined);
                    lvlSetter(0);
                  });
                },
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.red.shade700,
                )))
      ],
    );
  }

  Row _makeArmorBonusTextField<T>(
      StateSetter setState, BonusSkill? Function() getter, void Function(BonusSkill?) setter, SkillCategory category) {
    var current = getter();
    return Row(
      children: [
        Expanded(
          flex: 26,
          child: CustomAutocomplete(
              optionsBuilder: (value) {
                var t = value.text.toLowerCase();
                var l = All.armorBonuses.where((skill) => skill.category == category && skill.name.toLowerCase().contains(t)).toList();
                l.sort((a, b) {
                  var sa = a.name.toLowerCase().startsWith(t);
                  var sb = b.name.toLowerCase().startsWith(t);
                  if (sa == sb) return 0;
                  if (sa && !sb) return -1;
                  return 1;
                });
                return l;
              },
              displayStringForOption: (skill) => skill.name,
              onSelected: (value) {
                setState(() {
                  setter(value);
                });
              },
              initialValue: current != null
                  ? TextEditingValue(
                      text: current.name, selection: TextSelection.collapsed(offset: current.name.length))
                  : null),
        ),
        const Spacer(),
        Expanded(
            flex: 2,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    setter(null);
                  });
                },
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.red.shade700,
                )))
      ],
    );
  }

  bool _matches(TextEditingValue value, Skill skill) {
    return skill.name.toLowerCase().contains(value.text.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.grey.shade800,
            child: const Row(
              children: [
                Expanded(child: Text('Name', style: style)),
                Expanded(child: Text('Rarity', style: style)),
                Expanded(child: Text('Slots', style: style)),
                Expanded(child: Text('Skills', style: style)),
                Expanded(child: Text('Group Bonus', style: style)),
                Expanded(child: Text('Set Bonus', style: style)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView(
                children: _buildArmorList(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SkillEditor extends StatefulWidget {
  const SkillEditor({super.key});

  @override
  State<SkillEditor> createState() => _SkillEditorState();
}

class _SkillEditorState extends State<SkillEditor> {
  List<Widget> _buildSkillList(BuildContext ctx) {
    List<Widget> widgets = [];
    for (var skill in All.skills) {
      widgets.add(InkWell(
        onTap: () => {showDialog(context: context, builder: (context) => openDialog(skill, context))},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: Text(skill.name)),
            Expanded(child: Text('${skill.maxLevel}')),
            //if (skill.hasSecret) Expanded(child: Text('${skill.cappedMaxLevel}')) else const Expanded(child: Text(''))
          ],
        ),
      ));
      widgets.add(const Divider());
    }
    return widgets;
  }

  Dialog openDialog(Skill skill, BuildContext context) {
    int maxSecretLevel = skill.maxLevel;
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 400),
        child: StatefulBuilder(builder: (context, setSubState) {
          return Column(
            children: [
              Text(skill.name),
              const Divider(),
              SpinBox(
                min: 0.0,
                max: skill.maxLevel.toDouble(),
                value: maxSecretLevel.toDouble(),
                onChanged: (val) {
                  setSubState(() {
                    maxSecretLevel = val.toInt();
                  });
                },
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: Colors.grey.shade800,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  MaterialButton(
                    color: Colors.green.shade700,
                    onPressed: () {
                      Skill newSkill = skill.copyWith(maxLevel: maxSecretLevel);
                      setState(() {
                        All.replaceSkill(skill, newSkill);
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Confirm'),
                  )
                ],
              )
            ],
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.grey.shade800,
            child: const Row(
              children: [
                Expanded(child: Text('Name', style: style)),
                Expanded(child: Text('Max Lv.', style: style)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView(
                children: _buildSkillList(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
