import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/repository/i_connectivity_repository.dart';

class ListenNetworkChangesUsecase implements UseCase {
  late ConnectivityRepository _connectivityRepository;
  ListenNetworkChangesUsecase(
      {required ConnectivityRepository connectivityRepository}) {
    _connectivityRepository = connectivityRepository;
  }

  @override
  Stream<String> call({required params}) async* {
    yield* _connectivityRepository.listenToNetworkChanges();
  }
}
