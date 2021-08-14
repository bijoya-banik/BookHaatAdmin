class AppState {
 

    int totalProduct;
    int totalOrder;
    int totalCategory;

    ////////////category
    List categoryList=[];
    bool categoryLoading= true;

    ////////////product
    List productList=[];
    bool productLoading= true;

    ////////////available product
    List availableProductList=[];
    bool availableProductLoading= true;

    ////////////emptyStock product
    List emptyStockProductList=[];
    bool emptyStockProductLoading= true;

    ////////////offer product
    List offerProductList=[];
    bool offerProductLoading= true;
 
  ////////////////  search List //////////
   List searchProductList=[];

   //////////// order
    List orderList=[];
    bool orderLoading= true;
   //////////// order
    List pendingOrderList=[];
    bool pendingOrderLoading= true;
   //////////// order
    List deliveredOrderList=[];
    bool deliveredOrderLoading= true;
   //////////// order
    List processingOrderList=[];
    bool processingOrderLoading= true;
   //////////// user
    List userList=[];
    bool userLoading= true;
   //////////// order
    List pdfBookList=[];
    bool pdfBookLoading= true;
   //////////// order
    List feedbackList=[];
    bool feedbackLoading= true;

  AppState(
      {
       this.totalProduct,
       this.totalOrder,
       this.categoryList, 
       this.categoryLoading,
       this.productList, 
       this.productLoading,
       this.totalCategory,
       this.availableProductList, 
       this.availableProductLoading,
       this.emptyStockProductList, 
       this.emptyStockProductLoading,
       this.offerProductList, 
       this.offerProductLoading,
       this.searchProductList,
       this.orderList,
       this.orderLoading,
       this.deliveredOrderList,
       this.deliveredOrderLoading, 
       this.pendingOrderList, 
       this.pendingOrderLoading, 
       this.processingOrderList, 
       this.processingOrderLoading,
       this.userList,
       this.userLoading, 
       this.pdfBookList, 
       this.pdfBookLoading,
       this.feedbackList, 
       this.feedbackLoading
      });

  AppState copywith(
      {totalProduct,totalOrder,totalCategory,categoryList,categoryLoading,productList,productLoading,
      availableProductList,availableProductLoading, emptyStockProductList,emptyStockProductLoading,
      offerProductList,offerProductLoading,searchProductList,orderList,orderLoading,
      deliveredOrderList,deliveredOrderLoading,pendingOrderList,pendingOrderLoading,
      processingOrderList,processingOrderLoading,userList,userLoading,pdfBookList,
      pdfBookLoading,feedbackList,feedbackLoading
      }) {


    return AppState(
      totalProduct: totalProduct ?? this.totalProduct,
      totalOrder: totalOrder ?? this.totalOrder,
      totalCategory: totalCategory ?? this.totalCategory,
      categoryList: categoryList ?? this.categoryList,
      categoryLoading: categoryLoading ?? this.categoryLoading,
      productList: productList ?? this.productList,
      productLoading: productLoading ?? this.productLoading,
      availableProductList: availableProductList ?? this.availableProductList,
      availableProductLoading: availableProductLoading ?? this.availableProductLoading,
      emptyStockProductList: emptyStockProductList ?? this.emptyStockProductList,
      emptyStockProductLoading: emptyStockProductLoading ?? this.emptyStockProductLoading,
      offerProductList: offerProductList ?? this.offerProductList,
      offerProductLoading: offerProductLoading ?? this.offerProductLoading,
      searchProductList: searchProductList ?? this.searchProductList,
      orderList: orderList ?? this.orderList,
      orderLoading: orderLoading ?? this.orderLoading,
      deliveredOrderList: deliveredOrderList ?? this.deliveredOrderList,
      deliveredOrderLoading: deliveredOrderLoading ?? this.deliveredOrderLoading,
      pendingOrderList: pendingOrderList ?? this.pendingOrderList,
      pendingOrderLoading: pendingOrderLoading ?? this.pendingOrderLoading,
      processingOrderList: processingOrderList ?? this.processingOrderList,
      processingOrderLoading: processingOrderLoading ?? this.processingOrderLoading,
      userList: userList ?? this.userList,
      userLoading: userLoading ?? this.userLoading,
      pdfBookList: pdfBookList ?? this.pdfBookList,
      pdfBookLoading: pdfBookLoading ?? this.pdfBookLoading,   
      feedbackList: feedbackList ?? this.feedbackList,
      feedbackLoading: feedbackLoading ?? this.feedbackLoading,
     
    );
  }
}
