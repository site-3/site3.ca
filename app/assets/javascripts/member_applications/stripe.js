$(function() {
  var $form = $('#new_member_application');

  $form.submit(function(event) {
    event.preventDefault();

    // Disable the submit button to prevent repeated clicks:
    $form.find('input[type=submit]').prop('disabled', true);

    // Request a token from Stripe:
    Stripe.card.createToken($form, stripeResponseHandler);

    // Prevent the form from being submitted:
    return false;
  });
});

function stripeResponseHandler(status, response) {
  var $form = $('#new_member_application');

  if (response.error) {

    // Show the errors on the form:
    $form.find('.payment-details').addClass('has-error');
    $form.find('.payment-errors').text(response.error.message);
    $form.find('input[type=submit]').prop('disabled', false); // Re-enable submission

  } else {

    // Insert the token ID into the form so it gets submitted to the server:
    $form.find('input[name="member_application[stripe_payment_token]"]').val(response.id);

    // Submit the form:
    $form.get(0).submit();
  }
};
