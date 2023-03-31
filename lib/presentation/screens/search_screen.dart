import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_apple/data/models/city_model.dart';
import 'package:weather_apple/presentation/bloc/search/search_cubit.dart';
import 'package:weather_apple/presentation/widgets/city_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              context.read<SearchCubit>().dispose();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter your city',
            ),
            onSubmitted: (input) {
              context.read<SearchCubit>().addCity(input);
            },
          ),
        ),
        body: BlocBuilder<SearchCubit, SearchCubitState>(
          builder: (BuildContext context, SearchCubitState state) {
            if (state is SearchCubitLoaded) {
              return searchList(state.cityModel, state.enabledModels);
            }
            if (state is SearchCubitInit) {
              context.read<SearchCubit>().loadSearchScreen();
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget searchList(List<CityModel> cityModel, List<CityModel> enabledModels) {
    return ListView.builder(
      itemCount: cityModel.length,
      itemBuilder: (context, index) {
        for (int i = 0; i < enabledModels.length; ++i) {
          if (cityModel[index] == enabledModels[i]) {
            return CityWidget(
              cityModel: cityModel[index],
              enabled: true,
            );
          }
        }
        return CityWidget(
          cityModel: cityModel[index],
          enabled: false,
        );
      },
    );
  }
}
