const express = require('express');
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');
const bonjour = require('bonjour')();

const jwtSecret = process.env.JWT_SECRET;

if (!jwtSecret) {
    console.error('JWT secret key is not provided in environment variables.');
    process.exit(1);
}

const app = express();
const port = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.post('/login', (req, res) => {
    const { email, password } = req.body;
    const token = jwt.sign({ email }, jwtSecret, { expiresIn: '1h' });

    res.json({ token });
});

app.post('/refresh', (req, res) => {
    const { email } = req.body;

    const newToken = jwt.sign({ email }, jwtSecret, { expiresIn: '1h' });
    res.json({ token: newToken });
});

app.get('/info', (req, res) => {
    res.json({ server: 'my-node-server', status: 'active' });
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);

    bonjour.publish({ name: 'my-node-server', type: 'http', port: port });
});