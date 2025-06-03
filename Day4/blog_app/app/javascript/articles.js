// Validate image uploads
document.addEventListener("change", function (event) {
  if (event.target.type === "file" && event.target.accept.includes("image")) {
    const file = event.target.files[0];
    const maxSize = parseInt(event.target.dataset.maxFileSize);

    if (file) {
      // Check file size
      if (file.size > maxSize) {
        alert("File size must be less than 5MB");
        event.target.value = ""; // Clear the file input
        return;
      }

      // Check file type
      const acceptedTypes = [
        "image/jpeg",
        "image/png",
        "image/gif",
        "image/webp",
      ];
      if (!acceptedTypes.includes(file.type)) {
        alert(
          "Invalid file type. Please upload a JPG, PNG, GIF, or WEBP image."
        );
        event.target.value = ""; // Clear the file input
        return;
      }
    }
  }
});
