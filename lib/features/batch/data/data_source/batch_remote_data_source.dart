import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../domain/entity/batch_entity.dart';
import '../dto/get_all_batch_dto.dart';
import '../model/batch_api_model.dart';

final batchRemoteDataSourceProvider = Provider(
  ((ref) => BatchRemoteDataSource(
        dio: ref.read(httpServiceProvider),
        batchApiModel: ref.read(batchApiModelProvider),
      )),
);

class BatchRemoteDataSource {
  final Dio dio;
  final BatchApiModel batchApiModel;

  BatchRemoteDataSource({
    required this.dio,
    required this.batchApiModel,
  });

  Future<Either<Failure, bool>> addBatch(BatchEntity batch) async {
    try {
      var response = await dio.post(
        ApiEndpoints.createBatch,
        data: {
          "batchName": batch.batchName,
        },
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ), // Failure
        );
      } // Left
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ), // Failure
      ); // Left
    }
  }

  Future<Either<Failure, List<BatchEntity>>> getAllBatches() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllBatch);
      if (response.statusCode == 200) {
        GetAllBatchDTO batchAddDTO = GetAllBatchDTO.fromJson(response.data);
        return Right(batchApiModel.toEntityList(batchAddDTO.data));
      } else {
        return Left(Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(
        Failure(error: e.error.toString()),
      );
    }
  }
}
