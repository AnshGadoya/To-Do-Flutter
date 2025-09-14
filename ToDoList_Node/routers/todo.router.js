const router = require('express').Router();
const todocontroller = require('../controller/todo.controller');


router.post('/storeToDo',todocontroller.createtodo);


module.exports = router;