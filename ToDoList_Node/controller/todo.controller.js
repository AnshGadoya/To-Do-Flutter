const ToDoService = require('../services/todo.services');

exports.createtodo = async (req, res,next) => {
    try {
    const { userId,title,desc } = req.body;

    let todo = await ToDoService.createtodo(userId, title, desc);
    console.log(todo, 'todo---->');

    res.json({status:true,success: todo})
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}


exports.getUserTodo = async (req, res,next) => {
    try {
    const { userId } = req.body;

    let newtodo = await ToDoService.getTodoData(userId);
    console.log(newtodo, 'todo---->');

    res.json({status:true,success: newtodo})
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}


exports.deleteTodo = async (req, res,next) => {
    try {
    const { id } = req.body;

    let deleteItem = await ToDoService.deleted(id);
    console.log(deleteItem, 'todo---->');

    res.json({status:true,success: deleteItem})
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}