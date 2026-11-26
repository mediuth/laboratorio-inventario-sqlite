


import 'package:material_ui/material_ui.dart';
import '../database/database_helper.dart';
import '../models/producto.dart';
import '../widgets/producto_card.dart';
import 'formulario_producto_screen.dart';

class ListaProductosScreen extends StatefulWidget {

  const ListaProductosScreen({super.key});

  @override
  State<ListaProductosScreen> createState() =>
      _ListaProductosScreenState();

}

class _ListaProductosScreenState extends State<ListaProductosScreen> {

  List<Producto> _productos = [];
  bool _cargando = true;
  String? _error;

  @override
  void initState() {

    super.initState();
    _cargarProductos();

  }

  Future<void> _cargarProductos() async {

    setState(() {

      _cargando = true;
      _error = null;

    });

    try {
      final productos =
          await DatabaseHelper.instance.obtenerProductos();

      if (!mounted) return;

      setState(() {

        _productos = productos;
        _cargando = false;

      });
    } catch (e) {

      if (!mounted) return;

      setState(() {
        _error = 'Error al cargar los productos';
        _cargando = false;
      });

    }

  }

  Future<void> _abrirFormulario({Producto? producto}) async {

    final resultado = await Navigator.push<bool>(

      context,
      MaterialPageRoute(
        builder: (context) =>
            FormularioProductoScreen(producto: producto),
      ),

    );

    if (!mounted) return;

    if (resultado == true) {

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(

            producto == null
                ? 'Producto guardado'
                : 'Producto actualizado',
          ),

        ),

      );

      await _cargarProductos();

    }

  }

  Future<void> _confirmarEliminacion(Producto producto) async {

    final confirmar = await showDialog<bool>(

      context: context,
      builder: (context) {

        return AlertDialog(

          title: const Text('Eliminar producto'),
          content: Text(
            '¿Está seguro de eliminar "${producto.nombre}"?',
          ),
          actions: [
            TextButton(

              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),

            ),
            TextButton(

              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ),

            ),
          ],

        );

      },

    );

    if (!mounted || confirmar != true) return;

    try {

      await DatabaseHelper.instance.eliminarProducto(
        producto.id!,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Producto eliminado'),
        ),
      );

      await _cargarProductos();

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text('Error al eliminar el producto'),
        ),

      );

    }

  }

  Widget _construirContenido() {

    if (_cargando) {

      return const Center(
        child: CircularProgressIndicator(),
      );

    }

    if (_error != null) {

      return Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64),
            const SizedBox(height: 16),
            Text(_error!),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _cargarProductos,
              child: const Text('Reintentar'),
            ),
          ],

        ),

      );

    }

    if (_productos.isEmpty) {

      return const Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(

              Icons.inventory_2_outlined,
              size: 80,
              color: Colors.grey,

            ),
            SizedBox(height: 16),
            Text(

              'No hay productos registrados',
              style: TextStyle(fontSize: 18),

            ),
            SizedBox(height: 8),
            Text('Presione + para agregar un producto'),
          ],

        ),

      );

    }

    return RefreshIndicator(

      onRefresh: _cargarProductos,
      child: ListView.builder(

        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _productos.length,
        itemBuilder: (context, index) {

          final producto = _productos[index];

          return ProductoCard(

            producto: producto,
            onEditar: () =>
                _abrirFormulario(producto: producto),
            onEliminar: () =>
                _confirmarEliminacion(producto),

          );

        },

      ),

    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text('Inventario'),
        centerTitle: true,

      ),
      body: _construirContenido(),
      floatingActionButton: FloatingActionButton(

        onPressed: () => _abrirFormulario(),
        tooltip: 'Agregar producto',
        child: const Icon(Icons.add),
        
      ),

    );

  }

}
