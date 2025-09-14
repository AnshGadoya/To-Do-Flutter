const ToDoService = require('../services/todo.services');

exports.createtodo = async (req, res) => {
    const { userId,title,desc } = req.body;

    let todo = await ToDoService.createTodo(userId, title, desc);

    res.json({status:true,success: todo})
}