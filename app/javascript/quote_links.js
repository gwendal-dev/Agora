document.addEventListener("DOMContentLoaded", function () {
  // Attacher un événement de clic à tous les liens avec la classe 'quote-link'
  document.querySelectorAll(".quote-link").forEach(function (link) {
    link.addEventListener("click", function (event) {
      event.preventDefault(); // Empêcher le lien de suivre l'URL

      // Récupérer les données nécessaires stockées dans les attributs data-*
      const messageId = this.dataset.messageId;
      const content = this.dataset.content;
      const username = this.dataset.username;
      const date = this.dataset.date;

      // Construire le format de la citation
      const formattedQuote = `${username} said on ${date}: "${content}"`;

      // Créer un élément de div pour afficher le message cité
      const quoteContainer = document.createElement("div");
      quoteContainer.classList.add("quoted-message");
      quoteContainer.textContent = formattedQuote;

      // Ajouter le conteneur de citation au-dessus du formulaire
      const formContainer = document.querySelector(".new-message-form");
      formContainer.parentNode.insertBefore(quoteContainer, formContainer);

      // Faire défiler jusqu'au formulaire pour une meilleure expérience utilisateur
      formContainer.scrollIntoView({
        behavior: "smooth",
        block: "start", // Faire défiler jusqu'au début du formulaire
      });

      // Mettre à jour le champ caché dans le formulaire avec l'ID du message cité
      const quoteIdInput = document.getElementById("quote_id");
      if (quoteIdInput) {
        quoteIdInput.value = messageId;
      } else {
        console.error("Hidden input for quote_id not found");
      }
    });
  });
});
