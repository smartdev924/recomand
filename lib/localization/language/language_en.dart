import 'languages.dart';

class LanguageEn extends Languages {
  // @override
  String get appName => "LocalService";
  // error

  String get kEmailNullError => "Please Enter your email";
  String get kInvalidEmailError => "Please Enter Valid Email";
  String get kPassNullError => "Please Enter your password";
  String get kConfirmPasswordError => "Password mismatching";
  String get kShortPassError => "Password is too short, at least 8 chars";
  String get kMatchPassError => "Passwords don't match";
  String get kNameNullError => "Please Enter your full name";
  String get kPhoneNumberNullError => "Please Enter your phone number";
  String get kAddressNullError => "Please Enter your address";
  String get kTitleNullError => "Please enter your product title";
  String get kDescriptionNullError => "Please input description";
  String get kPriceNullError => "Please input price";
  String get kDeadLineNullError => "Please input deadline";
  //Splash screen, sign in, sign out, reset, etc - first screens
  String get slogan => 'Up to 7 offers with 1 request !';
  String get lab_continue => 'Continue';
  String get signin => 'Sign In';
  String get signup => 'Sign Up';
  String get createaccount => 'Create account';
  String get forgotpassword => 'Forgot Password';
  String get email => 'Email';
  String get password => 'Password';
  String get pleaseendteryouremail => 'Please enter your email';
  String get pleaseenteryourpassword => 'Please enter your password';
  String get forgotpassword_description =>
      'Please enter your email address. You will receive a link to create a new password via email.';
  String get lab_send => 'SEND';
  String get changepassword => 'CHANGE PASSWORD';
  String get confirmpassword => 'Confirm password';
  String get resetpass_description => 'Enter new password and confirm.';
  String get resetpassword => 'Reset Password';
  String get currentpassword => 'Current Password';
  String get enteryourcurrentpassword => 'Enter your current password';
  String get newpassword => 'New password';
  String get enteryournewpassword => 'Enter your new password';
  String get confirmnewpassword => 'Confirm new password';
  String get repeatyournewpassword => 'Repeat your new password';
  String get haveInvite => 'Have a invite code ?';
  String get inviteCode => 'Invite Code';
  String get inputCode => 'Please input your invite code';
  String get name => 'Name';
  String get inputName => 'Please input your full name';
  String get workType => "WORK";
  String get hireType => "HIRE";

  //Settings page
  String get lab_settings => "Settings";
  String get labelSelectLanguage => "Select Language";
  String get labelLanguage => "Language";
  String get lab_colorstyle => 'Color Style';
  String get lab_changepassword => 'Change Password';
  String get delete_account => "Delete Account";

  //accountsetting page
  String get addproduct => 'Add Product';
  String get payments => 'Payments';
  String get FAQ => 'FAQ';
  String get paymentshistory => 'Payments History';
  String get myproducts => 'My Products';
  String get notificaiton => 'Notifications';
  String get mysales => 'My Sales';
  String get myorders => 'My Orders';
  String get favorites => 'Favorites';
  String get signout => 'Logout';
  String get fromCamera => "From Camera";
  String get fromFiles => "From Files";
  String get switchToHire => "Switch to Hire";
  String get switchToWorker => "Switch to Worker";

  //chatting room
  String get conversations => 'Conversations';
  String get nochattingroom => 'No chat rooms yet';
  String get gohomepage => 'Go homepage';
  String get goBrowserPage => "Browse Job";
  String get cancel_btn => 'Cancel';
  String get delete_btn => 'Delete';
  String get areyousure => 'Are you sure ?';
  String get delete_description => 'This room will be deleted permanently.';
  String get archiveroom => 'Archive this room';
  String get deleteroom => 'Delete this room';

  //add product
  String get title => 'TITLE';
  String get description => 'DESCRIPTION';
  String get price => 'PRICE';
  String get next_btn => 'NEXT';

  //file
  String get publish_btn => 'PUBLISH';
  String get backtohome => 'Back to homepage';
  String get copyClipboard => 'Copied to Clipboard!';

  //add or remove product
  String get deleteImage => 'This image will be deleted.';

  //here is the new languages for local service app

  //browse request
  String get searchRequest => 'Search for a request';
  String get searchCategory => 'Search for a category';
  String get new_tab => 'New';
  String get active => 'Active';
  String get previous => 'Previous';
  String get all => 'All';
  String get noItems => 'There are no items.';
  String get totalProposal => 'Total proposal';
  String get selectedServices => ' services selected';
  String get selectedCities => ' cities selected';
  String get depositCoins => 'Deposit Now';
  String get requireCreditsDescription =>
      "To be able to see customer requests, you must have at least 1 credit in your account.";
  String get credits => "Credits";

  //chat view
  String get unnamed => 'Unnamed';

  //validation text

  String get integeronly => "Please input integer only";
  String get filedMandatory => "This field is mandatory";

  //hirestep 01
  String get serviceCall => 'Service provider can call';
  String get heading_request => 'What are the details of your job request ?';
  String get valid_question1 => 'Any other details you see relevant ?';
  String get valid_question2 =>
      'If you do not provide enough information. this will affect the number of quotes you will receive.';
  String get valid_question3 => 'You should input 100 letters at least.';
  String get image_question => 'Would you like to add pictures ?';
  String get where_location => 'Where ? (Location of the job)';
  String get location_validation =>
      'We can\'t use your location. Please search city or input manually';
  String get userMyLocation => 'USE MY LOCATION';
  String get enterCity => 'Enter your city name';
  String get when_job => 'When ? (date of the job)';
  String get answer_question => 'Would you like to answer these questions ?';
  String get inputAnswer => 'Input your answer here...';
  String get enterPhone => 'Enter your Phone';
  String get phoneDescription =>
      'Our pros con contact you faster if you select “Service provider can call “.';
  String get enterPhoneNumber => 'Enter your phone number';
  String get sendRequest => 'SEND REQUEST';
  String get alert_image => 'Please upload at least one image.';
  String get alert_description => 'Please input description.';
  String get alert_address => 'Please input your address.';
  String get alert_one_option => 'Please select one option.';
  String get alert_pick_date => 'Please pick up date.';
  String get alert_answer => 'Please answer the question';
  String get alert_phone => 'Please input phone number.';
  String get request_success_msg =>
      'Congratulation! You have requested successfully!';
  String get alert_close_description =>
      'You can get free quotes by answering few more questions.';
  String get go_on => 'GO ON';
  String get quit => 'QUIT';
  String get servicesCompanyReady => "Services company ready";
  String get allow_contacts => "Show my phone number";
  String get dont_disturbme => "Don't disturb me";
  String get only_phone => "Contact me only by phone";
  String get only_offers => "Send me only offers";
  String get only_whatsapp => "Contact me only by whatsapp";

  //hire step 02
  String get alert_nocity => 'Sorry but we can\'t find city you want...';
  String get what_looking => 'What are you looking for';
  String get select_service => 'Select type of service';
  String get remove_service => 'Remove this service';
  String get request_quote => 'Request 7 free quotes for';
  String get name_company => 'Name and surname (or company)';
  String get phone => 'Phone';
  String get search_city => 'Search for a city (Input 3 letters at least)';
  String get input_3 => 'Please input 3 letters at least to search city';
  String get when_service => 'When do you need this service';
  String get asap => 'As soon as possible';
  String get flexible => 'I am flexible';
  String get alert_name => 'Please input name and surname';
  String get alert_city => 'Please select city';
  String get request_success => 'Request success';
  String get tip_id => 'Tip ID';
  String get success_thankyou =>
      'Thank you for choosing our service and trusted to help you with your problems';

  //home page
  String get hi => 'Hi';
  String get home_description =>
      'Browse number of experts to get your issues resolved. start consulting now.';
  String get which_service => 'Which services do you need ?';
  String get no_service => 'No Services';

  // job detail
  String get no_city_info => 'Unknown';
  String get see_number => 'They can call and see my number';
  String get job_detail => 'Job details';
  String get aboutCustomer => "About Customer";
  String get receivedOffers => " Offers received";
  String get noOffers => "No Offers";
  String get reviews => "REVIEW";
  String get beFirstSend => "Be the first to send an offer";

  //my account setting
  String get become_seller => 'Become a Seller';

  //my job offer
  String get job_offer => 'Job Offers';
  String get deadline => 'Deadline';
  String get Price => 'Price';
  String get no_proposal => 'There are no proposals yet.';
  String get update_offer => "Update Offer";

  //my job
  String get ACTIVE => 'ACTIVE';
  String get CANCELED => 'CANCELED';
  String get Cancelled => 'Cancelled';
  String get my_jobs => 'My Jobs';
  String get card_onway =>
      'Quotes are on the way! We’ll let you know when a quote is received.';
  String get view_offer => 'View Offers';
  String get see_details => 'SEE DETAILS';
  String get cancel_request => 'CANCEL REQUEST';

  //my request
  String get my_requests => 'My requests';

  //order and pay
  String get oerder_pay => 'Order and pay';
  String get company_info => 'Company information';
  String get payment_method => 'Payment method';
  String get credit_card => 'Credit or debit card';
  String get payment_bank => 'Payment by bank transfer';
  String get request_10 => '10 requests';
  String get subscription_desc =>
      '400 lei 360 lei/month for 2 months then 400 lei/month';
  String get paynow_01 => 'Pay now (first month): 428,40 lei (VAT included)';
  String get agree => 'I agree with';
  String get terms_service => 'Terms and conditions';
  String get payNow => 'PAY NOW';
  String get name_company_02 => 'Your name or company name';
  String get city => 'City';
  String get address => 'Address';

  //splash
  String get send_splash => 'Send a request';
  String get receive_splash => 'Receive up to 17 offers';
  String get choose_splash => 'Choose the expert';

  //subscription
  String get choose_monthly => 'Choose monthly subscription';
  String get sub_01 => '400 lei 360 lei/month for 2 months then 400 lei/month';
  String get on_average1 =>
      'On average, you will be competing with 3 professionals.';
  String get no_contract => 'No contract period, you can cancel at any time';
  String get request_20 => '20 requests';
  String get sub_02 => '800 lei 480 lei/month for 2 months then 800 lei/month';
  String get on_average2 =>
      'On average, you will be competing with 3 professionals.';
  String get request_35 => '35 requests';
  String get on_average3 =>
      'On average, you will be competing with 2 professionals.';
  String get on_average4 =>
      'The average price per request is between 31.65 lei and 47.47 lei.';
  String get calc_description =>
      '*The number of requests is indicative and is calculated on the basis of the average price per request. Prices are detailed in the price list.';

  //view service
  String get get_7 => 'Get 7 Quotes';

  //work step 1
  String get step1_des => 'What services do you offer?';
  String get eliminate => 'Eliminate';
  String get step1_heading => 'What services do you offer?';
  String get change_anytime => 'You can change this at any time.';
  String get selected_service => 'Selected services';
  String get alert_select_service =>
      'Please select service from below list for the next step!';

  //work step 2
  String get step2_heading => 'What type of work are you interested in?';

  //work step 3
  String get step3_heading => 'What city(s) do you work as  a';
  String get selected_city => 'Selected  City(s)';
  String get alert_select_city => 'You should select city for next step';

  //country page
  String get ro => 'Romania';
  String get de => 'Germany';
  String get sp => 'Spain';
  String get fr => 'France';
  String get it => 'Italy';
  String get start => 'START';

  //missing
  String get selectCategory => 'SELECT CATEGORY';
  String get filters => 'Filters';
  String get priority => 'PRIORITY';
  String get search => 'Search';
  String get category => 'CATEGORY';

  String get buyCredits => 'Buy Credits';
  String get countryHeading => 'Please Select Your Country';
  String get creditHistory => 'Credit History';
  String get ID => 'ID';
  String get amount => 'Amount';
  String get date => 'Date';
  String get noCredit => 'No Credit History';
  String get Congratulation => 'Congratulation';
  String get requestPriority => 'Request Priority';
  String get acceptPolicy =>
      'I accept user and privacy adreement by pressing “SEND REQUEST”';
  String get willNotify =>
      'We will notify you via email and sms when your request receives quotes from pros.';
  String get receivedRequest => 'We received your request!';
  String get free => 'Free';
  String get priceCoins => 'PRICE COINS';
  String get type => 'TYPE';
  String get planSelect =>
      'Choose your payment plan according to the speed at which you need to find experts.';
  String get canceledRequest => 'You cancelled this request!';
  String get reasonSelect => 'Please select one of the below reasons.';
  String get reason_1 => 'Agreed with an offer outside this website.';
  String get reason_2 => 'The rates are to high.';
  String get reason_3 => 'Not sure about quality.';
  String get reason_4 => 'Not enough offers.';
  String get reason_5 => 'Couldn\'t get answers to my queries.';
  String get reason_6 => 'I no lounger require this service';
  String get unlockedReq => 'You unlocked this request!';
  String get sureUnlock => 'Are you sure to unlock this request ?';
  String get activeStatus => 'Status: ACTIVE';
  String get offers => 'OFFERS';
  String get viewOffers => 'VIEW OFFERS';
  String get jobID => 'JOB ID';
  String get unlockReq => 'Unlock Request';
  String get sendOffer => 'Send Offer';

  //my account
  String get myaccount => 'My Account';
  String get myDetails => 'My details';
  String get successUpdated => 'Successfully updated!';
  String get imageSelectAlert => 'image not selected';
  String get coins => 'coins';
  String get myOffers => 'My Offers';
  String get myservices => 'My Services';
  String get offer => 'OFFER';
  String get noJobs => 'NOT JOBS HERE';
  String get noRequestDesc =>
      'You don’t have any job requested.\nRequest the service you want, get free quotes!';

  String get browseServices => 'BROWSE SERVICES';
  String get c_reason_1 => 'I changed my mind about the service.';
  String get c_reason_2 => 'I am busy with other work.';
  String get c_reason_3 => 'I dont like the customer';
  String get c_reason_4 => 'Not time to work.';
  String get c_reason_5 => 'No Reason.';
  String get cancelOffer => 'Cancel Offer';
  String get pauseReq => 'PAUSE REQUEST';
  String get cancelledOffer => 'You cancelled this offer!';
  String get startFrom => 'START FROM';
  String get save => "Save";

  String get services => 'Services';
  String get cities => 'Cities';
  String get noService => 'No Services !';
  String get noServicesDesc =>
      'You don\'t have any service yet.\nPlease add services if want to start earning.';
  String get noCity => 'No Cities !';
  String get noCityDesc =>
      'You don\'t have any cities yet.\nPlease add cities if want to start earning.';
  String get addService => 'Add Service';
  String get searchService => 'Search Service';
  String get myServices => 'My Services';
  String get myCities => 'My Cities';
  String get addCity => 'Add City';
  String get searchCity => 'Search City';

  String get newOffer => 'New Offer';
  String get offerType => 'OFFER TYPE';
  String get offerDescriptionHint =>
      "Show the customer that you understand their needs. Make a special offer. Tell him what makes you different and why he can trust you.";
  String get sentOffer => 'You sent offer!';
  String get updatedOffer => 'You updated offer!';
  String get noNotification => 'No Notifications!';
  String get notificationDesc =>
      'You dont have any notification yet. Please place order';

  String get creditCard => 'Credit Card';
  String get bank => 'Bank';
  String get proposalReq => 'Proposals request';

  String get BECOME_SELLER => 'BECOME A SELLER';
  String get verifyCode => 'Verification code';
  String get codeVerifyDesc =>
      'We just send you a verify code. Check your inbox to get them.';
  String get resend_code => 'Re-send code in  ';
  String get avg_rating => 'average rating';
  String get verify_review => 'verified reviews';

  String get noSearchResult => 'No Search Result ';
  String get inputThree => 'Please input at least 3 letters';

  String get nojobreq => 'No jobs request.';
  String get nojobreq_des =>
      'No jobs request for your services. We will send you notifications when new requests for your services appear.';

  String get serviceReady => 'Services company ready';
  String get everyear => 'Every year';
  String get peopleTrust => 'people trust Local Services for';

  //redeem code section
  String get redeemVoucher => 'REDEEM VOUCHER';
  String get redeemAction => 'This code will be applied to your account.';
  String get codeInvaild => 'The code entered is not valid.';
  String get couponSuccess =>
      'Coupon code applied successfully to your account.';
  String get cousherCode => 'Voucher code';
  String get tryAgain => 'TRY AGAIN';
  String get addNew => 'ADD NEW';
  String get addBtn => 'ADD';
  String get apply => 'APPLY';
  String get haveRedeemCode => 'Do you have a redeem code ?';
  String get paymentMethod => 'Payment Method';

  String get specificTime => 'Specific Time (Within three weeks)';
  String get inTwoMonth => 'In Two Months';
  String get inSixMonth => 'In Six Months';
  String get onlyPrice => 'Just looking for price';
  String get flexibleTime => 'Flexible';
  String get allContact => 'Allow Contacts';
  String get onlyOffers => 'Only Offers';
  String get onlyPhone => 'Only Phone';
  String get onlyWhatsapp => 'Only WhatsApp';
  String get notDisturb => 'Don\'t disturb me';

  String get processing => "processing";
  String get thankyou => "Thank You";
  //become a seller
  String get companyNameHint => 'Company Name or Personal Name';
  String get companyNumberHint => 'Company Number or Personal Number';
  String get profileDescriptionHint => "Profile Description";
  String get companyNameValidateError =>
      "Please Input Company or Personal Name";
  String get companyNumberValidateError =>
      "Please input Company or Personal Number";
  String get profileDescriptionValidateError =>
      "Please input Prfoile Description";
  String get addressValidateError => "Please input address";
  String get phoneValidateError => "Please input phone";
  String get optional => "(OPTIOANL)";
  String get becomeSellerApproved =>
      "Your application to become a seller has been submited.";
  String get private => "PRIVATE";
  String get company => "COMPANY";
  String get close => "CLOSE";

  //other
  String get call => "CALL";
  String get skip => "SKIP";
  String get chat => "CHAT";
  String get seeAll => "SEE ALL";
  String get award => "AWARD";
  String get noPhoneNumber => "User haven't got phone number.";
  String get about => "About";
  String get photos => "Photos";
  String get feedBacks => "Feedbacks";
  String get contact => "Contact";
  String get favorite => "Favorite";
  String get share => "Share";
  String get clientMode => "Client Mode";
  String get providerMode => "Provider Mode";
  String get addButton => "Add";
  String get backButton => "Back";
  String get addSucceed => "Successfuly added";
  // write review
  String get howWasService =>
      "How was the service you received? \nAre you satisfied?";
  String get writeReview => "write your review";
  String get keepMeReviewHidden => "Keep my review hidden";
  String get inputReviewError => "Please input your review";
  String get reviewedSuccess => "Your reviewed successfully";
  String get pleaseSelectReason => "Please select one of the below reasons.";
  String get confirm => "Confirm";
  String get cancelRequestReason1 =>
      "Agreed with an offer outside this website.";
  String get cancelRequestReason2 => "The rates are to high.";
  String get cancelRequestReason3 => "Not sure about quality.";
  String get cancelRequestReason4 => "Not enough offers.";
  String get cancelRequestReason5 => "Couldn't get answers to my queries.";
  String get cancelRequestReason6 => "I no lounger require this service";
  String get minute => 'minute ';
  String get minutes => 'minutes ';
  String get day => 'day ';
  String get days => 'days ';
  String get month => 'month ';
  String get months => 'months ';
  String get ago => 'ago ';
  String get hour => "hour";
  String get hours => "hours";
  String get headStringRegistered => 'registered';
  String get tailStringRegistered => 'ago';
  String get high => "high";
  String get iWant => "I want";
  String get total => "total";
  String get availableFrom => "Available from";
  String get deadLineHint => 'in 5 days';

  //chat widget
  String get typing => 'typing';
  String get online => 'online';
  String get offline => 'offline';
  String get connecting => 'Connecting';
  String get joinRoom => 'Join room again';
  String get hintTextMessage => "message";
  String get fullScreen => "Fullscreen";
  String get noOffersDesc =>
      "You don't have any offers yet.Go now to the requests page and send offers on customer requests.";
}
