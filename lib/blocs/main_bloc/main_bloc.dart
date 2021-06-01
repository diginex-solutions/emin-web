import 'package:business/bloc/auth/auth_bloc.dart';
import 'package:business/bloc/auth/auth_state.dart';
import 'package:business/bloc/auth/reset_password/reset_psw_bloc.dart';
import 'package:business/bloc/auth/reset_password/reset_psw_state.dart';
import 'package:business/bloc/connections/connections_bloc.dart';
import 'package:business/bloc/connections/connections_state.dart';
import 'package:business/bloc/document/document_bloc.dart';
import 'package:business/bloc/document/document_state.dart';
import 'package:business/bloc/survey/survey_bloc.dart';
import 'package:business/bloc/survey/survey_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc {
  static List<BlocProvider> allBlocs() {
    return [
      BlocProvider<AuthBloc>(
        create: (BuildContext context) => AuthBloc(AuthenInitial()),
      ),
      BlocProvider<SurveyBloc>(
        create: (BuildContext context) => SurveyBloc(SurveyLoadingState()),
      ),
      BlocProvider<ConnectionsBloc>(
        create: (BuildContext context) => ConnectionsBloc(ConnectionLoading()),
      ),
      BlocProvider<DocumentBloc>(
        create: (BuildContext context) => DocumentBloc(DocumentInitial()),
      ),
      BlocProvider<ResetBloc>(
        create: (BuildContext context) => ResetBloc(ResetInitial()),
      ),
    ];
  }
}
