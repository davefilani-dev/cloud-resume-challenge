
fetch("https://tfp8whs54b.execute-api.us-east-1.amazonaws.com/prod/visitor") // we’ll replace later
  .then(response => response.json())
  .then(data => {
    document.getElementById("counter").innerText = data.count;
  })
  .catch(err => console.error(err));
