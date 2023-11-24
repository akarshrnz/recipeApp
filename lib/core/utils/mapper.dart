abstract class Mapper<M,E>{
   M toModel(E e);
    E toEntity(M e);
}