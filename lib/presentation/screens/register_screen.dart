import 'package:flutter/material.dart';
import 'package:openpay_flutter/presentation/screens/widgets/widgets.dart';
import 'package:openpay_flutter/repositories/openpay_crud.dart';
import 'package:openpay_flutter/datasources/openpay_api.dart';
import 'package:dio/dio.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository userRepository = UserRepositoryImpl(OpenPayApi(Dio()));
  final bool isEditing;
  final Map<String, dynamic>? client;

  RegisterScreen({Key? key, required this.isEditing, this.client})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Cliente' : 'Nuevo Cliente'),
      ),
      body: _RegisterView(
          userRepository: userRepository, isEditing: isEditing, client: client),
    );
  }
}

class _RegisterView extends StatelessWidget {
  final UserRepository userRepository;
  final bool isEditing;
  final Map<String, dynamic>? client;

  const _RegisterView({
    Key? key,
    required this.userRepository,
    required this.isEditing,
    required this.client,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _RegisterForm(
                  userRepository: userRepository,
                  isEditing: isEditing,
                  client: client),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  final UserRepository userRepository;
  final bool isEditing;
  final Map<String, dynamic>? client;

  const _RegisterForm({
    Key? key,
    required this.userRepository,
    required this.isEditing,
    required this.client,
  }) : super(key: key);

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();

    final clientData = widget.client;

    _nameController = TextEditingController(text: clientData?['name'] ?? '');
    _lastNameController =
        TextEditingController(text: clientData?['last_name'] ?? '');
    _emailController = TextEditingController(text: clientData?['email'] ?? '');
    _phoneNumberController =
        TextEditingController(text: clientData?['phone_number'] ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 8),
          CustomTextFormField(
            label: 'Nombre de Cliente',
            controller: _nameController, 
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              if (value.length < 4) return 'Mas de 4 letras';
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Apellido de Cliente',
            controller: _lastNameController,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Correo electronico',
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              final emailRegExp = RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              );

              if (!emailRegExp.hasMatch(value)) {
                return 'No tiene formato de correo';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Telefono',
            controller: _phoneNumberController,
          ),
          const SizedBox(height: 20),
          FilledButton.tonalIcon(
            onPressed: () async {
              final isValid = _formKey.currentState!.validate();
              if (!isValid) return;

              final userData = {
                'name': _nameController.text,
                'last_name': _lastNameController.text,
                'email': _emailController.text,
                'phone_number': _phoneNumberController.text,
              };

              try {
                if (widget.isEditing) {
                  // Logica para editar el cliente existente
                  try {
                    await widget.userRepository
                        .editUser(widget.client!['id'], userData);
                    // Mostrar SnackBar de exito
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cliente Editado exitosamente'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } catch (error) {
                    // Mostrar SnackBar de error
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error al Editar el Cliente: $error'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } else {
                  await widget.userRepository.createUser(userData);
                }
                // Vuelve a la pantalla anterior
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              } catch (error) {
                // Mostrar SnackBar de error
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: $error'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            icon: const Icon(Icons.save),
            label: Text(widget.isEditing ? 'Guardar cambios' : 'Crear Cliente'),
          ),
        ],
      ),
    );
  }
}
