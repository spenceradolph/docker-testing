import express from 'express';

export const app = express();

app.use('/', express.static(`${__dirname}/build`)); // Expected to be put there by the root build script

app.get('/api', (req, res) => {
	res.send('hello from server api...');
});
