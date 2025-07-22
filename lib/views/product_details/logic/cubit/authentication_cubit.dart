import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  SupabaseClient client = Supabase.instance.client;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      emit(LoginSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(LoginFailure(errorMessage: e.message));
    } catch (e) {
      log(e.toString());
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }
}
