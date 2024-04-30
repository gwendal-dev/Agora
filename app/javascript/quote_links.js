document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll(".quote-link").forEach(function (link) {
    link.addEventListener("click", function (event) {
      event.preventDefault(); // Prevent the link from following the URL

      // Retrieve the necessary data stored in the data-* attributes
      const messageId = this.dataset.messageId;
      const content = this.dataset.content;
      const username = this.dataset.username;
      const date = this.dataset.date;

      // Regular expression to detect YouTube URLs
      const youtubeRegex =
        /(https?:\/\/(?:www\.)?youtube\.com\/watch\?v=|https?:\/\/youtu\.be\/)([a-zA-Z0-9_-]{11})/;
      const matches = content.match(youtubeRegex);
      let videoEmbed = "";
      let textContent = content;

      if (matches) {
        const videoId = matches[2];
        videoEmbed = `<iframe width="560" height="315" src="https://www.youtube.com/embed/${videoId}" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>`;
        textContent = content.replace(youtubeRegex, ""); // Remove the URL from the text content
      }

      // Create div elements to display the quoted message and video
      const quoteContainer = document.createElement("div");
      quoteContainer.classList.add("quoted-message");
      quoteContainer.innerHTML = `${videoEmbed}<br>${textContent}`;

      // Add the quote container above the form
      const formContainer = document.querySelector(".new-message-form");
      formContainer.parentNode.insertBefore(quoteContainer, formContainer);

      // Scroll to the form for a better user experience
      formContainer.scrollIntoView({
        behavior: "smooth",
        block: "start", // Scroll to the start of the form
      });

      // Update the hidden field in the form with the ID of the quoted message
      const quoteIdInput = document.getElementById("quote_id");
      if (quoteIdInput) {
        quoteIdInput.value = messageId;
      } else {
        console.error("Hidden input for quote_id not found");
      }
    });
  });
});
