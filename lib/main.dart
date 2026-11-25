

import 'package:material_ui/material_ui.dart';
import 'screens/lista_productos_screen.dart';

void main() {
  runApp(const InventarioApp());
}

class InventarioApp extends StatelessWidget {

  const InventarioApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Inventario',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
        
      ),
      home: const ListaProductosScreen(),

    );

  }

}