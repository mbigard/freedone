<?php
class CodeassociationsValidationModuleFrontController extends ModuleFrontController
{
    public function postProcess()
    {
        if(Tools::getIsset('ajax')) {
            if (empty(Configuration::get('CODE_ASSOCIATIONS_DEFAULT_PERCENTAGE'))) {
                $default_percetange = 10;
            } else {
                $default_percetange = (float)Configuration::get('CODE_ASSOCIATIONS_DEFAULT_PERCENTAGE');
            }
            $cart = new Cart($this->context->cart->id);

            if (Tools::getValue('codeAsso')) {
                $codeAsso = Tools::getValue('codeAsso');
                $asso = AssociationModel::getAssoByCode($codeAsso);
                //$amount = $cart->getOrderTotal(false) * $asso['amount'] / 100;
                $amount = $cart::getTotalCart($this->context->cart->id, false, Cart::BOTH_WITHOUT_SHIPPING) * $asso['amount'] / 100;

                if (count($asso['asso']) > 0) 
                    Db::getInstance()->update(
                        'cart',
                        [
                            'id_code_association' => $asso['asso']['id_association'],
                            'code_association_percentage' => $asso['amount']
                        ],
                        'id_cart = '. (int)$this->context->cart->id
                    );
                else
                    Db::getInstance()->update(
                        'cart',
                        [
                            'id_code_association' => 0,
                            'code_association_percentage' => $default_percetange
                        ],
                        'id_cart = '. (int)$this->context->cart->id
                    );

                echo json_encode(['amount' => number_format((float)$amount, 2, ',', ''), 'freedone' => $asso['freedone']]);
                die;
            }

            $amount = $cart::getTotalCart($this->context->cart->id, false, Cart::BOTH_WITHOUT_SHIPPING) * $default_percetange / 100;
            //$amount = $cart->getOrderTotal(false) * $default_percetange / 100;
            Db::getInstance()->update(
                'cart',
                [
                    'id_code_association' => 0,
                    'code_association_percentage' => $default_percetange
                ],
                'id_cart = '. (int)$this->context->cart->id
            );
            echo json_encode(['amount' => number_format((float)$amount, 2, ',', ''), 'freedone' => true]);
            die;
        }
    }
}