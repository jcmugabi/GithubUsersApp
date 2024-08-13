import 'package:GithubUsersApp/domain/repositories/user_repository.dart';
import 'package:GithubUsersApp/domain/usecases/get_users_usecase.dart';
import 'data/repositories/user_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'data/remote/api_data.dart';
import 'domain/usecases/get_user_details_usecase.dart';

final injector = GetIt.instance;

void setup(){
  ///ApiData injected in UserRepositoryImpl
  injector.registerFactory<ApiData>(()=>ApiData());

  ///UserRepositoryImpl as the implementation of UserRepository injected in Usecases
  injector.registerFactory<UserRepository>(() => UserRepositoryImpl(),
  );

  ///GetUsersUseCase Injected in USerListProvider
  injector.registerFactory<GetUsersUseCase>(
        () => GetUsersUseCase(),
  );

  ///GetUserDetailsUseCase Injected in UserDetailsProviders
  injector.registerFactory<GetUserDetailsUseCase>(
        () => GetUserDetailsUseCase(),
  );
}