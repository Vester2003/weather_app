import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_apple/data/models/models.dart';
import 'package:weather_apple/presentation/bloc/main/main_cubit.dart';
import 'package:weather_apple/presentation/widgets/weather_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<MainCubit, MainCubitState>(
          builder: (BuildContext context, MainCubitState state) {
            if (state is MainCubitLoaded) {
              return PageView.builder(
                itemCount: state.pageModel.length,
                controller: pageController,
                itemBuilder: (BuildContext context, int index) {
                  return weatherBox(
                      state.pageModel[index].weatherModel,
                      state.pageModel[index].hourlyWeatherModel,
                      state.pageModel[index].weeklyWeatherModel,
                      state.pageModel[index].name);
                },
              );
            }
            if (state is MainCubitInit) {
              context.read<MainCubit>().loadHomeScreen();
            }
            if (state is MainCubitError) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is MainCubitLoading) {
              return const Center(
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Container();
          },
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 40,
        color: Colors.black26,
        buttonBackgroundColor: Colors.blueGrey,
        backgroundColor: Colors.black26,
        onTap: (index) {
          Navigator.pushNamed(context, '/search')
              .then((value) => context.read<MainCubit>().loadHomeScreen());
        },
        items: const [
          Icon(Icons.add, size: 30),
        ],
      ),
    );
  }

  Widget weatherBox(
      WeatherModel weatherModel,
      HourlyWeatherModel hourWeatherModel,
      WeeklyWeatherModel weeklyWeatherModel,
      String cityName) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage('assets/images/background.jpg')),
      ),
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 50)),
          Text(
            cityName,
            style: const TextStyle(fontSize: 35, color: Colors.white),
          ),
          Text(
            '${weatherModel.temp.round()}°C',
            style: const TextStyle(fontSize: 35, color: Colors.white),
          ),
          Text(
            weatherModel.description,
            style: const TextStyle(fontSize: 35, color: Colors.white),
          ),
          WeeklyWeatherWidget(
            weeklyWeatherModel: weeklyWeatherModel,
          ),
          HourlyWeather(
            hourWeatherModel: hourWeatherModel,
          ),
        ],
      ),
    );
  }
}
