import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localservice/route/router_utils.dart';
import 'package:localservice/screens/buy_credits_apple/buy_credits_apple_screen.dart';
import 'package:localservice/screens/country/country_screen.dart';
import 'package:localservice/screens/direct_job_details/direct_job_details_screen.dart';
import 'package:localservice/screens/direct_job_details_public/direct_job_details_public_screen.dart';
import 'package:localservice/screens/direct_my_job_offerid/direct_my_job_offerid_screen.dart';
import 'package:localservice/screens/my_account/my_account.dart';
import 'package:localservice/screens/my_job_offerid/my_job_offerid_screen.dart';
import 'package:localservice/screens/my_jobs/my_jobs_screen.dart';
import 'package:localservice/screens/my_job_offers/my_job_offers_screen.dart';
import 'package:localservice/screens/job_details/job_details_screen.dart';
import 'package:localservice/screens/my_offers/my_offers_screen.dart';
import 'package:localservice/screens/my_services/my_services.dart';
import 'package:localservice/screens/new_offer/new_offer.dart';
import 'package:localservice/screens/payment_method/payment_method.dart';
import 'package:localservice/screens/update_offer/update_offer.dart';
import 'package:localservice/screens/verification/verification.dart';
import 'package:localservice/screens/view_service/view_service_screen.dart';
import 'package:localservice/screens/work_chat_view/work_chat_view.dart';
import 'package:localservice/screens/write_review/write_review.dart';
import 'package:localservice/services/AppService.dart';
import 'package:localservice/screens/change_password/change_password_screen.dart';
import 'package:localservice/screens/home/home_screen.dart';
import 'package:localservice/screens/reset_password/reset_password_screen.dart';
import 'package:localservice/screens/sign_up/sign_up_screen.dart';
import 'package:localservice/screens/sign_in/sign_in_screen.dart';
import 'package:localservice/screens/splash_screen/splash_screen.dart';
import 'package:localservice/screens/forgot_password/forgot_password_screen.dart';
import 'package:localservice/screens/faq/faq_screen.dart';
import 'package:localservice/screens/my_account_settings/my_account_settings.dart';
import 'package:localservice/screens/notifications/notifications.dart';
import 'package:localservice/screens/conversation/conversation.dart';
import 'package:localservice/screens/chat_view/chat_view.dart';
import 'package:localservice/screens/settings/settings.dart';
import 'package:localservice/screens/work_step1/workstep1_screen.dart';
import 'package:localservice/screens/work_step2/workstep2_screen.dart';
import 'package:localservice/screens/work_step3/workstep3_screen.dart';
import 'package:localservice/screens/hire_step1/hirestep1_screen.dart';
import 'package:localservice/screens/hire_step2/hirestep2_screen.dart';
import 'package:localservice/screens/hire_step3/hirestep3_screen.dart';
import 'package:localservice/screens/subscription/subscription_screen.dart';
import 'package:localservice/screens/browse_requests/browse_requests_screen.dart';
import 'package:localservice/screens/buy_credits/buy_credits_screen.dart';
import 'package:localservice/screens/order_and_pay/order_and_pay_screen.dart';
import 'package:localservice/screens/send_phone_number/send_phone_number.dart';
import 'package:localservice/screens/credit_history/credit_history.dart';
import 'package:localservice/screens/payment_stripe/payment_stripe.dart';
import 'package:localservice/screens/payment_success/payment_success.dart';
import 'package:localservice/screens/become_seller/become_seller.dart';
import 'package:localservice/screens/become_success/become_success.dart';
import 'package:localservice/screens/user_profile/user_profile.dart';
import 'package:localservice/screens/direct_chat_view/direct_chat_view.dart';
import 'package:localservice/screens/chat_view_desktop/chat_view_desktop.dart';
import 'package:localservice/screens/work_chat_view_desktop/work_chat_view_desktop.dart';
import 'package:localservice/screens/direct_chat_view_desktop/direct_chat_view_desktop.dart';

class AppRouter {
  late final AppService appService;
  GoRouter get router => _goRouter;

  AppRouter(this.appService);

  late final GoRouter _goRouter = GoRouter(
    refreshListenable: appService,
    errorBuilder: (context, state) {
      appService.browserRefreshed = false;
      if (appService.loginState == true)
        return MyAccountSettingsScreen();
      else
        return SplashScreen();
    },
    redirect: (BuildContext context, GoRouterState state) {
      if (appService.browserRefreshed) {
        return '/';
      } else {
        return null;
      }
    },
    initialLocation: appService.countryRegistered
        ? appService.loginState
            ? appService.user['is_worker'] == false
                ? appService.user['user_type'] == 'work'
                    ? APP_PAGE.workStep1.toPath
                    : APP_PAGE.home.toPath
                : appService.user['user_type'] != "work"
                    ? APP_PAGE.home.toPath
                    : appService.user['is_approved'] == null ||
                            appService.user['is_approved'] == false
                        ? APP_PAGE.workStep1.toPath
                        : APP_PAGE.browseRequests.toPath
            : APP_PAGE.signIn.toPath
        : APP_PAGE.splash.toPath,
    routes: <GoRoute>[
      GoRoute(
          path: APP_PAGE.splash.toPath,
          name: APP_PAGE.splash.toName,
          builder: (context, state) {
            appService.browserRefreshed = false;
            return SplashScreen();
          }),
      GoRoute(
          path: APP_PAGE.country.toPath,
          name: APP_PAGE.country.toName,
          builder: (context, state) {
            appService.browserRefreshed = false;
            return CountryScreen();
          }),
      GoRoute(
        path: APP_PAGE.subscription.toPath,
        name: APP_PAGE.subscription.toName,
        builder: (context, state) => SubscriptionScreen(),
      ),
      GoRoute(
        path: APP_PAGE.orderAndPay.toPath,
        name: APP_PAGE.orderAndPay.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return OrderAndPayScreen();
          }
        },
      ),
      GoRoute(
          path: APP_PAGE.signIn.toPath,
          name: APP_PAGE.signIn.toName,
          builder: (context, state) {
            appService.browserRefreshed = false;
            return SignInScreen();
          }),
      GoRoute(
          path: APP_PAGE.home.toPath,
          name: APP_PAGE.home.toName,
          builder: (context, state) {
            if (appService.loginState == false) {
              return SignInScreen();
            } else {
              return HomeScreen();
            }
          }),
      GoRoute(
        path: APP_PAGE.workStep1.toPath,
        name: APP_PAGE.workStep1.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return WorkStep1Screen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.workStep2.toPath,
        name: APP_PAGE.workStep2.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return WorkStep2Screen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.workStep3.toPath,
        name: APP_PAGE.workStep3.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return WorkStep3Screen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.sendPhoneNumber.toPath,
        name: APP_PAGE.sendPhoneNumber.toName,
        builder: (context, state) => SendPhoneNumberScreen(),
      ),
      GoRoute(
        path: APP_PAGE.hireStep1.toPath,
        name: APP_PAGE.hireStep1.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return HireStep1Screen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.hireStep2.toPath,
        name: APP_PAGE.hireStep2.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return HireStep2Screen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.hireStep3.toPath,
        name: APP_PAGE.hireStep3.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return HireStep3Screen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.changePassword.toPath,
        name: APP_PAGE.changePassword.toName,
        builder: (context, state) => ChangePasswordScreen(),
      ),
      GoRoute(
        path: APP_PAGE.resetPasword.toPath,
        name: APP_PAGE.resetPasword.toName,
        builder: (context, state) => ResetPasswordScreen(),
      ),
      GoRoute(
        path: APP_PAGE.signUp.toPath,
        name: APP_PAGE.signUp.toName,
        builder: (context, state) => SignUpScreen(
          inviteCode: state.params['inviteCode'],
        ),
      ),
      GoRoute(
        path: APP_PAGE.forgotPassword.toPath,
        name: APP_PAGE.forgotPassword.toName,
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        path: APP_PAGE.faq.toPath,
        name: APP_PAGE.faq.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return FaqScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.myAccountSettings.toPath,
        name: APP_PAGE.myAccountSettings.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return MyAccountSettingsScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.myAccount.toPath,
        name: APP_PAGE.myAccount.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return MyAccountScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.notifications.toPath,
        name: APP_PAGE.notifications.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return NotificationsScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.newOffer.toPath,
        name: APP_PAGE.newOffer.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return NewOfferScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.updateOffer.toPath,
        name: APP_PAGE.updateOffer.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return UpdateOfferScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.conversation.toPath,
        name: APP_PAGE.conversation.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return ConversationScreen();
          }
        },
      ),
      GoRoute(
          path: APP_PAGE.chatView.toPath,
          name: APP_PAGE.chatView.toName,
          builder: (context, state) {
            if (appService.loginState == true)
              return ChatViewScreen();
            else
              return SignInScreen();
          }),
      GoRoute(
          path: APP_PAGE.chatViewDekstop.toPath,
          name: APP_PAGE.chatViewDekstop.toName,
          builder: (context, state) {
            if (appService.loginState == true)
              return ChatViewDesktopScreen();
            else
              return SignInScreen();
          }),
      GoRoute(
          path: APP_PAGE.directChatView.toPath,
          name: APP_PAGE.directChatView.toName,
          builder: (context, state) {
            if (appService.loginState == true)
              return DirectChatViewScreen(roomID: state.params['roomID']);
            else
              return SignInScreen();
          }),
      GoRoute(
          path: APP_PAGE.directChatViewDesktop.toPath,
          name: APP_PAGE.directChatViewDesktop.toName,
          builder: (context, state) {
            if (appService.loginState == true)
              return DirectChatViewDesktopScreen(
                  roomID: state.params['roomID']);
            else
              return SignInScreen();
          }),
      GoRoute(
          path: APP_PAGE.directJobDetails.toPath,
          name: APP_PAGE.directJobDetails.toName,
          builder: (context, state) {
            if (appService.loginState == true)
              return DirectJobDetailsScreen(
                  requestID: state.params['requestID']!);
            else
              return DirectJobDetailsPublicScreen(
                  requestID: state.params['requestID']!);
          }),
      GoRoute(
        path: APP_PAGE.settings.toPath,
        name: APP_PAGE.settings.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return SettingsScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.myJobs.toPath,
        name: APP_PAGE.myJobs.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return MyJobsScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.myServices.toPath,
        name: APP_PAGE.myServices.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return MyServicesScreen();
          }
        },
      ),
      GoRoute(
          path: APP_PAGE.myJobOffers.toPath,
          name: APP_PAGE.myJobOffers.toName,
          builder: (context, state) {
            if (appService.loginState == false) {
              return SignInScreen();
            } else {
              return MyJobOffersScreen();
            }
          }),
      GoRoute(
        path: APP_PAGE.myJobOfferid.toPath,
        name: APP_PAGE.myJobOfferid.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return MyJobOfferidScreen();
          }
        },
      ),
      GoRoute(
          path: APP_PAGE.directMyJobOfferID.toPath,
          name: APP_PAGE.directMyJobOfferID.toName,
          builder: (context, state) {
            if (appService.loginState == false) {
              return SignInScreen();
            } else {
              return DirectMyJobOfferidScreen(
                  offerID: state.params['offerID']!);
            }
          }),
      GoRoute(
        path: APP_PAGE.myOffers.toPath,
        name: APP_PAGE.myOffers.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return MyOffersScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.paymentMethod.toPath,
        name: APP_PAGE.paymentMethod.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return PaymentMethodScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.jobDetails.toPath,
        name: APP_PAGE.jobDetails.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return JobDetailsScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.viewService.toPath,
        name: APP_PAGE.viewService.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return ViewServiceScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.verificaiton.toPath,
        name: APP_PAGE.verificaiton.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return VerificationScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.browseRequests.toPath,
        name: APP_PAGE.browseRequests.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return BrowseRequestScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.paymentSuccess.toPath,
        name: APP_PAGE.paymentSuccess.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return PaymentSuccessScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.buyCredits.toPath,
        name: APP_PAGE.buyCredits.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return BuyCreditsScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.buyCreditsApple.toPath,
        name: APP_PAGE.buyCreditsApple.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return BuyCreditsAppleScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.creditHistory.toPath,
        name: APP_PAGE.creditHistory.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return CreditHistoryScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.paymentStripe.toPath,
        name: APP_PAGE.paymentStripe.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return PaymentStripeScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.becomeSeller.toPath,
        name: APP_PAGE.becomeSeller.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return BecomeSellerScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.becomeSuccess.toPath,
        name: APP_PAGE.becomeSuccess.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return BecomeSuccessScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.userProfile.toPath,
        name: APP_PAGE.userProfile.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return UserProfileScreen();
          }
        },
      ),
      GoRoute(
        path: APP_PAGE.writeReview.toPath,
        name: APP_PAGE.writeReview.toName,
        builder: (context, state) {
          if (appService.loginState == false) {
            return SignInScreen();
          } else {
            return WrieteReviewScreen();
          }
        },
      ),
      GoRoute(
          path: APP_PAGE.workChatView.toPath,
          name: APP_PAGE.workChatView.toName,
          builder: (context, state) {
            if (appService.loginState == true)
              return WorkChatViewScreen();
            else
              return SignInScreen();
          }),
      GoRoute(
          path: APP_PAGE.workChatViewDesktop.toPath,
          name: APP_PAGE.workChatViewDesktop.toName,
          builder: (context, state) {
            if (appService.loginState == true)
              return WorkChatViewDesktopScreen();
            else
              return SignInScreen();
          }),
      GoRoute(
          path: '/',
          name: 'root',
          builder: (context, state) {
            appService.browserRefreshed = false;
            if (appService.loginState == true)
              return MyAccountSettingsScreen();
            else
              return SplashScreen();
          }),
    ],
    // errorBuilder: (context, state) => HomeScreen(),
  );
}
