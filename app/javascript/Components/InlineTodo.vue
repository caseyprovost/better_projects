<template>
  <div class="flex w-full">
    <label class="inline-flex items-center">
      <input
        type="checkbox"
        class="form-checkbox text-pink-600 h-4 w-4 border border-pink-600 bg-transparent cursor-pointer"
        :checked="todo.completed"
        @change="toggleTodoCompleted(todo)">
    </label>
    <inertia-link :href="$routes.bucket_todo(bucket, todo)" class="mx-2">{{ todo.title }}</inertia-link>
    <div class="flex items-center" v-if="todo.due_on">
      <i v-if="overdue(todo)" class="fa fa-calendar mr-1 text-red-600"></i>
      <i v-if="!overdue(todo)" class="fa fa-calendar mr-1 text-gray-600"></i>
      <span v-if="overdue(todo)" class="text-red-600">{{ formatTime(todo.due_on) }}</span>
      <span v-if="!overdue(todo)" class="text-gray-400">{{ formatTime(todo.due_on) }}</span>
    </div>
    <div class="flex" v-if="todo.assignees.length > 0">
      <div v-for="assignee in todo.assignees">
        {{ assignee.name }}
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      todo: {
        type: Object,
        required: true
      },
      bucket: {
        type: Object,
        required: true
      }
    },
    methods: {
      overdue(todo) {
        let today = moment()
        let dueDate = moment(todo.due_on)
        if (todo.completed) return false

        return dueDate.isBefore(today)
      },
      formatTime(time) {
        return moment(time).format('ddd MMM D')
      },
    }
  }
</script>
