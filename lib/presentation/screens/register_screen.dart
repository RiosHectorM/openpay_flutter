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
        padding: EdgeInsets.symmetric(horizontal: 10),
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
  String last_name = '';
  String email = '';
  String phone_number = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Nombre de usuario',
            onChanged: (value) => name = value,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              if (value.length < 6) return 'Más de 6 letras';
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Apellido de usuario',
            onChanged: (value) => last_name = value,
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
            onChanged: (value) => phone_number = value,
          ),
          const SizedBox(height: 20),
          FilledButton.tonalIcon(
            onPressed: () async {
              final isValid = _formKey.currentState!.validate();
              if (!isValid) return;

              final userData = {
                'name': name,
                'last_name': last_name,
                'email': email,
                'phone_number': phone_number,
              };

              try {
                // Reemplaza 'TU_API_KEY_AQUI' con tu clave de API real
                await widget.userRepository.createUser(userData);
                print('Usuario creado exitosamente');
              } catch (error) {
                print('Error al crear el usuario: $error');
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
