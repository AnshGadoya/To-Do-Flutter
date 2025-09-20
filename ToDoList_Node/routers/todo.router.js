const router = require('express').Router();
const todocontroller = require('../controller/todo.controller');


router.post('/storeToDo',todocontroller.createtodo);

router.post('/getUserTodoList',todocontroller.getUserTodo);

router.post('/deleteTodo',todocontroller.deleteTodo);


module.exports = router;