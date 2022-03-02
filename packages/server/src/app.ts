import express from 'express';

export const app = express();

app.get('/api', (req, res) => {
	res.send('hello from server api...');
});
