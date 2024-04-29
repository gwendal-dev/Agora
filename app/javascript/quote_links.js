document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll(".quote-link").forEach((link) => {
    link.addEventListener("click", function (event) {
      event.preventDefault(); // Prevent the default anchor behavior
      const content = this.getAttribute("data-content");
      const username = this.getAttribute("data-username");
      const date = this.getAttribute("data-date");
      const formattedQuote = `${username}, posted on ${date}\n${content}`; // Format the quote
      document.querySelector(".message-content-textarea").value =
        formattedQuote;
      document
        .querySelector(".new-message-form")
        .scrollIntoView({ behavior: "smooth" }); // Smoothly scroll to the message form
    });
  });
});
