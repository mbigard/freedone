$(document).ready(function(){
    $('span.hide').hide();
	if ($('input[name="code_association"]').val() != "") {
		sendCodeAsso();
	} else {
		sendCodeAsso();
	}
    $(document).on('click', 'button#button_code_association', function(e) {
      sendCodeAsso();
    });
});

function sendCodeAsso(){
  $.ajax({
    type: 'POST',
    dataType: 'JSON',
    url: $('button#button_code_association').data('urlajax'),
    data: {
      ajax: true,
      codeAsso: $('input[name="code_association"]').val() 
    },
    complete(data) {
      response = JSON.parse(data.responseText);
      $('span.code_association_price').text(response.amount);
      if (response.freedone === true) {
        $('span.asso_freedone').show();
        $('span.asso_autre').hide();
      } else {
        $('span.asso_freedone').hide();
        $('span.asso_autre').show();
      }
    },
    error(err) {
      console.log(err);
    },
  });
}