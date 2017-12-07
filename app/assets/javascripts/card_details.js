var cards = document.body.querySelectorAll('.invoice-card');

cards.forEach(function(card) {
  var details = card.querySelector('.box-details');
  var box     = card.querySelector('.box-has-details');
  var caret   = card.querySelector('span.caret-right i')

  box.addEventListener("click", function(event) {
    details.classList.toggle("hidden");
    details.classList.toggle("swing-in-top-fwd");
    caret.classList.toggle("has-text-grey-light");
    caret.classList.toggle("rotate-90-bl-cw-on");
  });
});
