import 'package:fithub_v1/providers/global_config_provider.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          color: Colors.black,
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double screenHeight = constraints.maxHeight;
                double screenWidth = constraints.maxWidth;

                double desiredHeight = 932;
                double desiredWidth = 430;

                // Fijar las dimensiones deseadas si la pantalla es más grande
                // Limitar a las dimensiones de la pantalla si es más pequeña
                double height =
                    screenHeight > desiredHeight ? desiredHeight : screenHeight;
                double width =
                    screenWidth > desiredWidth ? desiredWidth : screenWidth;

                GlobalConfigProvider.setMaxHeight(height);
                GlobalConfigProvider.setMaxWidth(width);

                return SizedBox(
                  height: height,
                  width: width,
                  child: Container(color: Colors.amber, child: child),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
