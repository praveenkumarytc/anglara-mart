import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleSignInState {
  final bool isLoading;
  final bool isError;

  const GoogleSignInState({required this.isLoading, required this.isError});

  GoogleSignInState copyWith({bool? isLoading, bool? isError}) {
    return GoogleSignInState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  GoogleSignInCubit() : super(GoogleSignInState(isLoading: false, isError: false));

  void signInWithGoogle() async {
    try {
      emit(state.copyWith(isLoading: true, isError: false));

      // Simulating an asynchronous operation
      await Future.delayed(Duration(seconds: 2));

      // Perform sign-in logic here

      emit(state.copyWith(isLoading: false, isError: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isError: true));
    }
  }
}

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleSignInCubit, GoogleSignInState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.isLoading
              ? null
              : () {
                  context.read<GoogleSignInCubit>().signInWithGoogle();
                },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            // Customize the button style as desired
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: state.isLoading
                ? CircularProgressIndicator()
                : Text(
                    'Sign In with Google',
                    style: TextStyle(fontSize: 16),
                  ),
          ),
        );
      },
    );
  }
}
