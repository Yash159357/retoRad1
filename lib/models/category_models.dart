

class CategoryModel{

  //These variables are those using which we will access these datas present in our Firebase
  final String categoryName;
  final String categoryImage;


  //Creating this constructor and hence as soon as this Model will be called this Constructor will be called and ask us to pass these values of 'categoryName' and 'categoryImage'
  CategoryModel(this.categoryName, this.categoryImage);

}