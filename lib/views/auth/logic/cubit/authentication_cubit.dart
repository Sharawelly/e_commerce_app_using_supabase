import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_using_supabase/views/auth/logic/models/user_data_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  SupabaseClient client = Supabase.instance.client;

  GoogleSignInAccount? googleUser;

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

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(SignUpLoading());
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
      );
      await addUserData(name: name, email: email);
      emit(SignUpSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(SignUpFailure(errorMessage: e.message));
    } catch (e) {
      log(e.toString());
      emit(SignUpFailure(errorMessage: e.toString()));
    }
  }

  Future<AuthResponse> googleSignIn() async {
    emit(GoogleSignInLoading());
    const webClientId =
        '311949788559-va26vlc45an5tke4pajmo94kju13p2cs.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      // clientId: iosClientId,
      serverClientId: webClientId,
    );
    googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return AuthResponse();
    }
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      emit(GoogleSignInFailure());
      return AuthResponse();
    }

    AuthResponse response = await client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
    await addUserData(name: googleUser!.displayName!, email: googleUser!.email);
    await getUserData();

    emit(GoogleSignInSuccess());
    return response;
  }

  Future<void> signOut() async {
    emit(LogoutLoading());
    try {
      await client.auth.signOut();
      emit(LogoutSuccess());
    } catch (e) {
      log(e.toString());
      emit(LogoutFailure());
    }
  }

  Future<void> resetPassword({required String email}) async {
    emit(PasswordResetLoading());
    try {
      await client.auth.resetPasswordForEmail(email);
      emit(PasswordResetSuccess());
    } catch (e) {
      log(e.toString());
      emit(PasswordResetFailure());
    }
  }

  // insert  => add only
  // upsert => add or update
  Future<void> addUserData({
    required String name,
    required String email,
  }) async {
    emit(UserDataAddedLoading());
    try {
      await client.from('users').upsert({
        "user_id": client.auth.currentUser!.id,
        "name": name,
        "email": email,
      });
      emit(UserDataAddedSuccess());
    } catch (e) {
      log(e.toString());
      emit(UserDataAddedFailure());
    }
  }

  UserDataModel? userDataModel;
  Future<void> getUserData() async {
    emit(GetUserDataLoading());
    try {
      final List<Map<String, dynamic>> data = await client
          .from('users')
          .select()
          .eq("user_id", client.auth.currentUser!.id);
      userDataModel = UserDataModel(
        email: data[0]["email"],
        name: data[0]["name"],
        userId: data[0]["user_id"],
      );
      emit(GetUserDataSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetUserDataFailure());
    }
  }
}
