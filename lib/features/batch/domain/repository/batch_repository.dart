import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/core/failure/failure.dart';
import 'package:hive_and_api_for_class/features/batch/domain/entity/batch_entity.dart';

import '../../data/repository/batch_remote_repo_impl.dart';

final batchRepositoryProvider = Provider<IBatchRepository>((ref) {
  // Return Local repository implementation
  // For internet connectivity we will check later
  // final internet = ref.watch(connectivityStatusProvider);

  // if (ConnectivityStatus.isConnected == internet) {
  //   return ref.read(batchRemoteRepoProvider);
  // } else {
  //   return ref.read(batchLocalRepoProvider);
  // }
  return ref.read(batchRemoteRepoProvider);
});

abstract class IBatchRepository {
  Future<Either<Failure, List<BatchEntity>>> getAllBatches();
  Future<Either<Failure, bool>> addBatch(BatchEntity batch);
}
