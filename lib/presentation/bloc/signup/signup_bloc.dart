import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../core/utils/validators.dart';
import '../../../data/models/auth_request.dart';
import '../auth/auth_bloc.dart';
import '../auth/auth_event.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthBloc authBloc;

  SignupBloc({required this.authBloc}) : super(const SignupState()) {
    on<SignupFullNameChanged>(_onFullNameChanged);
    on<SignupEmailChanged>(_onEmailChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignupSubmitted>(_onSubmitted);
  }

  void _onFullNameChanged(
    SignupFullNameChanged event,
    Emitter<SignupState> emit,
  ) {
    final fullName = FullName.dirty(event.fullName);
    emit(
      state.copyWith(
        fullName: fullName,
        isValid: Formz.validate([
          fullName,
          state.email,
          state.password,
          state.confirmPassword,
        ]),
        status: FormzSubmissionStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void _onEmailChanged(
    SignupEmailChanged event,
    Emitter<SignupState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          state.fullName,
          email,
          state.password,
          state.confirmPassword,
        ]),
        status: FormzSubmissionStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void _onPasswordChanged(
    SignupPasswordChanged event,
    Emitter<SignupState> emit,
  ) {
    final password = Password.dirty(event.password);
    final confirmPassword = ConfirmPassword.dirty(
      password: password.value,
      value: state.confirmPassword.value,
    );
    
    emit(
      state.copyWith(
        password: password,
        confirmPassword: confirmPassword,
        isValid: Formz.validate([
          state.fullName,
          state.email,
          password,
          confirmPassword,
        ]),
        status: FormzSubmissionStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void _onConfirmPasswordChanged(
    SignupConfirmPasswordChanged event,
    Emitter<SignupState> emit,
  ) {
    final confirmPassword = ConfirmPassword.dirty(
      password: state.password.value,
      value: event.confirmPassword,
    );
    
    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        isValid: Formz.validate([
          state.fullName,
          state.email,
          state.password,
          confirmPassword,
        ]),
        status: FormzSubmissionStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void _onSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      
      final request = SignupRequest(
        fullName: state.fullName.value,
        email: state.email.value,
        password: state.password.value,
      );
      
      authBloc.add(AuthSignupRequested(request));
    }
  }
}
