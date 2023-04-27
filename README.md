# Terminal-based To-Do List
This is a simple linux-terminal-based to-do list program that maintains a file called tasks.txt. You can use it to add, update, and delete tasks from your list, as well as display all the tasks currently in your list.

## Usage
To run the program, download and navigate to the directory containing these files in your terminal, and type:

```
./t [command] [arguments]
```

Where [command] is one of the following:


* `add`: Adds a new task to your list.
* `update`: Updates an existing task in your list.
* `delete`: Deletes a task from your list.
* `disp`: Displays all the tasks in your list.
* `help`: Displays help information for the program.

And [arguments] depends on the command you choose:

* `add [id] [name-of-event] [date]`
* `update [id] [name-of-event] [date]`
* `delete [id]`

## Examples
Here are some examples of how you can use the program:

To add a new task to your list:

```
./t add 1 "Finish NPTEL" 2023-04-28
```

To update an existing task:

```
./t update 1 "Finish Coursera" 2023-04-29
```

To delete a task from your list:

```
./t delete 1
```

To display all the tasks in your list:

```
./t disp
```

To display the man page:

`./t --help` or `./t -h`

## Notes
The id argument for add and update must be a positive integer, and it should be unique among all the tasks in your list.
The date argument for add and update should be in the format YYYY-MM-DD.
If you try to update or delete a task that does not exist, the program will display an error message.
