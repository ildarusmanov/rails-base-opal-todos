require 'opal-jquery'

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

    Element.find('#todos div').on :click do |e|
      drop e.current_target.html
    end
  end
end

Document.ready? do
  todos = TodoList.new

  Element.find('#add_todo').on :click do
    todos.add
  end
end
