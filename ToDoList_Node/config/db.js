const mongoose = require('mongoose');

const connection = mongoose.createConnection('mongodb://localhost:27017/newToDo').on('connected', () => {
    console.log('Connected to MongoDB');
}).on('error', () => {
    console.error('Failed to connect to MongoDB');
});

module.exports = connection;