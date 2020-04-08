<template>
  <div>
    <div class="flex justify-center">
      <div class="w-full bg-gray-900">
        <div class="flex rounded-lg shadow-xl overflow-hidden p-4 w-full flex-between items-center">
          <h1 class="text-indigo-400 text-3xl flex-1">
            {{ todo_list.title }}
          </h1>
        </div>
      </div>
    </div>
    <div class="flex flex-wrap mt-4 bg-gray-900 p-4">
      <ul class="message-meta text-gray-500 leading-normal text-purple-700 ml-5 w-full" v-if="todo_list.todos.length > 0">
        <li v-for="todo in todo_list.todos" class="flex w-full items-center mb-1">
          <inline-todo :todo="todo" :bucket="currentBucket" />
        </li>
      </ul>
      <div class="ml-4 bg-purple-800 rounded py-4" v-if="creatingTodo">
        <todo-form :form="todoForm" :assignees="assignees" :notifiees="notifiees">
          <div class="px-12">
            <button class="btn btn-green btn-sm" @click.prevent="createTodo">Add this to-do</button>
            <button @click.prevent="creatingTodo = false" class="btn btn-gray btn-sm">Nevermind</button>
          </div>
        </todo-form>
      </div>
      <a href="#" @click="creatingTodo = true" v-if="!creatingTodo" class="btn btn-teal btn-sm mt-2 ml-5">
        Add a to-do
      </a>
    </div>
  </div>
</template>

<script>
  import Layout from '@/Layouts/Main'
  import TodoForm from '@/Pages/Todos/TodoForm'
  import InlineTodo from '@/Components/InlineTodo'

  export default {
    layout: Layout,
    components: {
      TodoForm,
      InlineTodo
    },
    props: {
      todo_list: {
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
        creatingTodo: false,
        todoForm: {
          title: null,
          description: null,
          assignees: [],
          notifiees: [],
          due_on: null,
          starts_on: null,
          todo_list_id: this.todo_list.id
        }
      }
    },
    computed: {
      currentBucket() {
        return this.$page.current_bucket
      },
    },
    methods: {
      createTodo() {
        this.sending = true
        let data = this.todoForm
        data.starts_on = data.starts_on ? moment(data.starts_on).format("YYYY-MM-DD") : null
        data.due_on = data.due_on ? moment(data.due_on).format("YYYY-MM-DD") : null
        data.notifiee_ids = data.notifiees.map(u => u.id)
        data.assignee_ids = data.assignees.map(u => u.id)

        this.$inertia.post(this.$routes.bucket_todos(this.currentBucket), data).then(() => {
          this.sending = false
          if (Object.keys(this.$page.errors).length === 0) {
            this.todoForm = {}
            this.$emit('success')
            this.creatingTodo = false
          }
        })
      },
      toggleTodoCompleted(todo) {
        this.sending = true

        this.$inertia.post(this.$routes.bucket_todo_completion(this.currentBucket, todo)).then(() => {
          this.sending = false
          if (Object.keys(this.$page.errors).length === 0) {
            this.$emit('success')
          }
        })
      }
    },
  }
</script>
