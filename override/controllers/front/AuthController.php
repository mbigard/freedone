<?php
class AuthController extends AuthControllerCore
{
    /*
    * module: pkcaptcha
    * date: 2023-12-05 15:12:09
    * version: 2.0.1
    */
    public function initContent()
    {
        if ( Tools::isSubmit('submitCreate') ) {
              Hook::exec('actionContactFormSubmitCaptcha');
              if ( ! sizeof( $this->context->controller->errors ) ) {
                parent::initContent();
            } else {
                $register_form = $this
                ->makeCustomerForm()
                ->setGuestAllowed(false)
                ->fillWith(Tools::getAllValues());
                FrontController::initContent();
                $this->context->smarty->assign([
                    'register_form' => $register_form->getProxy(),
                    'hook_create_account_top' => Hook::exec('displayCustomerAccountFormTop')
                ]);
                $this->setTemplate('customer/registration');
            }
        } else {
            parent::initContent();
        }
    }
}
