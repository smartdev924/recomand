enum APP_PAGE {
  splash,
  country,
  signIn,
  home,
  addProductStep1,
  changePassword,
  searchProducts,
  resetPasword,
  signUp,
  workStep1,
  workStep2,
  workStep3,
  error,
  forgotPassword,
  productDetails,
  subCategory,
  search,
  categoryView,
  productView,
  faq,
  editProductStep1,
  addProductStep2,
  addProductStep3,
  confirmOrder,
  favorites,
  myAccountSettings,
  myAccount,
  myServices,
  notifications,
  newOffer,
  updateOffer,
  conversation,
  chatView,
  chatViewDekstop,
  settings,
  subscription,
  hireStep1,
  hireStep2,
  hireStep3,
  orderAndPay,
  myJobs,
  viewService,
  verificaiton,
  browseRequests,
  buyCredits,
  buyCreditsApple,
  jobDetails,
  myJobOffers,
  myJobOfferid,
  myOffers,
  sendPhoneNumber,
  creditHistory,
  paymentMethod,
  paymentStripe,
  paymentSuccess,
  becomeSeller,
  becomeSuccess,
  userProfile,
  writeReview,
  workChatView,
  workChatViewDesktop,
  directChatView,
  directChatViewDesktop,
  directMyJobOfferID,
  directJobDetails
}

extension AppPageExtension on APP_PAGE {
  String get toPath {
    switch (this) {
      case APP_PAGE.splash:
        return "/splash-screen";
      case APP_PAGE.country:
        return "/country-screen";
      case APP_PAGE.signIn:
        return "/login";
      case APP_PAGE.home:
        return '/home';
      case APP_PAGE.error:
        return '/error';
      case APP_PAGE.subscription:
        return '/subscription';
      case APP_PAGE.sendPhoneNumber:
        return '/send-phone-number';
      case APP_PAGE.orderAndPay:
        return '/order-and-pay';

      case APP_PAGE.addProductStep1:
        return "/add-product-step1";
      case APP_PAGE.changePassword:
        return "/change-password";
      case APP_PAGE.resetPasword:
        return '/reset-password';
      case APP_PAGE.signUp:
        return '/register/:inviteCode';
      case APP_PAGE.workStep1:
        return '/work-step1';
      case APP_PAGE.workStep2:
        return '/work-step2';
      case APP_PAGE.workStep3:
        return '/work-step3';
      case APP_PAGE.hireStep1:
        return '/hire-step1';
      case APP_PAGE.hireStep2:
        return '/hire-step2';
      case APP_PAGE.hireStep3:
        return '/hire-step3';
      case APP_PAGE.forgotPassword:
        return '/forgot-password';
      case APP_PAGE.productDetails:
        return '/product-details';
      case APP_PAGE.subCategory:
        return "/sub-category";
      case APP_PAGE.search:
        return '/search';
      case APP_PAGE.categoryView:
        return '/category-view';
      case APP_PAGE.productView:
        return "/start";
      case APP_PAGE.searchProducts:
        return "/search-products";
      case APP_PAGE.faq:
        return "/faq";
      case APP_PAGE.editProductStep1:
        return '/edit-product-step1';
      case APP_PAGE.addProductStep2:
        return '/add-product-step2';
      case APP_PAGE.addProductStep3:
        return '/add-product-step3';
      case APP_PAGE.confirmOrder:
        return '/confirm-order';
      case APP_PAGE.favorites:
        return '/favorites';
      case APP_PAGE.myAccountSettings:
        return '/my-account-settings';
      case APP_PAGE.myAccount:
        return '/my-account';
      case APP_PAGE.myServices:
        return '/my-services';
      case APP_PAGE.notifications:
        return '/notifications';
      case APP_PAGE.newOffer:
        return '/new-offer';
      case APP_PAGE.updateOffer:
        return '/update-offer';
      case APP_PAGE.conversation:
        return '/conversation';
      case APP_PAGE.chatView:
        return '/chat-view';
      case APP_PAGE.chatViewDekstop:
        return '/chat-view-desktop';
      case APP_PAGE.directChatView:
        return '/direct-chat-view/:roomID';
      case APP_PAGE.directChatViewDesktop:
        return '/direct-chat-view-desktop/:roomID';
      case APP_PAGE.directMyJobOfferID:
        return '/direct-my-job-offerid/:offerID';
      case APP_PAGE.directJobDetails:
        return '/request/:requestID';
      case APP_PAGE.settings:
        return '/settings';

      case APP_PAGE.myJobs:
        return '/my-jobs';
      case APP_PAGE.myJobOffers:
        return '/my-job-offers';
      case APP_PAGE.myJobOfferid:
        return '/my-job-offerid';
      case APP_PAGE.myOffers:
        return '/my-offers';
      case APP_PAGE.jobDetails:
        return '/job-details';
      case APP_PAGE.viewService:
        return '/view-service';
      case APP_PAGE.verificaiton:
        return '/verificaiton';

      case APP_PAGE.browseRequests:
        return '/browse-requests';
      case APP_PAGE.buyCredits:
        return '/buy-credits';
      case APP_PAGE.buyCreditsApple:
        return '/buy-credits-apple';
      case APP_PAGE.creditHistory:
        return '/credit-history';
      case APP_PAGE.paymentMethod:
        return '/payment-method';
      case APP_PAGE.paymentStripe:
        return "/payment-stripe";
      case APP_PAGE.paymentSuccess:
        return "/payment-success";
      case APP_PAGE.becomeSeller:
        return "/become-seller";
      case APP_PAGE.becomeSuccess:
        return "/become-success";
      case APP_PAGE.userProfile:
        return "/user-profile";
      case APP_PAGE.writeReview:
        return '/write-review';
      case APP_PAGE.workChatView:
        return '/work-chat-view';
      case APP_PAGE.workChatViewDesktop:
        return '/work-chat-view-desktop';
      default:
        return '/home';
    }
  }

  String get toName {
    switch (this) {
      case APP_PAGE.splash:
        return "SPLASH";
      case APP_PAGE.country:
        return "COUNTRY";
      case APP_PAGE.signIn:
        return "SIGNIN";
      case APP_PAGE.home:
        return "HOME";
      case APP_PAGE.addProductStep1:
        return "ADDPRODUCTIONSTEP1";
      case APP_PAGE.changePassword:
        return "CHANGEPASSWORD";
      case APP_PAGE.searchProducts:
        return "SEARCHPRODUCTS";
      case APP_PAGE.resetPasword:
        return "RESETPASSWORD";
      case APP_PAGE.signUp:
        return "SIGNUP";
      case APP_PAGE.workStep1:
        return "WORKSTEP1";
      case APP_PAGE.workStep2:
        return "WORKSTEP2";
      case APP_PAGE.workStep3:
        return "WORKSTEP3";
      case APP_PAGE.hireStep1:
        return "HIRESTEP1";
      case APP_PAGE.hireStep2:
        return "HIRESTEP2";
      case APP_PAGE.hireStep3:
        return "HIRESTEP3";
      case APP_PAGE.error:
        return "ERROR";
      case APP_PAGE.sendPhoneNumber:
        return 'SENDPHONENUMBER';
      case APP_PAGE.forgotPassword:
        return "FORGOTPASSWORD";
      case APP_PAGE.productDetails:
        return "PRODUCTDETAILS";

      case APP_PAGE.subCategory:
        return "SUBCATEGORY";
      case APP_PAGE.search:
        return "SEARCH";
      case APP_PAGE.categoryView:
        return "CATEGORYVIEW";

      case APP_PAGE.productView:
        return "PRODUCTVIEW";
      case APP_PAGE.faq:
        return "FAQ";

      case APP_PAGE.editProductStep1:
        return "EDITPRODUCTSTEP1";
      case APP_PAGE.addProductStep2:
        return "ADDPRODUCTSTEP2";
      case APP_PAGE.addProductStep3:
        return "ADDPRODUCTSTEP3";
      case APP_PAGE.confirmOrder:
        return "CONFIRMORDER";
      case APP_PAGE.favorites:
        return "FAVORITES";
      case APP_PAGE.myAccountSettings:
        return "MYACCOUNTSETTINGS";
      case APP_PAGE.myAccount:
        return "MYACCOUNT";
      case APP_PAGE.myServices:
        return "MYSERVICES";

      case APP_PAGE.notifications:
        return "NOTIFICATIONS";
      case APP_PAGE.newOffer:
        return "NEWOFFER";
      case APP_PAGE.updateOffer:
        return "UPDATEOFFER";
      case APP_PAGE.conversation:
        return "CONVERSTATION";
      case APP_PAGE.chatView:
        return "CHATVIEW";
      case APP_PAGE.chatViewDekstop:
        return 'CHATVIEWDESKTOP';
      case APP_PAGE.directChatView:
        return 'DirectChatView';
      case APP_PAGE.directChatViewDesktop:
        return "DIRECTCHATVIEWDESKTOP";
      case APP_PAGE.directMyJobOfferID:
        return 'DIRECTMYJOBOFFERID';
      case APP_PAGE.directJobDetails:
        return "DIRECTJOBDETAILS";
      case APP_PAGE.settings:
        return "SETTINGS";
      case APP_PAGE.subscription:
        return "SUBSCRIPTION";
      case APP_PAGE.orderAndPay:
        return "ORDERANDPAY";

      case APP_PAGE.myJobs:
        return 'MYJOBS';
      case APP_PAGE.myJobOffers:
        return 'MYJOBOFFRS';
      case APP_PAGE.myJobOfferid:
        return 'MYJOBOFFRID';
      case APP_PAGE.myOffers:
        return 'MYOFFRS';
      case APP_PAGE.jobDetails:
        return 'JOBDETAILS';
      case APP_PAGE.viewService:
        return 'VIEWSERVICE';
      case APP_PAGE.verificaiton:
        return 'VERIFICATION';

      case APP_PAGE.browseRequests:
        return 'BROWSEREQUESTS';
      case APP_PAGE.buyCredits:
        return 'BUYCREDITS';
      case APP_PAGE.buyCreditsApple:
        return 'BUYCREDITSAPPLE';
      case APP_PAGE.creditHistory:
        return 'CREDITHISTORY';
      case APP_PAGE.paymentMethod:
        return "PAYMENTMETHOD";
      case APP_PAGE.paymentStripe:
        return "PAYMENTSTRIPE";
      case APP_PAGE.paymentSuccess:
        return "PAYMENTSUCCESS";
      case APP_PAGE.becomeSeller:
        return "BECOMESELLER";
      case APP_PAGE.becomeSuccess:
        return "BECOMESUCCESS";
      case APP_PAGE.userProfile:
        return "USERPROFILE";
      case APP_PAGE.writeReview:
        return 'WRITEREVIEW';
      case APP_PAGE.workChatView:
        return 'WORKCHATVIEW';
      case APP_PAGE.workChatViewDesktop:
        return 'WORKCHATVIEWDESKTOP';
      default:
        return "HOME";
    }
  }

  String get toTitle {
    switch (this) {
      case APP_PAGE.splash:
        return "WELCOME";
      case APP_PAGE.country:
        return "COUNTRY";
      case APP_PAGE.signIn:
        return "SIGN IN";
      case APP_PAGE.home:
        return "LOCALSERVICE";
      case APP_PAGE.addProductStep1:
        return "ADD PRODUCT STEP1";
      case APP_PAGE.changePassword:
        return "CHANGE PASSWORD";
      case APP_PAGE.resetPasword:
        return "RESET PASSWORD";
      case APP_PAGE.signUp:
        return "SIGN UP";
      case APP_PAGE.workStep1:
        return "WORK STEP1";
      case APP_PAGE.workStep2:
        return "WORK STEP2";
      case APP_PAGE.workStep3:
        return "WORK STEP3";
      case APP_PAGE.hireStep1:
        return "HIRE STEP1";
      case APP_PAGE.hireStep2:
        return "HIRE STEP2";
      case APP_PAGE.hireStep3:
        return "HIRE STEP3";
      case APP_PAGE.forgotPassword:
        return "FORGOT PASSWORD";
      case APP_PAGE.productDetails:
        return "PRODUCT DETAILS";
      case APP_PAGE.error:
        return "ERROR";
      case APP_PAGE.sendPhoneNumber:
        return 'SENDPHONENUMBER';
      case APP_PAGE.subCategory:
        return "SUB CATEGORY";
      case APP_PAGE.search:
        return "SEARCH";
      case APP_PAGE.categoryView:
        return "CATEGORY VIEW";
      case APP_PAGE.productView:
        return "PRODUCT VIEW";
      case APP_PAGE.faq:
        return "FAQ";

      case APP_PAGE.searchProducts:
        return "SEARCH PRODUCTS";

      case APP_PAGE.editProductStep1:
        return "EDIT PRODUCT STEP1";
      case APP_PAGE.addProductStep2:
        return "ADD PRODUCT STEP2";

      case APP_PAGE.addProductStep3:
        return "ADD PRODUCT STEP3";
      case APP_PAGE.confirmOrder:
        return "CONFIRM ORDER";
      case APP_PAGE.favorites:
        return "FAVOIRTES";

      case APP_PAGE.myAccountSettings:
        return "ACCOUNT SETTINGS";
      case APP_PAGE.myAccount:
        return "ACCOUNT";
      case APP_PAGE.myServices:
        return "MY SERVICES";
      case APP_PAGE.notifications:
        return "NOTIFICATIONS";
      case APP_PAGE.newOffer:
        return "NEWOFFER";
      case APP_PAGE.updateOffer:
        return "UPDATEOFFER";
      case APP_PAGE.conversation:
        return "CONVERSATION";
      case APP_PAGE.chatView:
        return "CHAT VIEW";
      case APP_PAGE.chatViewDekstop:
        return 'CHATVIEWDESKTOP';
      case APP_PAGE.directChatView:
        return 'DIRECTCHATVIEW';
      case APP_PAGE.directChatViewDesktop:
        return "DIRECTCHATVIEWDESKTOP";
      case APP_PAGE.directMyJobOfferID:
        return 'DIRECTMYJOBOFFERID';
      case APP_PAGE.directJobDetails:
        return "DIRECTJOBDETAILS";
      case APP_PAGE.settings:
        return "SETTINGS";
      case APP_PAGE.subscription:
        return "SUBSCRIPTION";
      case APP_PAGE.orderAndPay:
        return "ORDERANDPAY";

      case APP_PAGE.myJobs:
        return 'MYJOBS';
      case APP_PAGE.myJobOffers:
        return 'MYJOBOFFERS';
      case APP_PAGE.myJobOfferid:
        return 'MYJOBOFFRID';
      case APP_PAGE.myOffers:
        return 'MYOFFERS';
      case APP_PAGE.viewService:
        return 'VIEWSERVICE';
      case APP_PAGE.verificaiton:
        return 'VERIFICATION';

      case APP_PAGE.browseRequests:
        return 'BROWSEREQUESTS';
      case APP_PAGE.buyCredits:
        return 'BUYCREDITS';
      case APP_PAGE.buyCreditsApple:
        return 'BUYCREDITSAPPLE';
      case APP_PAGE.jobDetails:
        return 'JOBDETAILS';
      case APP_PAGE.creditHistory:
        return 'CREDITHISTORY';
      case APP_PAGE.paymentMethod:
        return "PAYMENT METHOD";
      case APP_PAGE.paymentStripe:
        return "PAYMENTSTRIPE";
      case APP_PAGE.paymentSuccess:
        return "PAYMENTSUCCESS";
      case APP_PAGE.becomeSeller:
        return "BECOMESELLER";
      case APP_PAGE.becomeSuccess:
        return "BECOMESUCCESS";
      case APP_PAGE.userProfile:
        return "USERPROFILE";
      case APP_PAGE.writeReview:
        return 'WRITEREVIEW';
      case APP_PAGE.workChatView:
        return 'WORKCHATVIEW';
      case APP_PAGE.workChatViewDesktop:
        return 'WORKCHATVIEWDESKTOP';
      default:
        return "LOCALSERVICE";
    }
  }
}
