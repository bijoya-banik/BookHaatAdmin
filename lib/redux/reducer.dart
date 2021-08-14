


import 'package:Easy_shopping_admin/redux/state.dart';

import 'action.dart';

AppState reducer(AppState state, dynamic action){

  if(action is TotalProduct){
    return state.copywith(
      totalProduct: action.totalProduct 
    );
  } 
  if(action is TotalCategory){
    return state.copywith(
      totalCategory: action.totalCategory  
    );
  } 
  if(action is TotalOrder){
    return state.copywith(
      totalOrder: action.totalOrder  
    );
  } 


  if(action is CategoryListAction){
    return state.copywith(
      categoryList: action.categoryList  
    );
  } 
  if(action is CategoryLoadingAction){
    return state.copywith(
      categoryLoading: action.categoryLoading  
    );
  } 


  if(action is ProductLoadingAction){
    return state.copywith(
      productLoading: action.productLoading  
    );
  } 
  if(action is ProductListAction){
    return state.copywith(
      productList: action.productList  
    );
  } 


  if(action is AvailableProductLoadingAction){
    return state.copywith(
      availableProductLoading: action.availableProductLoading  
    );
  }
   
  if(action is AvailableProductListAction){
    return state.copywith(
      availableProductList: action.availableProductList  
    );
  }

  if(action is EmptyStockProductLoadingAction){
    return state.copywith(
      emptyStockProductLoading: action.emptyStockProductLoading  
    );
  }

  if(action is EmptyStockProductListAction){
    return state.copywith(
      emptyStockProductList: action.emptyStockProductList  
    );
  } 
  if(action is OfferProductLoadingAction){
    return state.copywith(
      offerProductLoading: action.offerProductLoading  
    );
  }

  if(action is OfferProductListAction){
    return state.copywith(
      offerProductList: action.offerProductList  
    );
  } 
  if(action is SearchProductListAction){
    return state.copywith(
      searchProductList: action.searchProductList  
    );
  }

   if(action is OrderListAction){
    return state.copywith(
      orderList: action.orderList  
    );
  } 
  if(action is OrderLoadingAction){
    return state.copywith(
      orderLoading: action.orderLoading  
    );
  }
   if(action is PendingOrderListAction){
    return state.copywith(
      pendingOrderList: action.orderList  
    );
  } 
  if(action is PendingOrderLoadingAction){
    return state.copywith(
      pendingOrderLoading: action.orderLoading  
    );
  }
   if(action is DeliveredOrderListAction){
    return state.copywith(
      deliveredOrderList: action.orderList  
    );
  } 
  if(action is DeliveredOrderLoadingAction){
    return state.copywith(
      deliveredOrderLoading: action.orderLoading  
    );
  }
   if(action is ProcessingOrderListAction){
    return state.copywith(
      processingOrderList: action.orderList  
    );
  } 
  if(action is ProcessingOrderLoadingAction){
    return state.copywith(
      processingOrderLoading: action.orderLoading  
    );
  }
   if(action is UserListAction){
    return state.copywith(
      userList: action.userList  
    );
  } 
  if(action is UserLoadingAction){
    return state.copywith(
      userLoading: action.userLoading  
    );
  }
   if(action is PdfBookListAction){
    return state.copywith(
      pdfBookList: action.pdfBookList  
    );
  } 
  if(action is PdfBookLoadingAction){
    return state.copywith(
      pdfBookLoading: action.pdfBookLoading  
    );
  }
   if(action is FeedbackListAction){
    return state.copywith(
      feedbackList: action.feedbackList  
    );
  } 
  if(action is FeedbackLoadingAction){
    return state.copywith(
      feedbackLoading: action.feedbackLoading  
    );
  }
    return state;
}