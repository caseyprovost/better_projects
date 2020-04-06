<template>
  <div>
    <div class="flex justify-center">
      <div class="w-full bg-gray-900">
        <div class="flex rounded-lg shadow-xl overflow-hidden p-4 w-full flex-between items-center">
          <h1 class="text-indigo-400 text-3xl flex-1">
            {{ todo_set.title }}
          </h1>
          <a
            href="#"
            @click.prevent="creatingList = true"
            class="btn btn-indigo"
            v-if="todo_set.todo_lists.length > 0"
          >
            New List
          </a>
        </div>
      </div>
    </div>
    <div class="flex flex-wrap mt-4 bg-gray-900 p-4">
      <div class="w-3/4" v-if="creatingList">
        <div class="border border-gray-700 rounded p-2 m-2">
          <todo-list-form :form="listForm" @submit="createList">
            <div class="mt-2 px-2 pb-2">
              <button class="btn btn-indigo btn-sm">Add this list</button>
              <button @click.prevent="creatingList = false" class="btn btn-blue-outline btn-sm">Nevermind</button>
            </div>
          </todo-list-form>
        </div>
      </div>
      <div class="w-full flex flex-wrap mt-4" v-if="todo_set.todo_lists.length > 0">
        <div
          v-for="todo_list in todo_set.todo_lists"
          :key="todo_list.id"
          class="mt-2 w-full"
        >
          <div class="w-full rounded-lg shadow-xl p-4 w-full border border-transparent items-center block hover:cursor-pointer  bg-indigo-900">
            <h3 class="text-gray-500 flex-1 leading-normal font-semibold">
              <span>{{ todo_list.title }}</span>
            </h3>
            <ul class="message-meta text-gray-500 leading-normal text-purple-700" v-if="todo_list.todos.length > 0">
              <li v-for="todo in todo_list.todos">
                {{ todo.title }}
              </li>
            </ul>
          </div>
          <div class="ml-4" v-if="creatingTodo">
            <todo-form :form="todoForm" :assignees="assignees" :notifiees="notifiees">
              <div class="px-12">
                <button class="btn btn-indigo btn-sm" @click.prevent="createTodo">Add this to-do</button>
                <button @click.prevent="closeTodoForm" class="btn btn-blue-outline btn-outline btn-sm">Nevermind</button>
              </div>
            </todo-form>
          </div>
          <a href="#" @click="openTodoForm(todo_list)" v-if="!creatingTodo" class="btn btn-outline btn-teal-outline mt-4">
            Add a to-do
          </a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import Layout from '@/Layouts/Main'
  import TodoListForm from '@/Pages/TodoLists/TodoListForm'
  import TodoForm from '@/Pages/Todos/TodoForm'

  export default {
    layout: Layout,
    components: {
      TodoListForm,
      TodoForm
    },
    props: {
      todo_set: {
        type: Object,
        required: true
      },
      assignees: {
        type: Array,
        required: true,
      },
      notifiees: {
        type: Array,
        required: true,
      }
    },
    data() {
      return {
        creatingList: this.todo_set.todo_lists.length == 0,
        creatingTodo: false,
        listForm: {
          title: null,
          description: null,
          todo_set_id: this.todo_set.id,
        },
        todoForm: {
          title: null,
          description: null,
          assignees: [],
          notifiees: [],
          due_on: null,
          starts_on: null,
          todo_list_id: null
        }
      }
    },
    computed: {
      currentBucket() {
        return this.$page.current_bucket
      }
    },
    methods: {
      openTodoForm(todoList) {
        this.todoForm.todo_list_id = todoList.id
        this.creatingTodo = true
      },
      closeTodoForm() {
        this.todoForm.todo_list_id = null
        this.creatingTodo = false
      },
      createList() {
        this.sending = true

        this.$inertia.post(this.$routes.bucket_todo_lists(this.currentBucket), this.listForm).then(() => {
          this.sending = false
          if (Object.keys(this.$page.errors).length === 0) {
            this.listForm = {}
            this.$emit('success')
          }
        })
      },
      createTodo() {
        this.sending = true
        let data = this.todoForm
        data.starts_on = data.starts_on ? moment(data.starts_on).format("YYYY-MM-DD") : null
        data.due_on = data.due_on ? moment(data.due_on).format("YYYY-MM-DD") : null

        this.$inertia.post(this.$routes.bucket_todos(this.currentBucket), data).then(() => {
          this.sending = false
          if (Object.keys(this.$page.errors).length === 0) {
            this.listForm = {}
            this.$emit('success')
          }
        })
      },
    },
  }
</script>
