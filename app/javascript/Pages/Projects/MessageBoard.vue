<template>
  <div>
    <div class="flex justify-center">
      <div class="w-full bg-gray-900">
        <div class="flex rounded-lg shadow-xl overflow-hidden p-4 w-full flex-between items-center">
          <h1 class="text-indigo-400 text-3xl flex-1">
            Message Board
          </h1>
          <inertia-link
            :href="this.$routes.new_project_message(project)"
            class="btn btn-indigo"
          >
            New Message
          </inertia-link>
        </div>
      </div>
    </div>
    <div class="flex">
      <div class="w-full flex flex-wrap mt-4">
        <inertia-link
          v-for="message in messages"
          :href="messagePath(message)"
          class="bg-gray-900 rounded-lg shadow-xl p-4 w-full border border-transparent items-center mt-2 block hover:cursor-pointer hover:border-pink-600"
        >
          <h3 class="text-gray-500 flex-1">
            {{ message.subject }}
          </h3>
          <p class="flex-1">
            {{ message.content_preview }}
          </p>
        </inertia-link>
      </div>
    </div>
  </div>
</template>

<script>
  import Layout from '@/Layouts/Main'
  import currentProject from '@/utils/currentProject'

  export default {
    layout: Layout,
    components: {
    },
    mixins: [currentProject],
    props: {
      messages: {
        type: Array,
        required: true,
      },
    },
    computed: {
      project() {
        return this.$page.current_project
      },
    },
    methods: {
      messagePath(message) {
        return this.$routes.project_message(this.project, message)
      },
    },
  }
</script>
