const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('<h1>Secure DevOps Platform v1.0 running successfully! 🚀</h1><p>Deployed automatically via Jenkins CI/CD.</p>');
});

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'UP', message: 'Application is healthy' });
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
