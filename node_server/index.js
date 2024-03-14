const express = require('express');

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.listen(2000, () => {
    console.log('Server is running on port 2000');
});


const registerData = [];
app.post('/api/register_account', (req, res) => {
    console.log('Registering account');

    const data = {
        'email': req.body.email,
        'password': req.body.password,
        'phoneNumber': req.body.phoneNumber,
        'sellerType': req.body.sellerType
    };

    registerData.push(data);
    console.log('data', registerData);

    res.status(200).send({ 'message': 'Account created successfully', 'status_code': 200, 'account': data });
});
