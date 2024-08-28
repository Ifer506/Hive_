import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/core/failure/failure.dart';
import 'package:hive_and_api_for_class/features/course/data/repository/course_remote_repo_impl.dart';
import 'package:hive_and_api_for_class/features/course/domain/entity/course_entity.dart';

final courseRepositoryProvider = Provider<ICourseRepository>((ref) {
  // return ref.read(courseRemoteRepoProvider);
  // final internet = ref.watch(connectivityStatusProvider);

  // if (ConnectivityStatus.isConnected == internet) {
  //   return ref.read(courseRemoteRepoProvider);
  // } else {
  //   return ref.read(courseLocalRepoProvider);
  // }
  return ref.read(courseRemoteRepoProvider);
}
    // LocalCourseRepositoryImpl(
    //   courseLocalDataSource: ref.read(courseLocalDataSourceProvider),
    // ),
    );

abstract class ICourseRepository {
  Future<Either<Failure, bool>> addCourse(CourseEntity course);
  Future<Either<Failure, List<CourseEntity>>> getAllCourses();
}
