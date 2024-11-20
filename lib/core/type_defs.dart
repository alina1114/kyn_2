import 'package:fpdart/fpdart.dart';
import 'package:kyn_2/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
