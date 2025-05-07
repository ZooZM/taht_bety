import 'dart:async';

import 'package:draggable_float_widget/draggable_float_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taht_bety/constants.dart';

class ChatBotButton extends StatefulWidget {
  const ChatBotButton({
    super.key,
    required this.eventStreamController,
  });

  final StreamController<OperateEvent> eventStreamController;

  @override
  State<ChatBotButton> createState() => _ChatBotButtonState();
}

class _ChatBotButtonState extends State<ChatBotButton> {
  String widgetPosition = "Left side";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  BorderRadius _getBorderRadius() {
    switch (widgetPosition) {
      case "Right Side":
        return const BorderRadius.only(
          topLeft: Radius.circular(40),
          bottomLeft: Radius.circular(40),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        );
      case "Left Side":
        return const BorderRadius.only(
          topRight: Radius.circular(40),
          bottomRight: Radius.circular(40),
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        );
      default: // Middle
        return BorderRadius.circular(40);
    }
  }

  void _checkWidgetPosition() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      Offset offset = renderBox.localToGlobal(Offset.zero);
      double dx = offset.dx;
      double screenWidth = MediaQuery.of(context).size.width;

      String position;
      if (dx < screenWidth / 3) {
        position = "Left Side";
      } else if (dx > (2 * screenWidth) / 3) {
        position = "Right Side";
      } else {
        position = "Middle";
      }
      setState(() {
        widgetPosition = position;
        print(position);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkWidgetPosition();
    });

    return DraggableFloatWidget(
      eventStreamController: widget.eventStreamController,
      config: DraggableFloatWidgetBaseConfig(
        initPositionYMarginBorder: MediaQuery.of(context).size.height / 2 - 50,
        isFullScreen: true,
        initPositionYInTop: false,
        exposedPartWidthWhenHidden: 20,
        borderBottom: 50,
        borderLeft: -1,
        borderRight: -1,
        // debug: true,
      ),
      height: 50,
      width: 50,
      onTap: () async {
        // print(eventStreamController.toString());
        setState(() {});
        widget.eventStreamController.add(OperateEvent.OPERATE_SHOW);
        await Future.delayed(const Duration(seconds: 3));
        widget.eventStreamController.add(OperateEvent.OPERATE_HIDE);
        // print(eventStreamController.toString());
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: ksecondryColor.withOpacity(0.5),
          borderRadius: _getBorderRadius(),
        ),
        child: GestureDetector(
          child: const Icon(
            FontAwesomeIcons.solidComment,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
