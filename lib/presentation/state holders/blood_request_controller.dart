import 'package:blood_fighter/data/model/request_model.dart';
import 'package:blood_fighter/data/repository/blood_request_repository.dart';
import 'package:blood_fighter/presentation/UI/screens/home_screen.dart';
import 'package:get/get.dart';

class BloodRequestController extends GetxController{
  bool _createRequestInProgress = false;
  bool get  createRequestInProgress => _createRequestInProgress;
  final _requestRepository = Get.put(BloodRequestRepository());
  Future<void> createRequest(RequestModel requestModel) async {

    _createRequestInProgress= true;
    update();
    await _requestRepository.createRequest(requestModel);
    _createRequestInProgress = false;
    update();
    Get.to(()=> HomeScreen());
  }

  Future<List<RequestModel>> getAllRequest() async {
    return await _requestRepository.allBloodRequestDetails();

  }
}