import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:brachys_armor_set_searcher/bloc/cubits.dart';
import 'package:brachys_armor_set_searcher/data/equipment.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';

class ArmorFilters extends StatefulWidget {
  const ArmorFilters({super.key, required this.mobile});

  final bool mobile;

  @override
  State<ArmorFilters> createState() => _ArmorFiltersState();
}

class _ArmorFiltersState extends _AbstractSearcherPageState<ArmorFilters> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Portal(
        child: Column(
          children: [
            BlocBuilder<SearcherArgsCubit, SearcherArgsState>(
              buildWhen: (a, b) => a.minRarity != b.minRarity || a.maxRarity != b.maxRarity,
              builder: (context, state) {
                return Column(
                  children: [
                    Text(
                      'Rarity Limit: ${state.minRarity} - ${state.maxRarity} (Including)',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    RangeSlider(
                        min: All.minRarity.toDouble(),
                        max: All.maxRarity.toDouble(),
                        divisions: All.maxRarity - All.minRarity,
                        values: RangeValues(state.minRarity.toDouble(), state.maxRarity.toDouble()),
                        onChanged: (val) =>
                            context.read<SearcherArgsCubit>().updateRarity(val.start.toInt(), val.end.toInt())),
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: MaterialButton(
                onPressed: () {
                  showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Remove all blacklisted Armors?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context), child: const Text('No')),
                            TextButton(
                                onPressed: () {
                                  context.read<SearcherArgsCubit>().clearBlacklistedEquipment();
                                  Navigator.pop(context);
                                },
                                child: const Text('Yes')),
                          ],
                        );
                      });
                },
                minWidth: double.infinity,
                height: 48,
                color: Colors.red.withAlpha(150),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: const Text('Remove all blacklisted Armors'),
              ),
            ),
            Expanded(
                child: BlocBuilder<SearcherArgsCubit, SearcherArgsState>(
              buildWhen: (a, b) => !setEquals(a.blacklistedArmors, b.blacklistedArmors),
              builder: (context, state) {
                return ListView(
                  children: _buildArmorTiles(context, state.blacklistedArmors),
                );
              },
            )),
            _skillSelector(250)
          ],
        ),
      ),
    );
  }

  List<Widget> _buildArmorTiles(BuildContext context, Set<Armor> blacklistedArmor) {
    return blacklistedArmor.map((armor) {
      return Dismissible(
        key: Key(armor.name),
        onDismissed: (dir) => context.read<SearcherArgsCubit>().removeBlacklistedArmor(armor),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white12),
          child: Row(
            children: [
              Text(armor.localizedName),
              const Spacer(),
              IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.all(0),
                  constraints: BoxConstraints(minWidth: 24, minHeight: 24),
                  onPressed: () => context.read<SearcherArgsCubit>().removeBlacklistedArmor(armor),
                  icon: Icon(Icons.delete))
            ],
          ),
        ),
      );
    }).toList();
  }
}

abstract class _AbstractSearcherPageState<T extends StatefulWidget> extends State<T>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
  }

  Widget _optionsList(
      BuildContext context, SearcherArgsState state, SkillSelectorState selectorState, double maxHeight) {
    if (!selectorState.shown) return const SizedBox.shrink();
    List<Widget> options = [];
    List<Armor> armors = List.of(All.armorList);
    if (selectorState.searchValue.isEmpty) {
      if (state.skills.isNotEmpty) {
        armors = armors.where((armor) => !state.hasArmorBlacklisted(armor)).toList();
      }
    } else {
      armors = armors
          .where((armor) => armor.matchesSearch(selectorState.searchValue) && !state.hasArmorBlacklisted(armor))
          .toList();
    }
    if (armors.isEmpty) {
      options.add(const Padding(
        padding: EdgeInsets.all(4),
        child: Row(
          children: [
            Text(
              'No matches',
              style: TextStyle(fontSize: 15),
            ),
            Padding(padding: EdgeInsets.only(left: 4)),
            Icon(
              Icons.accessible_forward,
              color: Colors.red,
            )
          ],
        ),
      ));
    } else {
      armors.sort((a, b) => a.compareForSearch(b, selectorState.searchValue));
      for (Armor armor in armors) {
        options.add(InkWell(
            onTap: () {
              context.read<SearcherArgsCubit>().addBlacklistedArmor(armor);
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Text(
                armor.localizedName,
                style: const TextStyle(fontSize: 15),
              ),
            )));
        options.add(const Divider(
          height: 4,
          thickness: 0.5,
        ));
      }
      options.removeLast();
    }
    Color color = const Color.fromARGB(0, 30, 30, 30);
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (BuildContext context, Widget? child) {
        double value = Curves.easeOutQuad.transform(_animationController!.value);
        double scale = value * 0.1 + 0.90;
        return Transform.scale(
            scale: scale,
            child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxHeight),
                child: BlurryContainer(
                  blur: 10,
                  color: color.withAlpha((100 * value + 50).toInt()),
                  padding: const EdgeInsets.all(4),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: child!,
                )));
      },
      child: TapRegion(
        groupId: "eq_selector",
        consumeOutsideTaps: true,
        onTapOutside: (event) {
          _hideOptions(context, selectorState);
        },
        child: ListView(
          shrinkWrap: true,
          children: options,
        ),
      ),
    );
  }

  void _showOptions(BuildContext context, SkillSelectorState state) {
    if (state.shown) return;
    context.read<SkillSelectorCubit>().updateShown(true);
    _animationController!.forward(from: 0);
  }

  void _hideOptions(BuildContext context, SkillSelectorState state) {
    if (!state.shown) return;
    context.read<SkillSelectorCubit>().updateShown(false);
    _animationController!.value = 0;
  }

  void _updateOptions(BuildContext context, String value) {
    context.read<SkillSelectorCubit>().update(true, value.toLowerCase());
    _animationController!.forward();
  }

  Widget _skillSelector(double maxListHeight) {
    //return AutoCompleteField(link: _link);
    return BlocBuilder<SkillSelectorCubit, SkillSelectorState>(
      builder: (context, selectorState) {
        return PortalTarget(
            portalFollower: Material(
              color: Colors.black.withAlpha(0),
              child: BlocBuilder<SearcherArgsCubit, SearcherArgsState>(
                buildWhen: (a, b) => !listEquals(a.skills, b.skills),
                builder: (context, state) {
                  return _optionsList(context, state, selectorState, maxListHeight);
                },
              ),
            ),
            visible: selectorState.shown,
            anchor: const Aligned(
              follower: Alignment.bottomLeft,
              target: Alignment.topLeft,
              portal: Alignment.topCenter,
              //alignToPortal: AxisFlag(y: true, x: true)
            ),
            child: TapRegion(
              groupId: "eq_selector",
              onTapOutside: (event) => _hideOptions(context, selectorState),
              child: TextField(
                controller: _controller,
                onTap: () => _showOptions(context, selectorState),
                onChanged: (val) => _updateOptions(context, val),
                onSubmitted: (val) => _hideOptions(context, selectorState),
                onEditingComplete: () => _hideOptions(context, selectorState),
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                    hintText: 'Blacklist Equipment',
                    hintStyle: TextStyle(color: Colors.white.withAlpha(80)),
                    icon: const Icon(Icons.search)),
              ),
            ));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
    _animationController!.dispose();
  }
}
