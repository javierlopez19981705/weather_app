import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/utils/custom_text_style.dart';
import 'package:weather_app/src/utils/spaces.dart';

import '../../../utils/custom_navigation.dart';
import '../../../widgets/progress_bar_widget.dart';
import '../cubit/splash_cubit.dart';
import '../cubit/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).primaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocProvider<SplashCubit>(
          create: (context) => SplashCubit(),
          child: const _SplashView(),
        ),
      ),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.status == SplashStatus.permissionAllow) {
            CustomNavigation.navigateHome(context, state.position!);
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case SplashStatus.pending:
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  ProgressBarWidget(
                    color: Colors.white,
                  ),
                ],
              );

            case SplashStatus.servicesDisabled:
              return _servicesDisabled(context: context);

            case SplashStatus.permissionDenied:
              return _permissionDenied(context: context);

            case SplashStatus.permissionDeniedForever:
              return _permissionDeniedForever(context: context);

            case SplashStatus.permissionAllow:
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  ProgressBarWidget(
                    color: Colors.white,
                  ),
                ],
              );
          }
        },
      ),
    );
  }

  Widget _servicesDisabled({required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ProgressBarWidget(
          color: Colors.white,
        ),
        spaceHeightDouble(),
        Text(
          'Los servicios estan desactivados',
          style: styleBodyBold.copyWith(color: Colors.white),
        ),
        spaceHeight(),
        ElevatedButton(
          onPressed: () {
            context.read<SplashCubit>().requestActiveServices();
          },
          child: const Text('Activar servicios'),
        )
      ],
    );
  }

  Widget _permissionDenied({required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ProgressBarWidget(
          color: Colors.white,
        ),
        spaceHeightDouble(),
        Text(
          'Concede los permisos para acceder a la app',
          style: styleBodyBold.copyWith(color: Colors.white),
        ),
        spaceHeight(),
        ElevatedButton(
          onPressed: () {
            context.read<SplashCubit>().determinePosition();
          },
          child: const Text('Conceder permisos'),
        )
      ],
    );
  }

  Widget _permissionDeniedForever({required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        ProgressBarWidget(
          color: Colors.white,
        ),
        Text('Los permisos estan denegados para siempre'),
      ],
    );
  }
}
