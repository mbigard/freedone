<div class="code_associations">
    <label for="code_associations">{l s="VOUS AVEZ UN CODE ASSO ?" d="codeassociations.hook.haveCode"}</label>
    <input id="code_associations" type="text" class="input_code_association" value="{$code}" name="code_association" />
    <button data-urlAjax="{$urlAjax}" id="button_code_association" name="button_code_association">SEND</button>
    <p>
        <span class="asso_freedone">{l s="Sera reversé à l'association maison freedone, aide aux personnes en situation de handicap : " d="codeassociations.hook.reversementfreedone"}</span>
        <span class="hide asso_autre">{l s="Sera reversé à l'association correspondant au code que vous avez renseigné : " d="codeassociations.hook.reversementautre"}</span>
        <span class="code_association_price right"></span> €</br>
        <span class="message-for-all"><a target="_blank" href="/content/7-nos-associations-partenaires">Voir la liste des associations partenaires et leurs codes respectifs</a></span>
    </p>
</div>
