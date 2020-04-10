<template>
  <div>
    <div class="flex justify-center">
      <div class="w-full bg-gray-900">
        <div class="flex rounded-lg shadow-xl overflow-hidden p-4 w-full flex-between items-center">
          <label class="inline-flex items-center">
            <input
              type="checkbox"
              class="form-checkbox text-pink-600 h-6 w-6 border border-pink-600 bg-transparent cursor-pointer mr-3"
              :checked="todo.completed"
              @change="toggleTodoCompleted">
          </label>
          <h1 class="text-indigo-400 text-3xl flex-1">
            {{ todo.title }}
          </h1>
        </div>
      </div>
    </div>
    <div class="flex flex-wrap mt-4 bg-gray-900 p-4">
      <div class="w-full" v-if="!editing">
        <form class="w-full">
          <div class="md:flex md:items-center mb-6">
            <div class="w-1/5">
              <label class="block text-gray-500 font-semibold md:text-right mb-1 md:mb-0 pr-4" for="inline-full-name">
                Assigned To
              </label>
            </div>
            <a href="#" class="flex items-center mr-2" v-for="user in assignees" v-if="todo && todo.assignments.length > 0" @click="editing = true">
              <div class="rounded-full bg-blue-600 text-blue-100 flex h-6 text-xs w-6 justify-center items-center mr-2">
                <span>{{ userInitials(user) }}</span>
              </div>
              <span class="text-gray-500">{{ user.name }}</span>
            </a>
          </div>
          <div class="md:flex md:items-center mb-6">
            <div class="w-1/5">
              <label class="block text-gray-500 font-bold md:text-right mb-1 md:mb-0 pr-4" for="inline-username">
                When completed, notify:
              </label>
            </div>
            <div class="flex items-center mr-2" v-for="user in notifiees" v-if="todo && todo.completed_subscribers.length > 0">
              <div class="rounded-full bg-blue-600 text-blue-100 flex h-6 text-xs w-6 justify-center items-center mr-2" @click="editing = true">
                <span>{{ userInitials(user) }}</span>
              </div>
              <span class="text-gray-500">{{ user.name }}</span>
            </div>
          </div>
          <div class="flex items-center mb-6">
            <div class="w-1/5">
              <label class="block text-gray-500 font-semibold md:text-right mb-1 md:mb-0 pr-4" for="inline-full-name">
                Due on
              </label>
            </div>
            <a href="#" @click.prevent="editing = true" class="w-2/3 block text-gray-500 font-bold">
              <i class="fa fa-calendar text-2xl text-green-700 mr-1"></i>
              <span class="text-sm">
                {{ formatTime(todo.due_on) }}
              </span>
            </a>
          </div>
          <div class="flex items-center mb-6">
            <div class="w-1/5">
              <label class="block text-gray-500 font-semibold md:text-right mb-1 md:mb-0 pr-4" for="inline-full-name">
                Notes
              </label>
            </div>
            <div class="w-2/3 block text-gray-500">
              <div class="trix-content" v-html="todo.description" v-if="todo.description"></div>
              <a href="#" @click.prevent="editing = true">add extra details or attach file</a>
            </div>
          </div>
        </form>
      </div>
      <div class="w-full" v-if="editing">
        <todo-form :form="form" :assignees="possibleUsers" :notifiees="possibleUsers">
          <div class="px-12">
            <button class="btn btn-green btn-sm" @click.prevent="createTodo">Save Changes</button>
            <button @click.prevent="editing = false" class="btn btn-gray btn-sm">Nevermind</button>
          </div>
        </todo-form>
      </div>
    </div>
  </div>
</template>

<script>
  import Layout from '@/Layouts/Main'
  import TodoForm from '@/Pages/Todos/TodoForm'

  export default {
    layout: Layout,
    components: {
      TodoForm,
    },
    props: {
      todo: {
        type: Object,
        required: true
      },
      possibleUsers: {
        type: Array,
        required: false,
        default: []
      }
    },
    data() {
      return {
        editing: false,
        form: {
          title: this.todo.title,
          description: this.todo.description,
          assignees: [],
          notifiees: [],
          due_on: null,
          starts_on: null,
          todo_list_id: this.todo.todo_list_id
        }
      }
    },
    mounted() {
      this.form.assignees = this.assignees
      this.form.notifiees = this.notifiees
      this.form.due_on = this.dueOn
      this.form.starts_on = this.startsOn
    },
    computed: {
      dueOn() {
        return this.todo.due_on ? moment(this.todo.due_on).format("YYYY-MM-DD") : null
      },
      startsOn() {
        return this.todo.starts_on ? moment(this.todo.starts_on).format("YYYY-MM-DD") : null
      },
      assignees() {
        return this.todo.assignments.map(a => a.assignee)
      },
      notifiees() {
        return this.todo.completed_subscribers.map(a => a.user)
      },
      currentBucket() {
        return this.$page.current_bucket
      },
      todoList() {
        return this.todo ? this.todo.todo_list : null
      }
    },
    methods: {
      toggleTodoCompleted() {
        this.todo.completed = !!this.todo.completed
      },
      formatTime(time) {
        return time ? moment(time).format('ddd, MMM D') : "N/A"
      },
      userInitials(user) {
        let parts = user.name.split(' ')
        return parts.map(p => p[0]).join('')
      },
    },
  }
</script>
