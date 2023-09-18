import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/repository/i_connectivity_repository.dart';

class MobileNetworkUsecase implements UseCase {
  late ConnectivityRepository _connectivityRepository;
  MobileNetworkUsecase({required ConnectivityRepository connectivityRepository}) {
    _connectivityRepository = connectivityRepository;
  }

  @override
  Future call({required params}) async {
    return await _connectivityRepository.isMobileNetworkConnected();
  }
}
