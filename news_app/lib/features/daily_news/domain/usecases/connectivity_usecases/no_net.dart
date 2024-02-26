import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/repository/i_connectivity_repository.dart';

class NoNetworkUsecase implements UseCase {
  late ConnectivityRepository _connectivityRepository;
  NoNetworkUsecase({required ConnectivityRepository connectivityRepository}) {
    _connectivityRepository = connectivityRepository;
  }

  @override
  Future call({void params}) async {
    return await _connectivityRepository.isNotConnectedToAnyNetwork();
  }
}
