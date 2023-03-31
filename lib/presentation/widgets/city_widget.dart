import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:weather_apple/data/models/city_model.dart';
import 'package:weather_apple/presentation/bloc/search/search_cubit.dart';

class CityWidget extends StatefulWidget {
  final CityModel cityModel;
  final bool enabled;

  const CityWidget({super.key, required this.cityModel, required this.enabled});

  @override
  State<CityWidget> createState() => CityWidgetState();
}

class CityWidgetState extends State<CityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Center(
              child: Text(
                widget.cityModel.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                  fontSize: 40,
                ),
              ),
            ),
          ),
          Center(
            child: LiteRollingSwitch(
                value: widget.enabled,
                width: 50,
                colorOn: Colors.green,
                colorOff: Colors.red,
                iconOn: Icons.check,
                iconOff: Icons.cancel,
                animationDuration: const Duration(milliseconds: 300),
                onTap: () {},
                onDoubleTap: () {},
                onSwipe: () {},
                onChanged: (bool state) {
                  if (state) {
                    context.read<SearchCubit>().enableCity(widget.cityModel);
                  } else {
                    context.read<SearchCubit>().disableCity(widget.cityModel);
                  }
                }),
          ),
        ],
      ),
    );
  }
}
