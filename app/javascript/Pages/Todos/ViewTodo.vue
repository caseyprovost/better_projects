<template>
  <div>
    <div class="flex justify-center">
      <div class="w-full bg-gray-900">
        <div class="flex rounded-lg shadow-xl overflow-hidden p-4 w-full flex-between items-center">
          <h1 class="text-indigo-400 text-3xl flex-1">
            {{ todo.title }}
          </h1>
        </div>
      </div>
    </div>
    <div class="flex flex-wrap mt-4 bg-gray-900 p-4">
      stuff here
    </div>
  </div>
</template>

<script>
  import Layout from '@/Layouts/Main'

  export default {
    layout: Layout,
    components: {
    },
    props: {
      todo: {
        type: Object,
        required: true
      },
    },
    data() {
      return {
        creatingTodo: false,
      }
    },
    computed: {
      currentBucket() {
        return this.$page.current_bucket
      },
      todoList() {
        return this.todo ? this.todo.todo_list : null
      }
    },
    methods: {
    },
  }
</script>
