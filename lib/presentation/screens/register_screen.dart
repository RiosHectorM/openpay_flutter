import 'package:flutter/material.dart';
import 'package:openpay_flutter/presentation/screens/widgets/widgets.dart';
import 'package:openpay_flutter/repositories/openpay_crud.dart';
import 'package:openpay_flutter/datasources/openpay_api.dart';
import 'package:dio/dio.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository userRepository = UserRepositoryImpl(OpenPayApi(Dio()));

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Usuario'),
      ),
      body: _RegisterView(userRepository: userRepository),
    );
  }
}

class _RegisterView extends StatelessWidget {
  final UserRepository userRepository;

  const _RegisterView({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _RegisterForm(userRepository: userRepository),
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

  const _RegisterForm({Key? key, required this.userRepository}) : super(key: key);

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 8),
          CustomTextFormField(
            label: 'Nombre de usuario',
            onChanged: (value) => name = value,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              if (value.length < 4) return 'Más de 4 letras';
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Apellido de usuario',
            onChanged: (value) => lastName = value,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Correo electrónico',
            onChanged: (value) => email = value,
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
            onChanged: (value) => phoneNumber = value,
          ),
          const SizedBox(height: 20),
          FilledButton.tonalIcon(
          onPressed: () async {
            final isValid = _formKey.currentState!.validate();
            if (!isValid) return;

            final userData = {
              'name': name,
              'last_name': lastName,
              'email': email,
              'phone_number': phoneNumber,
            };

            try {
              await widget.userRepository.createUser(userData);
              // Mostrar SnackBar de éxito
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Usuario creado exitosamente'),
                  backgroundColor: Colors.green,
                ),
              );

            } catch (error) {
              // Mostrar SnackBar de error
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error al crear el usuario: $error'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          icon: const Icon(Icons.save),
          label: const Text('Crear usuario'),
        ),

        ],
      ),
    );
  }
}
