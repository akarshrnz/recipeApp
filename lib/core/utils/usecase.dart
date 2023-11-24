abstract class UseCase<Type,Params>{
  Future<Type> call(Params param);

}

abstract class Params{
 

}
class NoParams extends Params{
  
}
