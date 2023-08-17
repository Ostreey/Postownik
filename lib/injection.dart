
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:postownik/aplication/core/my_http_client.dart';
import 'package:postownik/domain/repositories/facebook_repository.dart';
import 'package:postownik/data/datasources/remote_datasource.dart';
import 'package:postownik/data/repositories/repo_impl.dart';

final sl = GetIt.I;

Future<void> init() async {
  sl.registerFactory<FacebookRepository>(
          () => RepoImpl(remoteDatasource: sl()));
  sl.registerFactory<RemoteDatasource>(
          () => RemoteDatasourceImpl(client: sl()));

  sl.registerFactory(() => MyHttpClient(client: sl()));
  sl.registerFactory(() => http.Client());
}
