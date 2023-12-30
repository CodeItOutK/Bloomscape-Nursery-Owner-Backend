import 'package:bloomscape_backend/model/models.dart';

abstract class BaseNurseryRepository{
  Future<void> addNursery(Nursery nursery);
  Future<void> editNurserySettings(Nursery nursery);
  Future<void> editNurseryOpeningHours(List<OpeningHours>openingHours);
  Future<void> editProducts(List<Product>products);
  Stream<Nursery> getNursery();
}