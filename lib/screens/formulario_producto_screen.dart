


import 'package:material_ui/material_ui.dart';
import '../models/producto.dart';
import '../database/database_helper.dart';

class FormularioProductoScreen extends StatefulWidget {

  final Producto? producto;

  const FormularioProductoScreen({
    super.key,
    this.producto,
  });

  @override
  State<FormularioProductoScreen> createState() =>
      _FormularioProductoScreenState();

}

class _FormularioProductoScreenState extends State<FormularioProductoScreen> {

  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _precioController = TextEditingController();
  final _cantidadController = TextEditingController();

  bool _guardando = false;

  bool get _esEdicion => widget.producto != null;

  @override
  void initState() {

    super.initState();

    if (_esEdicion) {

      final producto = widget.producto!;

      _nombreController.text = producto.nombre;
      _descripcionController.text = producto.descripcion ?? '';
      _precioController.text = producto.precio.toString();
      _cantidadController.text = producto.cantidad.toString();

    }

  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _precioController.dispose();
    _cantidadController.dispose();

    super.dispose();
  }

  Future<void> _guardarProducto() async {

    if (_guardando || !_formKey.currentState!.validate()) { return; }

    setState(() => _guardando = true);

    final descripcion = _descripcionController.text.trim();

    final producto = Producto(

      id: widget.producto?.id,
      nombre: _nombreController.text.trim(),
      descripcion: descripcion.isEmpty ? null : descripcion,
      precio: double.parse(_precioController.text.trim()),
      cantidad: int.parse(_cantidadController.text.trim()),

    );

    try {

      if (_esEdicion) {
        await DatabaseHelper.instance.actualizarProducto(producto);
      } else {
        await DatabaseHelper.instance.insertarProducto(producto);
      }

      if (!mounted) return;

      Navigator.pop(context, true);

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al guardar el producto'),
        ),
      );

    } finally {

      if (mounted) {
        setState(() => _guardando = false);
      }

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(
          _esEdicion ? 'Editar producto' : 'Nuevo producto',
        ),

      ),
      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(16),
          child: Form(

            key: _formKey,
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(

                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingrese el nombre del producto';
                    }
                    return null;
                  },

                ),
                const SizedBox(height: 16),
                TextFormField(

                  controller: _descripcionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    
                    labelText: 'Descripción (opcional)',
                    border: OutlineInputBorder(),

                  ),

                ),
                const SizedBox(height: 16),
                TextFormField(

                  controller: _precioController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(

                    labelText: 'Precio',
                    prefixText: '\$ ',
                    border: OutlineInputBorder(),

                  ),
                  validator: (value) {

                    final precio = double.tryParse(
                      value?.trim() ?? '',
                    );

                    if (precio == null || !precio.isFinite) {
                      return 'Ingrese un precio válido';
                    }

                    if (precio < 0) {
                      return 'El precio no puede ser negativo';
                    }

                    return null;

                  },

                ),
                const SizedBox(height: 16),
                TextFormField(

                  controller: _cantidadController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(

                    labelText: 'Cantidad',
                    border: OutlineInputBorder(),

                  ),
                  validator: (value) {

                    final cantidad = int.tryParse(
                      value?.trim() ?? '',
                    );

                    if (cantidad == null) {
                      return 'Ingrese una cantidad entera válida';
                    }

                    if (cantidad < 0) {
                      return 'La cantidad no puede ser negativa';
                    }

                    return null;
                    
                  },

                ),
                const SizedBox(height: 24),
                FilledButton(

                  onPressed: _guardando ? null : _guardarProducto,
                  child: _guardando
                      ? const CircularProgressIndicator()
                      : Text(
                          _esEdicion
                              ? 'Guardar cambios'
                              : 'Agregar producto',
                        ),
                ),

              ],
            ),

          ),

        ),

      ),

    );

  }

}
