<div class="code_associations">
    <label for="code_associations">{l s="VOUS AVEZ UN CODE ASSO ?" d="codeassociations.hook.haveCode"}</label>
    <input id="code_associations" type="text" class="input_code_association" value="{$code}" name="code_association" />
    <button data-urlAjax="{$urlAjax}" id="button_code_association" name="button_code_association">SEND</button>
    <p>
        <span class="asso_freedone">{l s="Sera reversé à l'association freedone : " d="codeassociations.hook.reversementfreedone"}</span>
        <span class="hide asso_autre">{l s="Sera reversé à votre association : " d="codeassociations.hook.reversementautre"}</span>
        <span class="code_association_price right"></span> €
    </p>
</div>