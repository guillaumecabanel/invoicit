// $(document).ready(function(){
//   $('.invoice-card .box-has-details').on("click", function(){
//     $(this).parent().find('.box-details').slideToggle();
//   });
// });


const cards = document.body.querySelectorAll('.invoice-card');

cards.forEach((card) => {
  const details = card.querySelector('.box-details');
  const box = card.querySelector('.box-has-details');
  const caret = card.querySelector('span.caret-right i')

  box.addEventListener("click", (event) => {
    details.classList.toggle("hidden");
    details.classList.toggle("swing-in-top-fwd");
    caret.classList.toggle("has-text-grey-light");
    caret.classList.toggle("rotate-90-bl-cw-on");
  });
});
