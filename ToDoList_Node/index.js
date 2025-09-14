const app = require('./app');
const db = require('./config/db');
const userModel = require('./model/user.model');
const todoModel = require('./model/todo.model');

const port = 3000;

// Start the server
app.get('/',(req,res) =>{
    res.send('Hello World!....sfafdaf..');
})

app.listen(port, () => {
  console.log(`Server is running on port http://localhost:${port}`);
});