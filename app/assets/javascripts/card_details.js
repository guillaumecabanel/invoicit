const cards = document.body.querySelectorAll('.invoice-card');

cards.forEach((card) => {
  const details = card.querySelector('.box-details');
  const box = card.querySelector('.box-has-details');

  box.addEventListener("click", (event) => {
    details.classList.toggle("hidden");
  });
});
