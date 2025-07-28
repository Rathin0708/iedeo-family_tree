import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../core/utils/validators.dart';
import '../../../data/models/auth_request.dart';
import '../auth/auth_bloc.dart';
import '../auth/auth_event.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc authBloc;

  LoginBloc({required this.authBloc}) : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
        status: FormzSubmissionStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
        status: FormzSubmissionStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      
      final request = LoginRequest(
        email: state.email.value,
        password: state.password.value,
      );
      
      authBloc.add(AuthLoginRequested(request));
    }
  }
}
