// Function to generate TOKEN
function generateToken(length = 150) {
  const date = Date.now();
  const characters = `ABCDEFGHIJKLMNOPQRSTUVWXYZ${date}abcdefghijklmnopqrstuvwxyz0123456789`;
  let token = "";

  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    token += characters.charAt(randomIndex);
  }

  return token; // Return the generated token as a string
}

// Function to generate UID
function generateUID(length = 15) {
  const date = Date.now();
  const characters = `${date}0123456789`;
  let uid = "";

  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    uid += characters.charAt(randomIndex);
  }

  return uid; // Return the generated UID as a string
}

module.exports = { generateToken, generateUID };
