# Opal...nice to meet you!

## What is Opal?

"Opal is a ruby to javascript compiler. It is source-to-source, making it fast as a runtime. Opal includes a compiler (which can be run in any browser), a corelib and runtime implementation. The corelib/runtime is also very small (10.8kb gzipped)." Сс) opalrb.org

Opal is hosted on github and documentation for that can be found on https://github.com/opal/opal.

## Why Opal needs?

I think it is good idea to use single language to write you application server side and client side.
And it is better when you are using beautiful Ruby.

I think the best way to understand how it works - write some client side application with Opal.
Let`s get it on.

## Application

We are will write simple todos application based on one class. This class must can to add, drop and render todos to us.

## Setup Opal

Installation very easy. You can find instructions on https://github.com/opal/opal-rails.

## Writing todos

First I have used for http://github.com/fs/rails-base for setup simple Rails 4 application. You can use it too.
After that you need to setup Opal. You can find above how to do that.

Now when we have working Rails 4 skeleton application. We can write first lines of code.

Create controller with some action and create some file with *.js.opal extension and write that code.

```
require 'opal-jquery' # add jquery support

puts "Hello world!(console)" # output to console

Element.find('body').html = "Hello world!"
```
Do not forget to require that from assets/javascripts/application.js
Sstart your server and open application in browser.
In console you must see "Hello world!(console)" and in body of you page must be "Hello world!".

More info about supported functionality you can find on opalrb.org.

Now we can start writing our todos, because all what we need is Ruby :)

I have been created simple view for todos with Slim(app/views/dashboard/index.html.slim)
```
- title "Todos"

.view
  .add_form
    input type="text" id="new_todo" class="span10" placeholder="Type todo..."
    br
    button id="add_todo" class="btn btn-success" ="Add new todo item"

  div id="todos"
```

There are we have simple form and div element for todos list.

And I have writed simple class on Ruby that can to save todos into array and remove it form that.
For each action have been created add and drop methods. We need one method to render pur todos into our div#todos element.

Below you can see my class
```
class TodoList
  def initialize
    @todos = []
  end

  def add
   @todos << Element.find('input#new_todo').value
   @todos.uniq!
   Element.find('input#new_todo').value = ""
   render
  end

  def drop(todo)
    @todos.delete todo
    render
  end

  def render
    Element.find('#todos').html = ""

    @todos.each do |todo|
      Element.find('#todos').append('<div class="todo">' + todo + '</div>')
    end
    # binding click event to drop
    Element.find('#todos div').on :click do |e|
      drop e.current_target.html #remove by title of todo
    end
  end
end
```
Now we need to initialize this after document.ready, we need some like this js construction:
```
$(document).ready(function(){
  //Some code
})
```

And opal support that
```
Document.ready? do
  todos = TodoList.new

  Element.find('#add_todo').on :click do
    todos.add
  end
end
```

Let`s try to start this and play with that.
You can find more info about Opal on opalrb.org
