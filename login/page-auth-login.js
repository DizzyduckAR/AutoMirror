

$(function () {
  'use strict';

  var pageLoginForm = $('.auth-login-form');

  // jQuery Validation
  // --------------------------------------------------------------------
  if (pageLoginForm.length) {
    pageLoginForm.validate({
      /*
      * ? To enable validation onkeyup
      onkeyup: function (element) {
        $(element).valid();
      },*/
      /*
      * ? To enable validation on focusout
      onfocusout: function (element) {
        $(element).valid();
      }, */
      rules: {
        'login-email': {
          required: true,
          email: true
        },
        'login-password': {
          required: true
        }
      }
    });
  }
});
