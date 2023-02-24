import 'package:cloud_firestore/cloud_firestore.dart';

class OcurrencyRepository{

final fireRef = FirebaseFirestore.instance.collection('ocurrency');


// buscar todas os canais
/*Future<GenericsResult<OcurrencyModel>>getAllOcurrency() async {
      final QuerySnapshot snapOcurrency =
        await fireRef.get();
    
    if (snapOcurrency.docs.isNotEmpty){
        List<OcurrencyModel> data = snapOcurrency.docs.map((d) => OcurrencyModel.fromDocument(d)).toList();
        return GenericsResult<OcurrencyModel>.success(data);
    }else{
        return GenericsResult.error('Não existem canais cadastrados!');
    }
}*/

}