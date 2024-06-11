//Classe de representação de dois tipos de retorno: esquerdo (L) e direito (R). Valores nulos não podem ser retornados
sealed class Either<L, R> {}

class Left<L, R> extends Either<L, R> {
  final L value;

  Left(this.value);
}

class Right<L, R> extends Either<L, R> {
  final R value;

  Right(this.value);
}
