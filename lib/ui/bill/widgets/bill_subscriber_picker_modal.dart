import 'dart:math';

import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/utils/extensions.dart';
import 'package:blitter_flutter_app/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:blitter_flutter_app/data/blocs/blocs.dart';
import './user_avatar_placeholder.dart';
import 'bottom_modal_button.dart';

class BillSubscriberPickerModal extends StatefulWidget {
  const BillSubscriberPickerModal({
    Key? key,
    required this.getBillModalInput,
    required this.calculateSubscriberAmountHandler,
  }) : super(key: key);

  final ValueGetter<BillModalInput> getBillModalInput;
  final Function calculateSubscriberAmountHandler;

  @override
  State<BillSubscriberPickerModal> createState() =>
      _BillSubscriberPickerModalState();
}

class _BillSubscriberPickerModalState extends State<BillSubscriberPickerModal> {
  @override
  Widget build(BuildContext context) {
    final contactBloc = context.read<ContactBloc>();
    final mediaQuery = MediaQuery.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final contactList = contactBloc.state.objectMap!.values.toList();
    final authBloc = context.read<AuthBloc>();
    final billModalInput = widget.getBillModalInput();
    final loggedInUserSubscriberIndex = contactList.indexWhere(
      (element) => element.id == authBloc.state.user!.id,
    );

    final Map<int, User> selectedSubscribers = {};
    for (final element in billModalInput.subscribers) {
      selectedSubscribers[element.user] =
          contactBloc.getUserById(element.user)!;
    }

    void _toggleAddRemoveSubscribers(User user) {
      if (selectedSubscribers.containsKey(user.id)) {
        selectedSubscribers.remove(user.id);
      } else {
        selectedSubscribers[user.id] = user;
      }
    }

    Future<void> _onSubmit() async {
      billModalInput.subscribers.clear();
      for (var element in selectedSubscribers.entries) {
        billModalInput.subscribers
            .add(BillSubscriberInput(user: element.key, amount: '0'));
      }
      widget.calculateSubscriberAmountHandler();
      Navigator.pop(context);
    }

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 55),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 40, left: 20, right: 20, bottom: 40),
                  width: double.infinity,
                  child: Text(
                    "Pick Contacts",
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  mainAxisExtent: 125,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final contact = contactList[
                        index >= loggedInUserSubscriberIndex
                            ? index + 1
                            : index];
                    return SelectableItem(
                      getBgColor: () => Colors.accents[Random().nextInt(16)],
                      isSelected: () =>
                          selectedSubscribers.containsKey(contact.id),
                      user: contact,
                      onClick: _toggleAddRemoveSubscribers,
                    );
                  },
                  childCount: contactList.length - 1,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: 55,
            color: colorScheme.modalBackground,
            width: mediaQuery.size.width,
            child: BottomModalButton(
              label: 'Add',
              onPressed: _onSubmit,
              validate: () async => true,
            ),
          ),
        ),
      ],
    );
  }
}

class SelectableItem extends StatefulWidget {
  const SelectableItem({
    Key? key,
    required this.isSelected,
    required this.getBgColor,
    required this.user,
    required this.onClick,
  }) : super(key: key);

  final Function isSelected;
  final Function getBgColor;
  final Function onClick;
  final User user;

  @override
  State<SelectableItem> createState() => _SelectableItemState();
}

class _SelectableItemState extends State<SelectableItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await widget.onClick(widget.user);
        setState(() {});
      },
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: widget.getBgColor(),
                radius: 35,
                child: ClipOval(
                  child: CachedNetworkImage(
                    fadeOutDuration: const Duration(milliseconds: 250),
                    imageUrl: widget.user.avatar ?? '',
                    fit: BoxFit.cover,
                    height: 25,
                    width: 25,
                    placeholder: (context, url) => UserAvatarPlaceholder(
                      initialAlphabet: widget.user.name![0],
                      size: 20,
                    ),
                    errorWidget: (context, url, error) => UserAvatarPlaceholder(
                      initialAlphabet: widget.user.name![0],
                      size: 20,
                    ),
                  ),
                ),
              ),
              widget.isSelected()
                  ? const Positioned(
                      child: CircleAvatar(
                        radius: 12,
                        child: Icon(
                          Icons.check,
                          size: 20,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.white,
                      ),
                      right: 0,
                      top: 0,
                    )
                  : const SizedBox.shrink()
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.user.name!,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
          Text(
            widget.user.phoneNumber,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
