import 'package:flutter/material.dart';
import 'package:openpay_flutter/presentation/screens/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Usuario'),
      ),
      body: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [_RegisterForm(), SizedBox(height: 20)],
        ),
      ),
    ));
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

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
              // validator: (value) {
              //   if (value == null || value.isEmpty) return 'Campo requerido';
              //   if (value.trim().isEmpty) return 'Campo requerido';
              //   if (value.length < 6) return 'Más de 6 letras';
              //   return null;
              // },
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
              // validator: (value) {
              //   if (value == null || value.isEmpty) return 'Campo requerido';
              //   if (value.trim().isEmpty) return 'Campo requerido';
              //   if (value.length < 6) return 'Más de 6 letras';
              //   return null;
              // },
            ),

            const SizedBox(height: 20),
            FilledButton.tonalIcon(
              onPressed: () {
                final isValid = _formKey.currentState!.validate();
                if (!isValid) return;

                print('$name, $last_name,$email, $phone_number');
              },
              icon: const Icon(Icons.save),
              label: const Text('Crear usuario'),
            ),
          ],
        ));
  }
}
